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
