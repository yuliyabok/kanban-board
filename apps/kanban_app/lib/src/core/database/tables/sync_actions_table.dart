import 'package:drift/drift.dart';

/// Таблица для сохранения pending-операций, которые нужно отправить на сервер.
/// Используется для надежной доставки изменений при потере соединения.
class SyncActionsTable extends Table {
  /// Уникальный ID операции
  TextColumn get id => text()();

  /// Тип сущности: 'task', 'comment', 'assignee', 'column', etc.
  TextColumn get entityType => text()();

  /// Действие: 'create', 'update', 'delete'
  TextColumn get action => text()();

  /// ID сущности (task ID, comment ID, etc.)
  TextColumn get entityId => text()();

  /// JSON-сериализованные данные сущности для отправки
  TextColumn get payload => text()();

  /// Когда была создана операция
  DateTimeColumn get createdAt => dateTime()();

  /// Количество попыток отправки
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  /// Последняя ошибка (если была)
  TextColumn get lastError => text().nullable()();

  /// Когда была последняя попытка
  DateTimeColumn get lastRetryAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
