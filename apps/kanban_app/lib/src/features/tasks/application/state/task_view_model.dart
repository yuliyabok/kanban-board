import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../domain/entities/task_entity.dart';

final class TaskViewModel {
  const TaskViewModel({
    required this.task,
    required this.subtasks,
    this.parentTask,
    this.taskType,
  });

  final TaskEntity task;
  final TaskEntity? parentTask;
  final List<TaskEntity> subtasks;
  final TaskTypeEntity? taskType;
}
