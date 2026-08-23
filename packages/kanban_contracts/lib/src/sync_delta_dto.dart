// Контракт delta-синхронизации: сервер отдает измененные/удаленные сущности,
// историю и realtime-события, которые клиент пропустил.
import 'package:kanban_contracts/src/realtime_event_dto.dart';
import 'package:kanban_contracts/src/task_history_entry_dto.dart';

final class SyncDeltaDto {
  const SyncDeltaDto({
    required this.serverTime,
    required this.changedEntities,
    required this.deletedEntityIds,
    required this.historyEntries,
    required this.realtimeEvents,
  });

  factory SyncDeltaDto.empty(DateTime serverTime) {
    return SyncDeltaDto(
      serverTime: serverTime,
      changedEntities: const [],
      deletedEntityIds: const [],
      historyEntries: const [],
      realtimeEvents: const [],
    );
  }

  factory SyncDeltaDto.fromJson(Map<String, dynamic> json) {
    final changed = json['changedEntities'] as List<dynamic>? ?? const [];
    final deleted = json['deletedEntityIds'] as List<dynamic>? ?? const [];
    final history = json['historyEntries'] as List<dynamic>? ?? const [];
    final events = json['realtimeEvents'] as List<dynamic>? ?? const [];
    return SyncDeltaDto(
      serverTime: DateTime.parse(json['serverTime'] as String).toUtc(),
      changedEntities: changed
          .map((item) => (item as Map<String, dynamic>).cast<String, Object?>())
          .toList(growable: false),
      deletedEntityIds: deleted.cast<String>(),
      historyEntries: history
          .map(
            (item) => TaskHistoryEntryDto.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(growable: false),
      realtimeEvents: events
          .map(
            (item) => RealtimeEventDto.fromJson(item as Map<String, dynamic>),
          )
          .toList(growable: false),
    );
  }

  final DateTime serverTime;
  final List<Map<String, Object?>> changedEntities;
  final List<String> deletedEntityIds;
  final List<TaskHistoryEntryDto> historyEntries;
  final List<RealtimeEventDto> realtimeEvents;

  Map<String, Object?> toJson() {
    return {
      'serverTime': serverTime.toUtc().toIso8601String(),
      'changedEntities': changedEntities,
      'deletedEntityIds': deletedEntityIds,
      'historyEntries': historyEntries.map((item) => item.toJson()).toList(),
      'realtimeEvents': realtimeEvents.map((item) => item.toJson()).toList(),
    };
  }
}
