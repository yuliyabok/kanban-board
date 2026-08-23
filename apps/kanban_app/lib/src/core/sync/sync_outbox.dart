// Очередь исходящих sync-операций. Drift-реализация переживает перезапуск
// приложения и дает retry worker стабильный список pending-операций.
import 'dart:convert';

import 'package:drift/drift.dart';

import '../database/app_database.dart';
import 'sync_operation.dart';

abstract interface class SyncOutbox {
  Future<void> enqueue(SyncOperation operation);

  Future<List<SyncOperation>> pending({int limit = 50});

  Future<void> markInFlight(String operationId);

  Future<void> markDone(String operationId);

  Future<void> markFailed({
    required String operationId,
    required String error,
  });
}

final class MemorySyncOutbox implements SyncOutbox {
  final List<SyncOperation> _operations = [];

  @override
  Future<void> enqueue(SyncOperation operation) async {
    _operations.add(operation);
  }

  @override
  Future<List<SyncOperation>> pending({int limit = 50}) async {
    return _operations
        .where((operation) => operation.status == SyncOperationStatus.pending)
        .take(limit)
        .toList(growable: false);
  }

  @override
  Future<void> markInFlight(String operationId) async {
    _replace(
      operationId,
      (operation) => operation.copyWith(status: SyncOperationStatus.inFlight),
    );
  }

  @override
  Future<void> markDone(String operationId) async {
    _replace(
      operationId,
      (operation) => operation.copyWith(
        status: SyncOperationStatus.done,
        clearLastError: true,
      ),
    );
  }

  @override
  Future<void> markFailed({
    required String operationId,
    required String error,
  }) async {
    _replace(
      operationId,
      (operation) => operation.copyWith(
        status: SyncOperationStatus.failed,
        retryCount: operation.retryCount + 1,
        lastError: error,
      ),
    );
  }

  void _replace(
    String operationId,
    SyncOperation Function(SyncOperation operation) update,
  ) {
    final index = _operations.indexWhere(
      (operation) => operation.id == operationId,
    );
    if (index == -1) return;
    _operations[index] = update(_operations[index]);
  }
}

/// Persistent sync outbox, хранящий операции в Drift базе.
/// Гарантирует надежную доставку изменений на сервер даже при перезагрузке приложения.
final class DriftSyncOutbox implements SyncOutbox {
  const DriftSyncOutbox(this._database);

  final AppDatabase _database;

  @override
  Future<void> enqueue(SyncOperation operation) async {
    await _database
        .into(_database.syncActionsTable)
        .insertOnConflictUpdate(
          SyncActionsTableCompanion(
            id: Value(operation.id),
            entityType: Value(operation.entityType),
            action: Value(operation.action.name),
            entityId: Value(operation.entityId),
            payload: Value(jsonEncode(operation.payload)),
            createdAt: Value(operation.createdAt),
            retryCount: Value(operation.retryCount),
            lastError: Value(operation.lastError),
            lastRetryAt: Value(DateTime.now().toUtc()),
          ),
        );
  }

  @override
  Future<List<SyncOperation>> pending({int limit = 50}) async {
    final query = _database.select(_database.syncActionsTable)
      ..orderBy([(action) => OrderingTerm.asc(action.createdAt)])
      ..limit(limit);

    final rows = await query.get();
    return rows
        .map(
          (row) => SyncOperation(
            id: row.id,
            entityType: row.entityType,
            entityId: row.entityId,
            action: SyncAction.values.byName(row.action),
            payload: jsonDecode(row.payload) as Map<String, Object?>,
            createdAt: row.createdAt,
            retryCount: row.retryCount,
            status: row.lastError != null
                ? SyncOperationStatus.failed
                : SyncOperationStatus.pending,
            lastError: row.lastError,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> markInFlight(String operationId) async {
    await (_database.update(
      _database.syncActionsTable,
    )..where((action) => action.id.equals(operationId))).write(
      SyncActionsTableCompanion(
        lastError: const Value(null),
        lastRetryAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> markDone(String operationId) async {
    await (_database.delete(
      _database.syncActionsTable,
    )..where((action) => action.id.equals(operationId))).go();
  }

  @override
  Future<void> markFailed({
    required String operationId,
    required String error,
  }) async {
    final query = _database.select(_database.syncActionsTable)
      ..where((action) => action.id.equals(operationId));
    final current = await query.getSingleOrNull();

    if (current == null) return;

    await (_database.update(
      _database.syncActionsTable,
    )..where((action) => action.id.equals(operationId))).write(
      SyncActionsTableCompanion(
        retryCount: Value(current.retryCount + 1),
        lastError: Value(error),
        lastRetryAt: Value(DateTime.now().toUtc()),
      ),
    );
  }
}
