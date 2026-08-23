// Контракты задач, комментариев и исполнителей для app/server API.
final class TaskDto {
  const TaskDto({
    required this.id,
    required this.boardId,
    required this.title,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.columnId,
    this.parentTaskId,
    this.taskTypeId,
    this.description,
    this.cardBackgroundColor,
    this.cardTextColor,
    this.depth = 0,
    this.status = 'todo',
    this.priority = 'medium',
    this.assigneeName,
    this.labels = const [],
    this.startDate,
    this.dueDate,
    this.completedAt,
    this.estimatedDurationMinutes,
    this.actualDurationMinutes,
    this.periodType = 'custom',
    this.isCompleted = false,
    this.deletedAt,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      id: json['id'] as String,
      boardId: json['boardId'] as String,
      columnId: json['columnId'] as String?,
      parentTaskId: json['parentTaskId'] as String?,
      taskTypeId: json['taskTypeId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      cardBackgroundColor: json['cardBackgroundColor'] as String?,
      cardTextColor: json['cardTextColor'] as String?,
      position: json['position'] as int,
      depth: json['depth'] as int? ?? 0,
      status: json['status'] as String? ?? 'todo',
      priority: json['priority'] as String? ?? 'medium',
      assigneeName: json['assigneeName'] as String?,
      labels: (json['labels'] as List<dynamic>? ?? const []).cast<String>(),
      startDate: _date(json['startDate']),
      dueDate: _date(json['dueDate']),
      completedAt: _date(json['completedAt']),
      estimatedDurationMinutes: json['estimatedDurationMinutes'] as int?,
      actualDurationMinutes: json['actualDurationMinutes'] as int?,
      periodType: json['periodType'] as String? ?? 'custom',
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deletedAt: _date(json['deletedAt']),
    );
  }

  final String id;
  final String boardId;
  final String? columnId;
  final String? parentTaskId;
  final String? taskTypeId;
  final String title;
  final String? description;
  final String? cardBackgroundColor;
  final String? cardTextColor;
  final int position;
  final int depth;
  final String status;
  final String priority;
  final String? assigneeName;
  final List<String> labels;
  final DateTime? startDate;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final int? estimatedDurationMinutes;
  final int? actualDurationMinutes;
  final String periodType;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'boardId': boardId,
      if (columnId != null) 'columnId': columnId,
      if (parentTaskId != null) 'parentTaskId': parentTaskId,
      if (taskTypeId != null) 'taskTypeId': taskTypeId,
      'title': title,
      if (description != null) 'description': description,
      if (cardBackgroundColor != null)
        'cardBackgroundColor': cardBackgroundColor,
      if (cardTextColor != null) 'cardTextColor': cardTextColor,
      'position': position,
      'depth': depth,
      'status': status,
      'priority': priority,
      if (assigneeName != null) 'assigneeName': assigneeName,
      'labels': labels,
      if (startDate != null) 'startDate': startDate!.toUtc().toIso8601String(),
      if (dueDate != null) 'dueDate': dueDate!.toUtc().toIso8601String(),
      if (completedAt != null)
        'completedAt': completedAt!.toUtc().toIso8601String(),
      if (estimatedDurationMinutes != null)
        'estimatedDurationMinutes': estimatedDurationMinutes,
      if (actualDurationMinutes != null)
        'actualDurationMinutes': actualDurationMinutes,
      'periodType': periodType,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      if (deletedAt != null) 'deletedAt': deletedAt!.toUtc().toIso8601String(),
    };
  }
}

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

  factory TaskCommentDto.fromJson(Map<String, dynamic> json) {
    return TaskCommentDto(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deletedAt: _date(json['deletedAt']),
    );
  }

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
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
    if (deletedAt != null) 'deletedAt': deletedAt!.toUtc().toIso8601String(),
  };
}

final class TaskAssigneeDto {
  const TaskAssigneeDto({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.assignedBy,
    required this.assignedAt,
  });

  factory TaskAssigneeDto.fromJson(Map<String, dynamic> json) {
    return TaskAssigneeDto(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      userId: json['userId'] as String,
      assignedBy: json['assignedBy'] as String,
      assignedAt: DateTime.parse(json['assignedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String taskId;
  final String userId;
  final String assignedBy;
  final DateTime assignedAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'taskId': taskId,
    'userId': userId,
    'assignedBy': assignedBy,
    'assignedAt': assignedAt.toUtc().toIso8601String(),
  };
}

DateTime? _date(Object? value) =>
    value == null ? null : DateTime.parse(value as String).toUtc();
