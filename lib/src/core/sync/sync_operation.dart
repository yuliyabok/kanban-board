enum SyncAction {
  create,
  update,
  delete,
}

enum SyncOperationStatus {
  pending,
  inFlight,
  done,
  failed,
}

final class SyncOperation {
  const SyncOperation({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    required this.payload,
    required this.createdAt,
    this.retryCount = 0,
    this.status = SyncOperationStatus.pending,
    this.lastError,
  });

  final String id;
  final String entityType;
  final String entityId;
  final SyncAction action;
  final Map<String, Object?> payload;
  final DateTime createdAt;
  final int retryCount;
  final SyncOperationStatus status;
  final String? lastError;

  SyncOperation copyWith({
    int? retryCount,
    SyncOperationStatus? status,
    String? lastError,
    bool clearLastError = false,
  }) {
    return SyncOperation(
      id: id,
      entityType: entityType,
      entityId: entityId,
      action: action,
      payload: payload,
      createdAt: createdAt,
      retryCount: retryCount ?? this.retryCount,
      status: status ?? this.status,
      lastError: clearLastError ? null : lastError ?? this.lastError,
    );
  }
}
