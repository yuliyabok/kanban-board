final class TaskCommentEntity {
  const TaskCommentEntity({
    required this.id,
    required this.taskId,
    required this.authorId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.isSynced = false,
  });

  final String id;
  final String taskId;
  final String authorId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isSynced;

  TaskCommentEntity copyWith({
    String? id,
    String? taskId,
    String? authorId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool? isSynced,
  }) {
    return TaskCommentEntity(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
