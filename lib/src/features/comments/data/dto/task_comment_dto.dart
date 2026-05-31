final class TaskCommentDto {
  const TaskCommentDto({
    required this.id,
    required this.taskId,
    required this.authorId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TaskCommentDto.fromJson(Map<String, dynamic> json) => TaskCommentDto(
    id: json['id'] as String,
    taskId: json['taskId'] as String,
    authorId: json['authorId'] as String,
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    deletedAt: json['deletedAt'] == null
        ? null
        : DateTime.parse(json['deletedAt'] as String),
  );

  final String id;
  final String taskId;
  final String authorId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'taskId': taskId,
    'authorId': authorId,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'deletedAt': deletedAt?.toIso8601String(),
  };
}
