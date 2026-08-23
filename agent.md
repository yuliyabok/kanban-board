# Agent Guide

Этот файл нужен будущим разработчикам и агентам как короткая, актуальная карта
проекта. Если меняется архитектура, схема БД, server API или режимы запуска,
сначала обновляй этот файл и `README.md`.

## Текущее Состояние

Проект разделен как monorepo:

- `apps/kanban_app/` содержит Flutter client.
- `apps/kanban_server/` уже содержит Dart backend на `shelf`/`shelf_router`.
- `packages/kanban_contracts/` содержит общие API routes и DTO для app/server.
- корень содержит orchestration: `Makefile`, Docker Compose и docs.
- PostgreSQL используется как серверная БД.
- Drift остается локальным offline-first кешем Flutter-приложения.

Важно: структурное app/server-разделение выполнено. Полная production sync
еще не завершена.

## Как Запускать

Установить зависимости всех частей:

```bash
make get
```

Запустить PostgreSQL:

```bash
docker compose up postgres
```

Запустить сервер:

```bash
make server-run
```

Запустить Flutter web:

```bash
cd apps/kanban_app && flutter run -d chrome
```

Проверки:

```bash
make analyze
make test
```

## Режимы Клиента

Конфиг находится в `apps/kanban_app/lib/src/core/config/app_config.dart`.

- `RemoteMode.local` — стандартный режим разработки, UI работает через Drift и
  local/mock remote adapters.
- `RemoteMode.server` — клиент использует API datasources и sync pull с
  локального/настоящего сервера.

Для локального backend используй `AppConfig.serverDevelopment()`.

## App Слои

Клиент использует feature-first Clean Architecture:

```text
apps/kanban_app/lib/src/features/<feature>/
  domain/        сущности, value objects, контракты, use cases
  application/   команды, query services, projection/state
  data/          Drift/API datasources, DTO, mappers, repositories
  presentation/  Riverpod providers/controllers, pages, widgets
```

Инфраструктура клиента:

- `apps/kanban_app/lib/src/app/` — bootstrap, router, app-level theme.
- `apps/kanban_app/lib/src/core/config/` — runtime config.
- `apps/kanban_app/lib/src/core/database/` — Drift database и таблицы.
- `apps/kanban_app/lib/src/core/network/` — API client и endpoint facade.
- `apps/kanban_app/lib/src/core/providers/` — главная сборка providers.
- `apps/kanban_app/lib/src/core/storage/` — secure/device storage.
- `apps/kanban_app/lib/src/core/sync/` — sync manager, realtime, outbox,
  server-state puller.
- `apps/kanban_app/lib/core/` — общий UI-kit, layout, theme primitives.

## Server Слои

Backend живет в `apps/kanban_server/`.

Основные зоны:

- `bin/server.dart` — production/dev entrypoint, конфиг, DB, миграции.
- `lib/server.dart` — HTTP router и handlers.
- `lib/src/config/` — env config.
- `lib/src/database/` — PostgreSQL connection, migrations, health check.
- `lib/src/auth/` — users, password hashing, JWT, refresh sessions.
- `lib/src/workspaces/` — workspaces и members.
- `lib/src/boards/` — boards, columns, task types.
- `lib/src/tasks/` — tasks, comments, assignees, history.
- `migrations/` — SQL-миграции PostgreSQL.
- `test/server_test.dart` — HTTP/in-memory server tests.

Сервер сейчас умеет:

- auth: register/login/refresh/logout/me;
- users search;
- workspaces list/create/members;
- boards CRUD/members;
- columns CRUD;
- task-types CRUD;
- tasks CRUD;
- task comments CRUD;
- task assignees assign/unassign/list;
- task history list;
- health, changes summary scaffold, sync delta scaffold.

## Shared Contracts

`packages/kanban_contracts/` — единственный источник правды для wire-DTO и
строк API routes.

Туда уже вынесены:

- auth/session/user DTO;
- workspace DTO;
- board/column/task-type DTO;
- task/comment/assignee DTO;
- task history DTO;
- changes summary DTO;
- sync delta DTO;
- realtime event DTO;
- API error DTO;
- `KanbanApiRoutes`.

Если app и server должны обмениваться JSON, сначала добавляй/меняй контракт в
этом пакете, затем адаптируй client/server.

## Drift База Клиента

Актуальная schema version указана в
`apps/kanban_app/lib/src/core/database/app_database.dart`.

В базе есть таблицы для:

- boards;
- board columns;
- tasks;
- task types;
- task history;
- board card settings;
- users;
- workspaces;
- workspace members;
- board members;
- task assignees;
- task comments;
- invitations.

`app_database.g.dart` и `*.freezed.dart` генерируются автоматически. Не
редактируй их вручную.

Команда генерации:

```bash
cd apps/kanban_app && dart run build_runner build
```

## Sync

Текущее состояние sync:

- repositories пишут в локальную Drift БД;
- часть repositories в `RemoteMode.server` сразу пробует optimistic push;
- `SyncManager` дергает `/sync/delta`;
- `ServerStatePuller` подтягивает готовые server endpoints: workspaces,
  workspace members, boards, board members, task types, tasks, comments,
  assignees и history;
- outbox contracts существуют, но persistent outbox worker еще не завершен;
- realtime abstraction есть, но продуктовое применение событий к Drift еще
  не завершено.

Что не считать готовым:

- полноценный retry worker;
- полное разрешение конфликтов;
- обработка всех удалений/tombstones;
- pull для всех сущностей;
- production realtime merge.

## Что Еще Не Завершено

После структурного разделения осталось:

- добавить серверный list endpoint для columns и подключить его к pull;
- дотянуть invitations и users beyond search, когда server endpoints готовы;
- реализовать persistent sync outbox;
- обработать tombstones и конфликты;
- сделать серверный WebSocket broadcast;
- подключить “Что изменилось, пока вас не было” к реальным PostgreSQL данным;
- расширить permission checks на сервере;
- добавить PostgreSQL integration tests через Docker/test DB.

## Правила Сопровождения

- Не удаляй пользовательские изменения и не делай destructive git-команды.
- Не редактируй generated-файлы вручную.
- Для новых app/server JSON-моделей сначала меняй `kanban_contracts`.
- Для Flutter UI сохраняй offline-first слой: UI работает через repositories,
  а repositories уже решают local/server/sync.
- После архитектурных изменений запускай `make analyze` и `make test`.
- Если добавляешь новый исходный файл, начни его с короткого комментария:
  что это за файл и какую роль он играет.
