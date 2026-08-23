import 'task_view_model.dart';

final class BoardColumnViewModel {
  const BoardColumnViewModel({
    required this.title,
    required this.position,
    required this.tasks,
    this.columnId,
  });

  final String title;
  final int position;
  final String? columnId;
  final List<TaskViewModel> tasks;

  int get taskCount => tasks.length;
}
