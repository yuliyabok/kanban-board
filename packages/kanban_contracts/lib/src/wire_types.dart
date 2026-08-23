// Общие enum для wire-слоя. Они описывают значения, которые можно передавать
// между приложением и сервером в JSON.
enum WireTaskPriority {
  low,
  medium,
  high,
  urgent
  ;

  static WireTaskPriority fromJson(Object? value) {
    return WireTaskPriority.values.firstWhere(
      (item) => item.name == value,
      orElse: () => WireTaskPriority.medium,
    );
  }
}

enum WireTaskStatus {
  active,
  completed,
  deleted
  ;

  static WireTaskStatus fromJson(Object? value) {
    return WireTaskStatus.values.firstWhere(
      (item) => item.name == value,
      orElse: () => WireTaskStatus.active,
    );
  }
}

enum WireMemberRole {
  viewer,
  member,
  admin,
  owner
  ;

  static WireMemberRole fromJson(Object? value) {
    return WireMemberRole.values.firstWhere(
      (item) => item.name == value,
      orElse: () => WireMemberRole.member,
    );
  }
}

enum WireSyncAction {
  create,
  update,
  delete
  ;

  static WireSyncAction fromJson(Object? value) {
    return WireSyncAction.values.firstWhere(
      (item) => item.name == value,
      orElse: () => WireSyncAction.update,
    );
  }
}
