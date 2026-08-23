<!-- Набор схем проекта: как связаны Flutter app, сервер, shared contracts, Drift, PostgreSQL и синхронизация. -->

# Схемы Работы Проекта

Эти схемы показывают проект крупными кусками: что где лежит, как идут данные и
что происходит при изменении задачи.

## Общая Картина

```mermaid
flowchart LR
  User[Пользователь] --> App[Flutter app]
  App --> Drift[(Локальная Drift БД)]
  App --> Contracts[kanban_contracts]
  Server[Dart server] --> Contracts
  App <-->|HTTP API| Server
  App <-->|WebSocket realtime| Server
  Server --> Postgres[(PostgreSQL)]

  subgraph Client[Клиентская часть]
    App
    Drift
  end

  subgraph Shared[Общий язык]
    Contracts
  end

  subgraph Backend[Серверная часть]
    Server
    Postgres
  end
```

Смысл простой:

- Flutter app показывает интерфейс и всегда читает быстро из Drift.
- Dart server хранит общие данные для всех пользователей.
- `kanban_contracts` фиксирует общие DTO и routes, чтобы app и server говорили
  на одном JSON-языке.

## Как Разделен Репозиторий

```mermaid
flowchart TD
  Root[kanban_board]
  Root --> Flutter[apps/kanban_app]
  Root --> Server[apps/kanban_server]
  Root --> Contracts[packages/kanban_contracts]
  Root --> Docs[docs/]
  Root --> Docker[docker-compose.yml]
  Root --> Makefile[Makefile]

  Server --> ServerBin[bin/server.dart]
  Server --> ServerLib[lib/server.dart и lib/src/*]
  Server --> Migrations[migrations/*.sql]
  Server --> ServerTests[test/server_test.dart]

  Contracts --> Routes[api_routes.dart]
  Contracts --> Dto[DTO: auth, users, boards, tasks, sync]
  Contracts --> ContractTests[test/contracts_json_test.dart]
```

## Слои Flutter App

```mermaid
flowchart TD
  UI[Presentation: pages, widgets, controllers, providers]
  AppLayer[Application: commands, queries, services, view state]
  Domain[Domain: entities, policies, repository contracts, use cases]
  Data[Data: repositories, local/API datasources, DTO, mappers]
  Core[Core: config, database, network, storage, sync]
  Drift[(Drift)]
  Api[HTTP/WebSocket API]

  UI --> AppLayer
  AppLayer --> Domain
  Domain --> Data
  Data --> Core
  Core --> Drift
  Core --> Api
```

Правило: UI не должен напрямую знать про Drift, Dio или PostgreSQL. UI вызывает
controllers/use cases, а repositories решают, писать локально или ходить на
сервер.

## Local И Server Режимы

```mermaid
flowchart LR
  Config[AppConfig.remoteMode]
  Config --> Local[RemoteMode.local]
  Config --> ServerMode[RemoteMode.server]

  Local --> LocalRepo[Repositories]
  LocalRepo --> DriftLocal[(Drift)]
  LocalRepo --> LocalAdapters[Local/mock remote datasources]

  ServerMode --> ServerRepo[Repositories]
  ServerRepo --> DriftServer[(Drift)]
  ServerRepo --> ApiDatasources[API remote datasources]
  ApiDatasources --> Backend[Dart server]
  Backend --> Postgres[(PostgreSQL)]
```

`local` удобен для разработки интерфейса. `server` нужен, чтобы приложение
работало через backend и синхронизацию.

## Что Происходит При Изменении Задачи

```mermaid
sequenceDiagram
  participant U as Пользователь
  participant UI as Flutter UI
  participant C as Controller / Use case
  participant R as Offline-first repository
  participant D as Drift
  participant API as API datasource
  participant S as Dart server
  participant PG as PostgreSQL

  U->>UI: Меняет задачу
  UI->>C: updateTask(...)
  C->>R: repository.update(...)
  R->>D: upsert syncAction=update
  D-->>UI: Экран обновился сразу

  alt RemoteMode.server
    R->>API: PATCH /tasks/:id
    API->>S: HTTP request
    S->>PG: UPDATE tasks + INSERT history
    PG-->>S: ok
    S-->>API: TaskDto
    API-->>R: remote task
    R->>D: mark synced
  else Сервер недоступен
    R-->>D: запись остается pending
  end
```

Главная идея offline-first: пользователь видит изменение сразу, а серверная
синхронизация догоняет состояние после этого.

## Как Сервер Обрабатывает Запрос

```mermaid
sequenceDiagram
  participant App as Flutter app
  participant Router as shelf_router
  participant Auth as AuthService
  participant Repo as Repository
  participant PG as PostgreSQL

  App->>Router: HTTP request + Bearer token
  Router->>Auth: currentUser(Authorization)
  Auth-->>Router: User
  Router->>Repo: выполнить действие
  Repo->>PG: SQL query / transaction
  PG-->>Repo: rows
  Repo-->>Router: DTO
  Router-->>App: JSON response
```

На сервере repositories работают с PostgreSQL напрямую. DTO ответа берутся из
`kanban_contracts`.

## Авторизация

```mermaid
sequenceDiagram
  participant App as Flutter app
  participant S as Dart server
  participant PG as PostgreSQL

  App->>S: POST /auth/login email+password
  S->>PG: найти user по email
  PG-->>S: user + password hash/salt
  S->>S: проверить password hash
  S->>PG: создать refresh_session с hash refresh token
  S-->>App: accessToken + refreshToken + expiresAt

  App->>S: GET /auth/me Bearer accessToken
  S->>S: проверить JWT
  S->>PG: найти user
  S-->>App: UserDto
```

Пароль в чистом виде не хранится. Refresh token в базе хранится как hash.

## Входящая Синхронизация С Сервера

```mermaid
flowchart TD
  SyncManager[SyncManager.syncPending]
  Delta[GET /sync/delta]
  Puller[ServerStatePuller]
  Workspaces[GET /workspaces]
  WorkspaceMembers[GET /workspaces/:id/members]
  Boards[GET /boards]
  BoardMembers[GET /boards/:id/members]
  TaskTypes[GET /task-types?boardId=...]
  Tasks[GET /tasks?boardId=...]
  Comments[GET /tasks/:id/comments]
  Assignees[GET /tasks/:id/assignees]
  History[GET /tasks/:id/history]
  Drift[(Drift cache)]
  UI[UI streams/providers]

  SyncManager --> Delta
  SyncManager --> Puller
  Puller --> Workspaces
  Puller --> WorkspaceMembers
  Puller --> Boards
  Puller --> BoardMembers
  Puller --> TaskTypes
  Puller --> Tasks
  Puller --> Comments
  Puller --> Assignees
  Puller --> History
  Workspaces --> Drift
  WorkspaceMembers --> Drift
  Boards --> Drift
  BoardMembers --> Drift
  TaskTypes --> Drift
  Tasks --> Drift
  Comments --> Drift
  Assignees --> Drift
  History --> Drift
  Drift --> UI
```

Сейчас pull подтягивает workspaces, workspace members, boards, board members,
task types, tasks, comments, assignees и history. Columns и invitations ждут
готовых server endpoints для полного pull.

## История Задачи

```mermaid
flowchart LR
  Change[Изменение задачи / комментария / исполнителя]
  ClientHistory[Локальная optimistic history]
  ServerHistory[Серверная task_history]
  Actor[actorUserId]
  Details[details: что изменилось]
  Popup[Окно истории в карточке]

  Change --> ClientHistory
  Change --> ServerHistory
  ServerHistory --> Actor
  ServerHistory --> Details
  ClientHistory --> Popup
  ServerHistory --> Popup
```

Цель: серверная история должна стать источником истины, а локальная история
остается быстрым optimistic-кешем.

## Что Еще Нужно Доделать Для Полного Разделения

```mermaid
flowchart TD
  Start[Текущее состояние]
  Pull[Дотянуть pull всех сущностей]
  Outbox[Persistent sync outbox]
  Deletes[Удаления и tombstones]
  Conflicts[Конфликты updatedAt]
  Realtime[WebSocket broadcast + merge]
  Columns[GET columns by board endpoint]
  Done[Полное разделение app/server]

  Start --> Pull
  Pull --> Outbox
  Outbox --> Deletes
  Deletes --> Conflicts
  Conflicts --> Realtime
  Realtime --> Columns
  Columns --> Done
```

Flutter app физически живет в `apps/kanban_app`. Корень репозитория остается
слоем orchestration: команды, Docker Compose и документация.
