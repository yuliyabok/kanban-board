// DTO для вкладки "Что изменилось, пока вас не было": компактные счетчики
// важных изменений после последнего визита пользователя.
final class ChangesSummaryDto {
  const ChangesSummaryDto({
    required this.changedTasks,
    required this.comments,
    required this.newTasks,
    required this.overdueTasks,
    required this.since,
    required this.generatedAt,
  });

  factory ChangesSummaryDto.fromJson(Map<String, dynamic> json) {
    return ChangesSummaryDto(
      changedTasks: json['changedTasks'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      newTasks: json['newTasks'] as int? ?? 0,
      overdueTasks: json['overdueTasks'] as int? ?? 0,
      since: DateTime.parse(json['since'] as String).toUtc(),
      generatedAt: DateTime.parse(json['generatedAt'] as String).toUtc(),
    );
  }

  final int changedTasks;
  final int comments;
  final int newTasks;
  final int overdueTasks;
  final DateTime since;
  final DateTime generatedAt;

  Map<String, Object?> toJson() {
    return {
      'changedTasks': changedTasks,
      'comments': comments,
      'newTasks': newTasks,
      'overdueTasks': overdueTasks,
      'since': since.toUtc().toIso8601String(),
      'generatedAt': generatedAt.toUtc().toIso8601String(),
    };
  }
}
