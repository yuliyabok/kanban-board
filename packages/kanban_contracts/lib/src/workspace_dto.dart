// Контракты workspace и участника workspace для app/server API.
final class WorkspaceDto {
  const WorkspaceDto({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkspaceDto.fromJson(Map<String, dynamic> json) {
    return WorkspaceDto(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
    };
  }
}

final class WorkspaceMemberDto {
  const WorkspaceMemberDto({
    required this.id,
    required this.workspaceId,
    required this.userId,
    required this.role,
    required this.joinedAt,
  });

  factory WorkspaceMemberDto.fromJson(Map<String, dynamic> json) {
    return WorkspaceMemberDto(
      id: json['id'] as String,
      workspaceId: json['workspaceId'] as String,
      userId: json['userId'] as String,
      role: json['role'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String workspaceId;
  final String userId;
  final String role;
  final DateTime joinedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'workspaceId': workspaceId,
      'userId': userId,
      'role': role,
      'joinedAt': joinedAt.toUtc().toIso8601String(),
    };
  }
}
