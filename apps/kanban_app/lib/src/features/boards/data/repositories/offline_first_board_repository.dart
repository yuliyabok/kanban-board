import 'dart:async';

import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart' as result;
import '../../../../core/sync/sync_operation.dart';
import '../../../../core/sync/sync_outbox.dart';
import '../../domain/entities/board_entity.dart';
import '../../domain/repositories/board_repository.dart';
import '../datasources/board_local_datasource.dart';
import '../datasources/board_remote_datasource.dart';
import '../mappers/board_mapper.dart';

final class OfflineFirstBoardRepository implements BoardRepository {
  const OfflineFirstBoardRepository({
    required BoardLocalDataSource localDataSource,
    required BoardRemoteDataSource remoteDataSource,
    required SyncOutbox syncOutbox,
    required Uuid uuid,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _syncOutbox = syncOutbox,
       _uuid = uuid;

  final BoardLocalDataSource _localDataSource;
  final BoardRemoteDataSource _remoteDataSource;
  final SyncOutbox _syncOutbox;
  final Uuid _uuid;

  @override
  Stream<List<BoardEntity>> watchAll() => _localDataSource.watchAll();

  @override
  Stream<List<BoardEntity>> watchVisibleToUser(String userId) =>
      _localDataSource.watchVisibleToUser(userId);

  @override
  Future<result.Result<BoardEntity>> create(BoardEntity board) async {
    if (board.title.trim().isEmpty) {
      return const result.Error<BoardEntity>(
        ValidationFailure('Название доски не может быть пустым'),
      );
    }

    final now = DateTime.now().toUtc();
    final newBoard = BoardEntity(
      id: _uuid.v7(),
      ownerId: board.ownerId,
      workspaceId: board.workspaceId,
      title: board.title.trim(),
      description: board.description?.trim(),
      createdAt: now,
      updatedAt: now,
    );

    try {
      await _localDataSource.savePending(newBoard, 'create');
      await _localDataSource.addOwnerMembership(newBoard);
      unawaited(_pushCreate(newBoard));
      return result.Success(newBoard);
    } on Exception catch (error) {
      return result.Error<BoardEntity>(UnexpectedFailure(error.toString()));
    }
  }

  @override
  Future<result.Result<void>> delete(String boardId) async {
    try {
      await _localDataSource.delete(boardId);
      unawaited(_tryPushDelete(boardId));
      return const result.Success(null);
    } on Exception catch (error) {
      return result.Error<void>(UnexpectedFailure(error.toString()));
    }
  }

  @override
  Future<result.Result<BoardEntity>> update(BoardEntity board) async {
    if (board.title.trim().isEmpty) {
      return const result.Error<BoardEntity>(
        ValidationFailure('Название доски не может быть пустым'),
      );
    }

    final updatedBoard = BoardEntity(
      id: board.id,
      ownerId: board.ownerId,
      workspaceId: board.workspaceId,
      title: board.title.trim(),
      description: board.description?.trim(),
      createdAt: board.createdAt,
      updatedAt: DateTime.now().toUtc(),
      isSynced: false,
    );

    try {
      await _localDataSource.savePending(updatedBoard, 'update');
      unawaited(_pushUpdate(updatedBoard));
      return result.Success(updatedBoard);
    } on Exception catch (error) {
      return result.Error<BoardEntity>(UnexpectedFailure(error.toString()));
    }
  }

  Future<void> _pushCreate(BoardEntity board) async {
    try {
      final remoteBoard = await _remoteDataSource.create(board);
      await _localDataSource.save(remoteBoard);
      await _localDataSource.markSynced(board.id);
    } on Exception catch (error) {
      await _enqueue(
        board: board,
        action: SyncAction.create,
        error: error,
      );
      // Keep local state authoritative while background sync retries.
    }
  }

  Future<void> _pushUpdate(BoardEntity board) async {
    try {
      final remoteBoard = await _remoteDataSource.update(board);
      await _localDataSource.save(remoteBoard);
      await _localDataSource.markSynced(board.id);
    } on Exception catch (error) {
      await _enqueue(
        board: board,
        action: SyncAction.update,
        error: error,
      );
      // Keep local state authoritative while background sync retries.
    }
  }

  Future<void> _tryPushDelete(String boardId) async {
    try {
      await _remoteDataSource.delete(boardId);
      await _localDataSource.markSynced(boardId);
    } on Exception catch (error) {
      await _syncOutbox.enqueue(
        SyncOperation(
          id: _uuid.v7(),
          entityType: 'board',
          entityId: boardId,
          action: SyncAction.delete,
          payload: {'id': boardId},
          createdAt: DateTime.now().toUtc(),
          lastError: error.toString(),
        ),
      );
    }
  }

  Future<void> _enqueue({
    required BoardEntity board,
    required SyncAction action,
    required Object error,
  }) {
    return _syncOutbox.enqueue(
      SyncOperation(
        id: _uuid.v7(),
        entityType: 'board',
        entityId: board.id,
        action: action,
        payload: board.toApiJson(),
        createdAt: DateTime.now().toUtc(),
        lastError: error.toString(),
      ),
    );
  }
}
