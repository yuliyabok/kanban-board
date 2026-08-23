import 'package:flutter_riverpod/flutter_riverpod.dart';

final expandedTaskCardsProvider =
    NotifierProvider<ExpandedTaskCardsController, Set<String>>(
      ExpandedTaskCardsController.new,
    );

class ExpandedTaskCardsController extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void toggle(String taskId) {
    if (state.contains(taskId)) {
      state = {...state}..remove(taskId);
      return;
    }
    state = {...state, taskId};
  }
}
