import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../entities/task_entity.dart';
import 'task_enums.dart';

@immutable
final class TaskFilter {
  const TaskFilter({
    this.query = '',
    this.myTaskIds = const <String>{},
    this.myTasksOnly = false,
    this.inProgressOnly = false,
    this.priority,
  });

  final String query;
  final Set<String> myTaskIds;
  final bool myTasksOnly;
  final bool inProgressOnly;
  final TaskPriority? priority;

  bool get hasActiveSearch => query.trim().isNotEmpty;

  bool get hasActiveFilters =>
      hasActiveSearch || myTasksOnly || inProgressOnly || priority != null;

  List<TaskEntity> apply(List<TaskEntity> tasks) {
    final normalizedQuery = query.trim().toLowerCase();
    Iterable<TaskEntity> scoped = myTasksOnly
        ? tasks.where((task) => myTaskIds.contains(task.id))
        : tasks;

    if (inProgressOnly) {
      scoped = scoped.where((task) => !task.isCompleted);
    }

    final selectedPriority = priority;
    if (selectedPriority != null) {
      scoped = scoped.where((task) => task.priority == selectedPriority);
    }

    if (normalizedQuery.isEmpty) {
      return scoped.toList(growable: false);
    }

    return scoped
        .where((task) {
          final description = task.description?.toLowerCase() ?? '';
          return task.title.toLowerCase().contains(normalizedQuery) ||
              description.contains(normalizedQuery);
        })
        .toList(growable: false);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskFilter &&
        other.query == query &&
        other.myTasksOnly == myTasksOnly &&
        other.inProgressOnly == inProgressOnly &&
        other.priority == priority &&
        const SetEquality<String>().equals(other.myTaskIds, myTaskIds);
  }

  @override
  int get hashCode => Object.hash(
    query,
    myTasksOnly,
    inProgressOnly,
    priority,
    const SetEquality<String>().hash(myTaskIds),
  );
}
