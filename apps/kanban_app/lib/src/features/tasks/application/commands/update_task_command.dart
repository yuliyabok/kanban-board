import '../../domain/entities/task_entity.dart';

final class UpdateTaskCommand {
  const UpdateTaskCommand(this.task, {this.actorUserId});

  final TaskEntity task;
  final String? actorUserId;
}
