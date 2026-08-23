// Контракты доски, колонки и типа задачи для app/server API.
final class BoardDto {
  const BoardDto({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.workspaceId,
    this.description,
    this.deletedAt,
  });

  factory BoardDto.fromJson(Map<String, dynamic> json) {
    return BoardDto(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      workspaceId: json['workspaceId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String ownerId;
  final String? workspaceId;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      if (workspaceId != null) 'workspaceId': workspaceId,
      'title': title,
      if (description != null) 'description': description,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      if (deletedAt != null) 'deletedAt': deletedAt!.toUtc().toIso8601String(),
    };
  }
}

final class BoardMemberDto {
  const BoardMemberDto({
    required this.id,
    required this.boardId,
    required this.userId,
    required this.role,
    required this.joinedAt,
  });

  factory BoardMemberDto.fromJson(Map<String, dynamic> json) {
    return BoardMemberDto(
      id: json['id'] as String,
      boardId: json['boardId'] as String,
      userId: json['userId'] as String,
      role: json['role'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String boardId;
  final String userId;
  final String role;
  final DateTime joinedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'boardId': boardId,
      'userId': userId,
      'role': role,
      'joinedAt': joinedAt.toUtc().toIso8601String(),
    };
  }
}

final class BoardColumnDto {
  const BoardColumnDto({
    required this.id,
    required this.boardId,
    required this.title,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory BoardColumnDto.fromJson(Map<String, dynamic> json) {
    return BoardColumnDto(
      id: json['id'] as String,
      boardId: json['boardId'] as String,
      title: json['title'] as String,
      position: json['position'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String boardId;
  final String title;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'boardId': boardId,
      'title': title,
      'position': position,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      if (deletedAt != null) 'deletedAt': deletedAt!.toUtc().toIso8601String(),
    };
  }
}

final class TaskTypeDto {
  const TaskTypeDto({
    required this.id,
    required this.boardId,
    required this.name,
    required this.color,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.deletedAt,
  });

  factory TaskTypeDto.fromJson(Map<String, dynamic> json) {
    return TaskTypeDto(
      id: json['id'] as String,
      boardId: json['boardId'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String boardId;
  final String name;
  final String color;
  final String icon;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'boardId': boardId,
      'name': name,
      'color': color,
      'icon': icon,
      if (description != null) 'description': description,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      if (deletedAt != null) 'deletedAt': deletedAt!.toUtc().toIso8601String(),
    };
  }
}
