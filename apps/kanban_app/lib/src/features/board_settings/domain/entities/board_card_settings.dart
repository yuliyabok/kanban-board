import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_card_settings.freezed.dart';

enum TaskCardDensity { compact, comfortable, detailed }

enum TaskCardStyle { minimal, bordered, elevated, accent }

enum TaskTypeBadgePlacement { top, left, bottom }

enum TaskTypeColorMode { smallDot, leftBorder, badgeBackground, iconAccent }

@freezed
abstract class BoardCardSettings with _$BoardCardSettings {
  const factory BoardCardSettings({
    required String boardId,
    required DateTime updatedAt,
    @Default(true) bool showDescription,
    @Default(true) bool showTaskType,
    @Default(true) bool showPeriod,
    @Default(true) bool showSubtaskProgress,
    @Default(true) bool showPriority,
    @Default(true) bool showAssignee,
    @Default(true) bool showLabels,
    @Default(false) bool showCreatedAt,
    @Default(true) bool showQuickActions,
    @Default(TaskCardDensity.compact) TaskCardDensity density,
    @Default(TaskCardStyle.bordered) TaskCardStyle style,
    @Default(TaskTypeBadgePlacement.top)
    TaskTypeBadgePlacement typeBadgePlacement,
    @Default(TaskTypeColorMode.smallDot) TaskTypeColorMode typeColorMode,
    @Default('default') String cardBackgroundColor,
    @Default('default') String columnBackgroundColor,
  }) = _BoardCardSettings;

  factory BoardCardSettings.defaults(String boardId) {
    return BoardCardSettings(
      boardId: boardId,
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
