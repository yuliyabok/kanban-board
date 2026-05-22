import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskDetailsSelectionProvider =
    NotifierProvider<TaskDetailsSelectionController, String?>(
      TaskDetailsSelectionController.new,
    );

class TaskDetailsSelectionController extends Notifier<String?> {
  @override
  String? build() => null;

  String? get selectedTaskId => state;

  set selectedTaskId(String? taskId) {
    state = taskId;
  }

  void close() {
    state = null;
  }
}
