import '../../../permissions/domain/entities/permission.dart';

final class WorkspaceEntity {
  const WorkspaceEntity({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
  });

  final String id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;

  WorkspaceEntity copyWith({
    String? id,
    String? name,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) {
    return WorkspaceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}

final class WorkspaceMemberEntity {
  const WorkspaceMemberEntity({
    required this.id,
    required this.workspaceId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    this.isSynced = false,
  });

  final String id;
  final String workspaceId;
  final String userId;
  final WorkspaceRole role;
  final DateTime joinedAt;
  final bool isSynced;

  WorkspaceMemberEntity copyWith({
    String? id,
    String? workspaceId,
    String? userId,
    WorkspaceRole? role,
    DateTime? joinedAt,
    bool? isSynced,
  }) {
    return WorkspaceMemberEntity(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
