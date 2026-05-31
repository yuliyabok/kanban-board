import '../../../permissions/domain/entities/permission.dart';
import '../../domain/entities/workspace_entity.dart';

final class WorkspaceDto {
  const WorkspaceDto({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkspaceDto.fromJson(Map<String, dynamic> json) => WorkspaceDto(
    id: json['id'] as String,
    name: json['name'] as String,
    ownerId: json['ownerId'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  final String id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'ownerId': ownerId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

final class WorkspaceMemberDto {
  const WorkspaceMemberDto({
    required this.id,
    required this.workspaceId,
    required this.userId,
    required this.role,
    required this.joinedAt,
  });

  factory WorkspaceMemberDto.fromJson(Map<String, dynamic> json) =>
      WorkspaceMemberDto(
        id: json['id'] as String,
        workspaceId: json['workspaceId'] as String,
        userId: json['userId'] as String,
        role: WorkspaceRole.parse(json['role'] as String),
        joinedAt: DateTime.parse(json['joinedAt'] as String),
      );

  final String id;
  final String workspaceId;
  final String userId;
  final WorkspaceRole role;
  final DateTime joinedAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'workspaceId': workspaceId,
    'userId': userId,
    'role': role.name,
    'joinedAt': joinedAt.toIso8601String(),
  };
}

extension WorkspaceDtoMapper on WorkspaceDto {
  WorkspaceEntity toEntity() => WorkspaceEntity(
    id: id,
    name: name,
    ownerId: ownerId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isSynced: true,
  );
}

extension WorkspaceEntityDtoMapper on WorkspaceEntity {
  WorkspaceDto toDto() => WorkspaceDto(
    id: id,
    name: name,
    ownerId: ownerId,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
