import '../../domain/entities/task_entity.dart';

final class MoveTaskCommand {
  const MoveTaskCommand({
    required this.boardId,
    required this.task,
    required this.columnId,
  });

  final String boardId;
  final TaskEntity task;
  final String? columnId;
}
