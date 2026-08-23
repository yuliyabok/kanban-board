import '../../../domain/entities/task_entity.dart';
import '../../../domain/value_objects/task_enums.dart';

extension TaskDisplayId on TaskEntity {
  String get shortDisplayId => formatTaskDisplayId(id);
}

String formatTaskDisplayId(String id) {
  final compact = id.replaceAll('-', '').toUpperCase();
  final suffix = compact.length <= 8 ? compact : compact.substring(0, 8);
  return 'TSK-$suffix';
}

extension TaskPeriodPresentation on TaskEntity {
  TaskPeriodStatus get periodStatus {
    if (completedAt != null || isCompleted) return TaskPeriodStatus.completed;
    final today = DateTime.now();
    final day = DateTime(today.year, today.month, today.day);
    final start = startDate == null
        ? null
        : DateTime(startDate!.year, startDate!.month, startDate!.day);
    final due = dueDate == null
        ? null
        : DateTime(dueDate!.year, dueDate!.month, dueDate!.day);
    if (start == null && due == null) return TaskPeriodStatus.noSchedule;
    if (due != null && due.isBefore(day)) return TaskPeriodStatus.overdue;
    if (start != null && start.isAfter(day)) return TaskPeriodStatus.notStarted;
    if (due != null && !due.isBefore(day)) return TaskPeriodStatus.inProgress;
    return TaskPeriodStatus.noSchedule;
  }

  String get periodLabel {
    final status = periodStatus;
    if (status == TaskPeriodStatus.noSchedule) return 'Без срока';
    if (status == TaskPeriodStatus.completed) return 'Завершена';

    final today = DateTime.now();
    final day = DateTime(today.year, today.month, today.day);
    final due = dueDate == null
        ? null
        : DateTime(dueDate!.year, dueDate!.month, dueDate!.day);
    if (status == TaskPeriodStatus.overdue && due != null) {
      final days = day.difference(due).inDays;
      return 'Просрочено на $days дн.';
    }
    if (due != null && due == day) return 'Сегодня';
    if (due != null && due == day.add(const Duration(days: 1))) {
      return 'Завтра';
    }
    if (startDate != null && dueDate != null) {
      return '${startDate!.day}–${dueDate!.day}.${dueDate!.month}';
    }
    if (dueDate != null) return '${dueDate!.day}.${dueDate!.month}';
    return 'Запланировано';
  }
}

final class SubtaskStats {
  const SubtaskStats({
    required this.total,
    required this.completed,
  });

  factory SubtaskStats.fromTasks(List<TaskEntity> subtasks) {
    return SubtaskStats(
      total: subtasks.length,
      completed: subtasks.where((task) => task.isCompleted).length,
    );
  }

  final int total;
  final int completed;

  double get progress => total == 0 ? 0 : completed / total;

  String get label => '$completed/$total';
}
