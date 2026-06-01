import '../../../../core/error/failure.dart';
import '../entities/task_entity.dart';

final class TaskPolicy {
  const TaskPolicy._();

  static Failure? validate(
    TaskEntity task,
    Iterable<TaskEntity> existingTasks,
  ) {
    final trimmedTitle = task.title.trim();
    if (trimmedTitle.isEmpty) {
      return const ValidationFailure('Название задачи не может быть пустым');
    }
    if (trimmedTitle.length > 120) {
      return const ValidationFailure('Название задачи не длиннее 120 символов');
    }
    if ((task.description?.length ?? 0) > 1000) {
      return const ValidationFailure('Описание не длиннее 1000 символов');
    }
    if (task.startDate != null &&
        task.dueDate != null &&
        task.dueDate!.isBefore(task.startDate!)) {
      return const ValidationFailure('Дата окончания не раньше даты начала');
    }
    if (task.depth > 3) {
      return const ValidationFailure('Максимальная вложенность подзадач — 3');
    }
    if (task.parentTaskId == task.id) {
      return const ValidationFailure(
        'Задача не может быть дочерней самой себе',
      );
    }
    if (_createsCycle(task, existingTasks)) {
      return const ValidationFailure('Нельзя создать циклическую зависимость');
    }
    return null;
  }

  static bool _createsCycle(
    TaskEntity task,
    Iterable<TaskEntity> existingTasks,
  ) {
    final byId = {for (final item in existingTasks) item.id: item};
    var parentId = task.parentTaskId;
    var guard = 0;
    while (parentId != null && guard < 10) {
      if (parentId == task.id) return true;
      parentId = byId[parentId]?.parentTaskId;
      guard++;
    }
    return false;
  }
}
