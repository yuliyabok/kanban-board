import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/board_card_settings.dart';

extension BoardCardSettingsRowMapper on BoardCardSettingsTableData {
  BoardCardSettings toEntity() {
    return BoardCardSettings(
      boardId: boardId,
      showDescription: showDescription,
      showTaskType: showTaskType,
      showPeriod: showPeriod,
      showSubtaskProgress: showSubtaskProgress,
      showPriority: showPriority,
      showAssignee: showAssignee,
      showLabels: showLabels,
      showCreatedAt: showCreatedAt,
      showQuickActions: showQuickActions,
      density: _enumByName(
        TaskCardDensity.values,
        density,
        TaskCardDensity.compact,
      ),
      style: _enumByName(TaskCardStyle.values, style, TaskCardStyle.bordered),
      typeBadgePlacement: _enumByName(
        TaskTypeBadgePlacement.values,
        typeBadgePlacement,
        TaskTypeBadgePlacement.top,
      ),
      typeColorMode: _enumByName(
        TaskTypeColorMode.values,
        typeColorMode,
        TaskTypeColorMode.smallDot,
      ),
      cardBackgroundColor: cardBackgroundColor,
      columnBackgroundColor: columnBackgroundColor,
      updatedAt: updatedAt,
    );
  }
}

extension BoardCardSettingsEntityMapper on BoardCardSettings {
  BoardCardSettingsTableCompanion toCompanion() {
    return BoardCardSettingsTableCompanion.insert(
      boardId: boardId,
      showDescription: Value(showDescription),
      showTaskType: Value(showTaskType),
      showPeriod: Value(showPeriod),
      showSubtaskProgress: Value(showSubtaskProgress),
      showPriority: Value(showPriority),
      showAssignee: Value(showAssignee),
      showLabels: Value(showLabels),
      showCreatedAt: Value(showCreatedAt),
      showQuickActions: Value(showQuickActions),
      density: Value(density.name),
      style: Value(style.name),
      typeBadgePlacement: Value(typeBadgePlacement.name),
      typeColorMode: Value(typeColorMode.name),
      cardBackgroundColor: Value(cardBackgroundColor),
      columnBackgroundColor: Value(columnBackgroundColor),
      updatedAt: updatedAt,
    );
  }
}

T _enumByName<T extends Enum>(List<T> values, String name, T fallback) {
  for (final value in values) {
    if (value.name == name) return value;
  }
  return fallback;
}
