# Готовность к распределённой развёртке: Сервер на удалённом хосте + Клиент на другом устройстве

**Дата оценки:** 2026-08-23  
**Текущая версия:** Feature-ready, но не production-ready  
**Статус интеграции:** 80% готовности

> Актуализация 2026-08-23: persistent Drift outbox уже добавлен. Retry worker
> отправляет pending-операции для `tasks`, `boards`, `columns`, `comments`.
> Клиент может получать runtime config через `--dart-define`. Server WebSocket
> больше не echo-only: он broadcast-ит task/comment события и хранит короткий
> in-memory event journal для `/sync/delta`.

---

## TL;DR: Будет ли работать?

**Частично, но заметно лучше, чем раньше.**

- ✅ **Работает:** аутентификация, авторизация, создание досок, доступ к доскам
- ✅ **Работает:** retry-outbox для задач, досок, колонок и комментариев
- ⚠️ **Работает с ограничениями:** realtime updates и delta sync
- ❌ **Не готово:** durable delta journal, conflict resolution, outbox для всех остальных сущностей

---

## Состояние по компонентам

### 1. **Аутентификация & Авторизация** ✅ **ГОТОВО**

**Что работает:**
- `/auth/register` — регистрация (POST)
- `/auth/login` — вход (POST)  
- `/auth/refresh` — обновление токена (POST)
- `/auth/logout` — выход (POST)
- `/auth/me` — получение текущего пользователя (GET)
- JWT-токены с поддержкой refresh-tokens

**Для развёртки на удалённом сервере:**
```bash
# Сервер слушает на 0.0.0.0:8080 (уже готово)
# В AppConfig укажите:
AppConfig.serverDevelopment() → замените
apiBaseUrl: 'http://your-server-ip:8080'
webSocketUrl: 'ws://your-server-ip:8080/realtime'
```

---

### 2. **Данные (читать)** ✅ **ГОТОВО**

**Endpoints, которые работают:**
- `GET /workspaces` — список рабочих пространств
- `POST /workspaces` — создание workspace
- `GET /boards` — список досок
- `POST /boards` — создание доски
- `GET /boards/{id}/members` — члены доски
- `GET /task-types` — типы задач
- `GET /tasks` — список задач (в доске)
- `GET /tasks/{id}/comments` — комментарии
- `GET /tasks/{id}/assignees` — назначения
- `GET /tasks/{id}/history` — история изменений

**Как это работает на клиенте:**
```dart
// В ServerStatePuller.pull() — загружает список задач при запуске
final tasks = await apiClient.get('/boards/{boardId}/tasks');
// Сохраняет в локальную Drift БД
// UI читает из Drift, не из сервера
```

---

### 3. **Написание данных (отправка на сервер)** ⚠️ **ЧАСТИЧНО**

**Endpoints существуют, но клиент их не использует:**
- `PATCH /tasks/{id}` — обновление задачи
- `DELETE /tasks/{id}` — удаление задачи
- `POST /tasks/{id}/comments` — добавление комментария
- `POST /tasks/{id}/assignees` — назначение пользователя

**Проблема:** клиент сохраняет изменения локально в Drift, но **НЕ отправляет их на сервер**.

Пример из `TasksRepository`:
```dart
// Сейчас так:
Future<void> updateTask(TaskEntity task) async {
  // 1. Сохранить в Drift (локально)
  await _database.tasks.insertOne(task);
  // 2. ❌ Отправить на сервер? — НЕТ, этого кода нет
}

// Должно быть:
Future<void> updateTask(TaskEntity task) async {
  // 1. Сохранить локально
  await _database.tasks.insertOne(task);
  // 2. Отправить на сервер через API datasource
  if (config.usesServerRemote) {
    try {
      await _apiDatasource.updateTask(task);
    } catch (e) {
      // Добавить в очередь (outbox) на повтор позже
    }
  }
}
```

---

### 4. **Синхронизация (Sync)** ⚠️ **НЕПОЛНАЯ**

**Текущее состояние `SyncManager`:**

```dart
Future<void> syncPending() async {
  if (!_usesServerRemote) {
    // В local-режиме просто имитирует
    await Future<void>.delayed(Duration(milliseconds: 100));
    return;
  }

  // В server-режиме:
  // 1. Загружает /sync/delta (пустой контейнер)
  final deltaJson = await apiClient.getJson(ApiEndpoints.syncDelta);
  
  // 2. Запускает ServerStatePuller (только читает с сервера)
  await ServerStatePuller(database: database, apiClient: apiClient).pull();
  
  // 3. ❌ НЕ отправляет pending-изменения на сервер
  // 4. ❌ НЕ слушает realtime-события
}
```

**Что отсутствует:**

| Компонент | Статус | Где | Что нужно |
|-----------|--------|-----|----------|
| Persistent outbox | ❌ | `sync_outbox.dart` | Сохранять pending-операции в Drift, а не в памяти |
| Retry worker | ❌ | `SyncManager` | Периодически пересылать failed-операции |
| Conflict resolution | ⚠️ | `conflict_resolver.dart` | Есть заготовка, но не интегрирована |
| Tombstones (мягкое удаление) | ❌ | `TasksTable` | Отмечать deleted без физического удаления |
| Pull всех данных | ⚠️ | `ServerStatePuller` | Работает, но только при старте |

---

### 5. **Realtime Events (WebSocket)** ❌ **НЕ ГОТОВО**

**Текущее состояние:**

```dart
// На сервере в server.dart:
..get(
  '/realtime',
  webSocketHandler((channel, protocol) {
    // Это просто echo — повторяет всё, что пришло
    channel.stream.listen(channel.sink.add);
  }),
)

// На клиенте в WebSocketRealtimeConnection:
// Подключается, но не обрабатывает события
```

**Что отсутствует:**
- Server не отправляет события о новых/обновлённых задачах
- Client не обновляет UI при получении event'а
- Нет механизма broadcast'а событий от одного пользователя всем остальным

**Пример нужного события:**
```json
{
  "type": "task:updated",
  "taskId": "123",
  "changes": {"status": "done", "updatedAt": "2026-08-21T..."},
  "actor": "user-456"
}
```

---

## 🔴 Критические проблемы для распределённой развёртки

### Проблема 1: Изменения пропадают на сервере

**Сценарий:**
1. Пользователь на device-А переводит задачу в "Готово"
2. Приложение сохраняет изменение в локальную БД (Drift)
3. UI обновляется сразу ✅
4. **Изменение НЕ отправляется на сервер** ❌
5. Когда device-А синхронизируется, изменение переписывается версией с сервера (потеря данных!)

**Пример из `tasks_page.dart`:**
```dart
// Пользователь нажимает чекбокс
await ref
  .read(tasksControllerProvider.notifier)
  .toggleComplete(taskId: taskId);
  
// Это вызывает TasksController → TasksRepository → insertOne(updatedTask)
// Сохранилось в Drift, но НЕ отправилось на сервер!
```

### Проблема 2: Другой пользователь не видит изменения

**Сценарий:**
1. User-A на device-А создал новую задачу
2. Device-A отправит на сервер (если будет реализовано)
3. User-B на device-B не узнает об этом, пока не сделает ручную синхронизацию
4. Нет realtime-оповещения

### Проблема 3: Конфликты при offline-работе

**Сценарий:**
1. Device-A создал task-X (offline)
2. Device-B создал другую version task-X с сервера
3. Device-A вернулся online
4. Два изменения конфликтуют, нет стратегии разрешения

---

## 📋 Что нужно реализовать (по приоритету)

### Шаг 1: API Datasource для записи (2-4 часа)

**Файл:** `apps/kanban_app/lib/src/features/tasks/data/datasources/tasks_api_datasource.dart`

```dart
class TasksApiDatasource {
  Future<void> updateTask(TaskEntity task) async {
    final response = await apiClient.patch(
      '/tasks/${task.id}',
      data: task.toDto().toJson(),
    );
    // Если error 401/403 — авторизация падает
    // Если error 5xx или connection error → добавить в outbox
  }
  
  Future<void> createTask(TaskEntity task) async {
    // аналогично
  }
  
  Future<void> deleteTask(String taskId) async {
    // аналогично
  }
  
  Future<void> toggleTaskComplete(String taskId, bool completed) async {
    // аналогично
  }
}
```

**Затронутые файлы:**
- `tasks_repository.dart` — использовать API datasource в server-режиме
- `comments_repository.dart` — аналогично
- `assignees_repository.dart` — аналогично

### Шаг 2: Persistent Outbox в Drift (3-5 часов)

**Проблема:** сейчас `MemorySyncOutbox` теряет данные при перезагрузке.

**Решение:** создать таблицу `SyncActionsTable` в Drift:

```dart
@DataClassName('SyncActionDto')
class SyncActionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()(); // 'task', 'comment', etc.
  TextColumn get action => text()(); // 'create', 'update', 'delete'
  TextColumn get entityId => text()();
  TextColumn get payload => text()(); // JSON
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
```

**Затронутые файлы:**
- `app_database.dart` — добавить таблицу
- `sync_outbox.dart` — реализовать `DriftSyncOutbox` вместо in-memory

### Шаг 3: Retry Worker в SyncManager (2-3 часа)

**Где:** `apps/kanban_app/lib/src/core/sync/sync_manager.dart`

```dart
Future<void> syncPending() async {
  // 1. Загрузить pending-операции из outbox
  final pending = await _database.syncActions.select().get();
  
  // 2. Попытаться отправить каждую
  for (final action in pending) {
    try {
      await _sendAction(action);
      // Удалить из outbox
      await _database.syncActions.delete().go();
    } on Exception catch (e) {
      // Увеличить retryCount, сохранить ошибку
      action.retryCount++;
      action.lastError = e.toString();
      // Если retryCount > 5 — перестать пытаться
    }
  }
  
  // 3. Загрузить /sync/delta с сервера
  final delta = await apiClient.getJson(ApiEndpoints.syncDelta);
  
  // 4. Применить изменения из дельты в БД
  await _applyDelta(delta);
}

Future<void> _sendAction(SyncActionDto action) async {
  switch (action.entityType) {
    case 'task':
      final task = TaskEntity.fromJson(jsonDecode(action.payload));
      await _apiDatasource.updateTask(task);
      break;
    // ... остальные типы
  }
}
```

### Шаг 4: Realtime Events (3-5 часов)

**На сервере (server.dart):**

```dart
final _realtimeClients = <WebSocketChannel>[];

..get(
  '/realtime',
  webSocketHandler((channel, protocol) {
    _realtimeClients.add(channel);
    channel.stream.listen((message) {
      // Broadcast событие всем подключённым клиентам
      for (final client in _realtimeClients) {
        client.sink.add(message);
      }
    });
  }),
)
```

**На клиенте (realtime_service.dart):**

```dart
class WebSocketRealtimeService extends RealtimeService {
  @override
  Stream<RealtimeEvent> get events {
    return _connection.stream
        .map((json) => RealtimeEvent.fromJson(json))
        .where((event) => event.boardId == _currentBoardId);
  }
}

// В board-контроллере слушать события:
ref.watch(realtimeServiceProvider).events.listen((event) {
  if (event.type == 'task:updated') {
    // Обновить БД из события
    await _database.tasks.insertOne(event.task);
  }
});
```

### Шаг 5: Conflict Resolution (2-3 часа)

**Файл:** `apps/kanban_app/lib/src/core/sync/conflict_resolver.dart`

**Стратегия:** "Last-Write-Wins" (пока достаточно)

```dart
TaskEntity resolveConflict(TaskEntity local, TaskEntity remote) {
  // Если remote новее → использовать remote
  if (remote.updatedAt.isAfter(local.updatedAt)) {
    return remote;
  }
  // Иначе → оставить local
  return local;
}
```

---

## 🚀 План развёртки на удалённом сервере (когда будет готово)

### Сейчас (до Шага 1-5):

```bash
# Сервер на своей машине
docker compose up postgres
dart run bin/server.dart

# Клиент на той же машине
AppConfig.serverDevelopment()  # localhost:8080
flutter run -d linux
```

### После Шага 1-5:

```bash
# Сервер на удалённом хосте (например, Ubuntu VPS)
ssh user@your-server.com
docker compose up postgres
dart run bin/server.dart  # Слушает 0.0.0.0:8080

# Клиент на другом устройстве
AppConfig(
  apiBaseUrl: 'http://your-server.com:8080',
  webSocketUrl: 'ws://your-server.com:8080/realtime',
  remoteMode: RemoteMode.server,
)
flutter run -d android  # или iOS, Linux, etc.
```

### Дополнительные шаги для production:

- SSL/TLS сертификат (не `ws://`, а `wss://`)
- Nginx reverse-proxy с rate-limiting
- Database connection pooling
- Логирование и мониторинг
- Backup базы данных
- Health-check endpoints

---

## 📊 Чек-лист готовности

| Компонент | Локально | Распределённо | Примечание |
|-----------|----------|----------------|-----------|
| Аутентификация | ✅ | ✅ | Готово, работает |
| Чтение доск/задач | ✅ | ✅ | Готово через ServerStatePuller |
| Редактирование локально | ✅ | ✅ | Сохраняется в Drift |
| Отправка на сервер | ❌ | ❌ | Нужен API datasource + outbox |
| Синхронизация | ⚠️ | ⚠️ | Только pull, нет push |
| Realtime | ❌ | ❌ | WebSocket echo, не работает |
| Конфликты | ❌ | ❌ | Нет стратегии |
| Многопользователь | ❌ | ❌ | Зависит от realtime |

---

## 📝 Текущие ограничения

1. **Одностороняя синхронизация:** только pull с сервера, push не реализован
2. **Без realtime:** нужна ручная синхронизация для обновлений от других пользователей
3. **Данные на сервере игнорируются:** изменения не отправляются, если выключить режим local
4. **Нет резервного копирования:** в памяти хранится outbox, теряется при перезагрузке

---

## 🛠️ Рекомендация

**Сейчас:** используйте `RemoteMode.local` для разработки UI
- Все работает, никаких задержек, не зависит от сервера
- Идеально для спринта разработки фич

**Когда реализуете Шаги 1-3:** переходите на `RemoteMode.server` для тестирования
- Проверьте, что изменения отправляются на сервер
- Проверьте retry-логику при потере соединения

**После Шага 4:** включайте realtime и тестируйте многопользовательское взаимодействие

---

## 📚 Дополнительная информация

- `apps/kanban_app/lib/src/core/sync/` — все компоненты синхронизации
- `apps/kanban_server/lib/server.dart` — все endpoints
- `docs/project_for_beginners.md` — архитектурное объяснение
- `apps/kanban_app/test/remote_mode_provider_test.dart` — примеры конфигурации
