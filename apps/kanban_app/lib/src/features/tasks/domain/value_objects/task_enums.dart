enum TaskPeriodType {
  singleDay,
  dateRange,
  weekly,
  monthly,
  sprint,
  custom,
}

enum TaskPeriodStatus {
  noSchedule,
  notStarted,
  inProgress,
  overdue,
  completed,
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

enum TaskStatus {
  todo,
  inProgress,
  done,
  blocked,
}

extension TaskEnumName on Enum {
  String get storageName => name;
}

T enumByNameOrDefault<T extends Enum>(
  List<T> values,
  String? name,
  T fallback,
) {
  for (final value in values) {
    if (value.name == name) return value;
  }
  return fallback;
}
