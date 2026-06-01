import '../entities/task_entity.dart';

final class TaskOrderingPolicy {
  const TaskOrderingPolicy._();

  static List<TaskEntity> reorder({
    required List<TaskEntity> tasks,
    required int oldIndex,
    required int newIndex,
  }) {
    if (oldIndex < 0 || oldIndex >= tasks.length) {
      return tasks;
    }

    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final clampedTarget = targetIndex.clamp(0, tasks.length - 1);
    final reordered = [...tasks];
    final task = reordered.removeAt(oldIndex);
    reordered.insert(clampedTarget, task);
    return normalizePositions(reordered);
  }

  static List<TaskEntity> normalizePositions(List<TaskEntity> tasks) {
    return [
      for (var index = 0; index < tasks.length; index++)
        tasks[index].copyWith(position: index),
    ];
  }

  static int nextPositionInColumn({
    required Iterable<TaskEntity> tasks,
    required String? columnId,
    String? excludeTaskId,
  }) {
    return tasks
        .where((task) => task.columnId == columnId && task.id != excludeTaskId)
        .length;
  }
}
