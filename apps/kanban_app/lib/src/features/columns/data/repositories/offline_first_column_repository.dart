import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/sync/sync_operation.dart';
import '../../../../core/sync/sync_outbox.dart';
import '../../domain/entities/board_column_entity.dart';
import '../../domain/repositories/column_repository.dart';
import '../datasources/column_local_datasource.dart';
import '../datasources/column_remote_datasource.dart';
import '../mappers/board_column_mapper.dart';

final class OfflineFirstColumnRepository implements ColumnRepository {
  const OfflineFirstColumnRepository({
    required ColumnLocalDataSource localDataSource,
    required ColumnRemoteDataSource remoteDataSource,
    required SyncOutbox syncOutbox,
    required Uuid uuid,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _syncOutbox = syncOutbox,
       _uuid = uuid;

  final ColumnLocalDataSource _localDataSource;
  final ColumnRemoteDataSource _remoteDataSource;
  final SyncOutbox _syncOutbox;
  final Uuid _uuid;

  @override
  Stream<List<BoardColumnEntity>> watchByBoard(String boardId) {
    return _localDataSource
        .watchByBoard(boardId)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<List<BoardColumnEntity>> getByBoard(String boardId) async {
    final rows = await _localDataSource.getByBoard(boardId);
    return rows.map((row) => row.toEntity()).toList(growable: false);
  }

  @override
  Future<Result<BoardColumnEntity>> create({
    required String boardId,
    required String title,
    required int position,
    String? id,
  }) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      return const Error(
        ValidationFailure('Название столбца не может быть пустым'),
      );
    }
    if (trimmedTitle.length > 50) {
      return const Error(
        ValidationFailure('Название столбца не длиннее 50 символов'),
      );
    }

    try {
      final now = DateTime.now().toUtc();
      final column = BoardColumnEntity(
        id: id ?? _uuid.v7(),
        boardId: boardId,
        title: trimmedTitle,
        position: position,
        createdAt: now,
        updatedAt: now,
      );

      await _localDataSource.upsert(column.toCompanion(syncAction: 'create'));
      await _tryPushCreate(column);

      return Success(column);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> delete(String columnId) async {
    try {
      await _localDataSource.softDelete(
        id: columnId,
        deletedAt: DateTime.now().toUtc(),
      );
      await _tryPushDelete(columnId);
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> reorder(List<BoardColumnEntity> columns) async {
    try {
      final now = DateTime.now().toUtc();
      final companions = [
        for (var index = 0; index < columns.length; index++)
          columns[index]
              .copyWith(position: index, updatedAt: now, isSynced: false)
              .toCompanion(syncAction: 'update'),
      ];

      await _localDataSource.upsertAll(companions);
      for (final column in columns) {
        await _tryPushUpdate(
          column.copyWith(updatedAt: now, isSynced: false),
        );
      }

      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<BoardColumnEntity>> updateTitle({
    required String columnId,
    required String title,
  }) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      return const Error(
        ValidationFailure('Название столбца не может быть пустым'),
      );
    }
    if (trimmedTitle.length > 50) {
      return const Error(
        ValidationFailure('Название столбца не длиннее 50 символов'),
      );
    }

    try {
      final current = await _localDataSource.getById(columnId);
      if (current == null) {
        return const Error(StorageFailure('Столбец не найден'));
      }

      final column = current.toEntity().copyWith(
        title: trimmedTitle,
        updatedAt: DateTime.now().toUtc(),
        isSynced: false,
      );
      await _localDataSource.upsert(column.toCompanion(syncAction: 'update'));
      await _tryPushUpdate(column);

      return Success(column);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  Future<void> _tryPushCreate(BoardColumnEntity column) async {
    try {
      final remoteColumn = await _remoteDataSource.create(column.toDto());
      await _localDataSource.upsert(remoteColumn.toEntity().toCompanion());
      await _localDataSource.markSynced(column.id);
    } on Exception catch (error) {
      await _enqueue(
        column: column,
        action: SyncAction.create,
        error: error,
      );
      // Sync manager will retry later; the local draft is already committed.
    }
  }

  Future<void> _tryPushDelete(String columnId) async {
    try {
      await _remoteDataSource.delete(columnId);
      await _localDataSource.markSynced(columnId);
    } on Exception catch (error) {
      await _syncOutbox.enqueue(
        SyncOperation(
          id: _uuid.v7(),
          entityType: 'column',
          entityId: columnId,
          action: SyncAction.delete,
          payload: {'id': columnId},
          createdAt: DateTime.now().toUtc(),
          lastError: error.toString(),
        ),
      );
      // Local tombstone remains available for a later sync retry.
    }
  }

  Future<void> _tryPushUpdate(BoardColumnEntity column) async {
    try {
      final remoteColumn = await _remoteDataSource.update(column.toDto());
      await _localDataSource.upsert(remoteColumn.toEntity().toCompanion());
      await _localDataSource.markSynced(column.id);
    } on Exception catch (error) {
      await _enqueue(
        column: column,
        action: SyncAction.update,
        error: error,
      );
      // Local state stays authoritative until sync succeeds.
    }
  }

  Future<void> _enqueue({
    required BoardColumnEntity column,
    required SyncAction action,
    required Object error,
  }) {
    return _syncOutbox.enqueue(
      SyncOperation(
        id: _uuid.v7(),
        entityType: 'column',
        entityId: column.id,
        action: action,
        payload: column.toDto().toJson(),
        createdAt: DateTime.now().toUtc(),
        lastError: error.toString(),
      ),
    );
  }
}
