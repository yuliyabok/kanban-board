import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../../core/theme/app_task_type_color_palette.dart';
import '../../domain/entities/task_type_entity.dart';
import '../../domain/repositories/task_type_repository.dart';
import '../datasources/task_type_local_datasource.dart';
import '../datasources/task_type_remote_datasource.dart';
import '../mappers/task_type_mapper.dart';

final class OfflineFirstTaskTypeRepository implements TaskTypeRepository {
  const OfflineFirstTaskTypeRepository({
    required TaskTypeLocalDataSource localDataSource,
    required TaskTypeRemoteDataSource remoteDataSource,
    required Uuid uuid,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _uuid = uuid;

  final TaskTypeLocalDataSource _localDataSource;
  final TaskTypeRemoteDataSource _remoteDataSource;
  final Uuid _uuid;

  @override
  Stream<List<TaskTypeEntity>> watchByBoard(String boardId) async* {
    await _ensureDefaults(boardId);
    yield* _localDataSource
        .watchByBoard(boardId)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<List<TaskTypeEntity>> getByBoard(String boardId) async {
    await _ensureDefaults(boardId);
    final rows = await _localDataSource.getByBoard(boardId);
    return rows.map((row) => row.toEntity()).toList(growable: false);
  }

  @override
  Future<Result<TaskTypeEntity>> create({
    required String boardId,
    required String name,
    required String color,
    required String icon,
    String? description,
  }) async {
    final validation = _validate(name: name, color: color);
    if (validation != null) return Error(validation);

    try {
      final now = DateTime.now().toUtc();
      final type = TaskTypeEntity(
        id: _uuid.v7(),
        boardId: boardId,
        name: name.trim(),
        color: color,
        icon: icon,
        description: description?.trim(),
        createdAt: now,
        updatedAt: now,
      );
      await _localDataSource.upsert(type.toCompanion(syncAction: 'create'));
      await _tryPushCreate(type);
      return Success(type);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      final type = await _localDataSource.getById(id);
      if (type == null) return const Success(null);
      final all = await getByBoard(type.boardId);
      if (all.length <= 1) {
        return const Error(
          ValidationFailure('Нельзя удалить последний тип задач'),
        );
      }
      final deletedAt = DateTime.now().toUtc();
      await _localDataSource.clearTaskTypeUsage(
        boardId: type.boardId,
        taskTypeId: id,
        updatedAt: deletedAt,
      );
      await _localDataSource.softDelete(id: id, deletedAt: deletedAt);
      await _tryPushDelete(id);
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<TaskTypeEntity>> update(TaskTypeEntity type) async {
    final validation = _validate(name: type.name, color: type.color);
    if (validation != null) return Error(validation);

    try {
      final updated = type.copyWith(
        name: type.name.trim(),
        description: type.description?.trim(),
        updatedAt: DateTime.now().toUtc(),
        isSynced: false,
      );
      await _localDataSource.upsert(updated.toCompanion(syncAction: 'update'));
      await _tryPushUpdate(updated);
      return Success(updated);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  Failure? _validate({
    required String name,
    required String color,
  }) {
    if (name.trim().isEmpty) {
      return const ValidationFailure('Название типа не может быть пустым');
    }
    if (name.trim().length > 50) {
      return const ValidationFailure('Название типа не длиннее 50 символов');
    }
    if (!AppTaskTypeColorPalette.isAllowed(color)) {
      return const ValidationFailure('Цвет типа должен быть из палитры');
    }
    return null;
  }

  Future<void> _ensureDefaults(String boardId) async {
    final existing = await _localDataSource.getByBoard(boardId);
    if (existing.isNotEmpty) return;
    await _seedDefaults(boardId);
  }

  Future<void> _seedDefaults(String boardId) async {
    final now = DateTime.now().toUtc();
    final defaults =
        [
          ('feature', 'Feature', 'blue', 'stars'),
          ('bug', 'Bug', 'red', 'bug_report'),
          ('research', 'Research', 'violet', 'science'),
          ('design', 'Design', 'pink', 'palette'),
          ('documentation', 'Documentation', 'slate', 'article'),
          ('meeting', 'Meeting', 'amber', 'groups'),
          ('personal', 'Personal', 'green', 'person'),
          ('urgent', 'Urgent', 'orange', 'priority_high'),
        ].map(
          (item) => TaskTypeEntity(
            id: '$boardId:${item.$1}',
            boardId: boardId,
            name: item.$2,
            color: item.$3,
            icon: item.$4,
            createdAt: now,
            updatedAt: now,
            isSynced: true,
          ).toCompanion(),
        );

    await _localDataSource.upsertAll(defaults.toList(growable: false));
  }

  Future<void> _tryPushCreate(TaskTypeEntity type) async {
    try {
      final remote = await _remoteDataSource.create(type.toDto());
      await _localDataSource.upsert(remote.toEntity().toCompanion());
    } on Exception {
      // Local type remains available and can be synced later.
    }
  }

  Future<void> _tryPushDelete(String id) async {
    try {
      await _remoteDataSource.delete(id);
    } on Exception {
      // Local tombstone remains available and can be synced later.
    }
  }

  Future<void> _tryPushUpdate(TaskTypeEntity type) async {
    try {
      final remote = await _remoteDataSource.update(type.toDto());
      await _localDataSource.upsert(remote.toEntity().toCompanion());
    } on Exception {
      // Local type remains available and can be synced later.
    }
  }
}
