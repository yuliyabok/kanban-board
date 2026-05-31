import '../../domain/entities/task_entity.dart';

final class UpdateTaskCommand {
  const UpdateTaskCommand(this.task);

  final TaskEntity task;
}
