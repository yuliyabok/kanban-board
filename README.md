<!-- Главная справка monorepo: Flutter-клиент, Dart-сервер и shared contracts. -->

# Kanban Board

Flutter kanban board with offline-first local data, modular feature slices, and
an in-progress board constructor.

## Monorepo Layout

The repository is now split into separate app/server packages:

- `apps/kanban_app/` contains the Flutter client;
- `apps/kanban_server/` contains the Dart server;
- `packages/kanban_contracts/` contains shared API routes and wire DTOs.
- the repository root contains orchestration files, docs, Docker Compose, and
  the root `Makefile`.

Useful root commands:

```bash
make get
make analyze
make test
make server-run
```

PostgreSQL for local backend development:

```bash
docker compose up postgres
```

## Current Status

The project is running as a Flutter application and the codebase is healthy
enough to analyze and test locally, but the product is not fully finished yet.

What works now:

- app bootstrap, routing, theme, Riverpod wiring
- local Drift database with boards, columns, tasks, users, workspaces,
  members, assignees, comments, invitations, task types, and card settings
- auth flow code: restore session, sign in, register, refresh, sign out
- boards list and board creation
- task board UI with search, task creation, reorder, toggle complete, delete
- board constructor mode for creating, renaming, reordering, and deleting
  columns
- offline-first repositories across the main feature modules

What is still incomplete:

- full sync queue coverage for every entity type
- durable database-backed delta journal
- complete CRUD UI for boards and tasks
- broad automated test coverage

Important note:

- `AppConfig.development()` keeps `RemoteMode.local` as the safe default.
- `AppConfig.serverDevelopment()` points to `http://localhost:8080` and
  `ws://localhost:8080/realtime` for local backend development.
- runtime builds can override config with `--dart-define` values:
  `KANBAN_REMOTE_MODE`, `KANBAN_API_BASE_URL`, `KANBAN_WS_URL`, and
  `KANBAN_DATABASE_NAME`.
- production sync is still incomplete: outbox currently covers tasks, boards,
  columns, and comments; durable delta storage, broad tombstones, conflict
  policy, and full realtime merge are future steps.

## What The Project Consists Of

Top-level application areas:

- `apps/kanban_app/lib/main.dart`: entry point
- `apps/kanban_app/lib/src/app/`: app bootstrap, router, routes, tokens, theme
- `apps/kanban_app/lib/src/core/`: database, network, storage, sync,
  errors, provider wiring
- `apps/kanban_app/lib/src/features/`: feature-first client modules
- `apps/kanban_app/lib/src/shared/ui/`: shared UI helpers
- `apps/kanban_app/lib/core/`: reusable layout, theme, and widget primitives
- `apps/kanban_server/`: HTTP/WebSocket backend, PostgreSQL repositories,
  migrations, and server tests
- `packages/kanban_contracts/`: shared routes and wire DTOs

Current data model:

- `BoardsTable`: board metadata and sync flags
- `BoardColumnsTable`: board columns and their order
- `TasksTable`: tasks, positions, completion state, optional `columnId`, sync
  flags

## Architecture

- Feature-first Clean Architecture inside feature modules
- Riverpod for dependency injection and state
- Drift for local persistence
- GoRouter for navigation
- Dio for HTTP
- WebSocket abstraction for future realtime sync
- Freezed and `json_serializable` for immutable entities and DTOs

The board/task flow has an explicit application layer. Presentation reads
`BoardViewState` and dispatches command services; filtering, grouping, task
movement, reordering, and constructor commit orchestration live outside
widgets.

Feature layout:

```text
apps/kanban_app/lib/src/features/<feature>/
  application/
    commands/
    queries/
    services/
    state/
  data/
    datasources/
    dto/
    mappers/
    repositories/
  domain/
    entities/
    repositories/
    usecases/
  presentation/
    controllers/
    pages/
    providers/
    widgets/
```

Layer intent:

- `domain`: entities, repository contracts, value objects, and business
  policies without Flutter/Drift/Dio dependencies.
- `application`: use-case orchestration, board projections, command services,
  and screen state models.
- `data`: Drift/API datasources, DTOs, mappers, and offline-first repository
  implementations.
- `presentation`: widgets, dialogs, input controllers, and Riverpod UI wiring.

`apps/kanban_app/lib/src/core/sync/` contains the persistent Drift outbox
(`SyncOperation`, `SyncOutbox`, `SyncActionsTable`) and sync manager. Current
repositories still keep transitional `isSynced/syncAction` metadata while the
outbox is expanded across all entity types.

## Routes

Current routes:

- `/login`
- `/boards`
- `/boards/:boardId/tasks`

## Local Database

Drift schema version: `11`

Tables:

- `BoardsTable`
- `BoardColumnsTable`
- `TasksTable`
- `TaskTypesTable`
- `BoardCardSettingsTable`
- `UsersTable`
- `WorkspacesTable`
- `WorkspaceMembersTable`
- `BoardMembersTable`
- `TaskAssigneesTable`
- `TaskCommentsTable`
- `InvitationsTable`
- `SyncActionsTable`

Web build assets for Drift:

- `web/sqlite3.wasm`
- `web/drift_worker.dart`
- `web/drift_worker.js`

## Running The Project

Prerequisites:

- Flutter SDK
- Dart SDK

Install dependencies:

```bash
make get
```

Generate code:

```bash
cd apps/kanban_app && dart run build_runner build
```

Analyze:

```bash
make analyze
```

Run tests:

```bash
make test
```

Run web:

```bash
cd apps/kanban_app && flutter run -d chrome
```

Build web:

```bash
cd apps/kanban_app && flutter build web
```

## Backend Contract

Auth expects these endpoints:

```http
POST /auth/register
POST /auth/login
POST /auth/refresh
POST /auth/logout
```

Configured development values live in
`apps/kanban_app/lib/src/core/config/app_config.dart`.

## Documentation Files

- `README.md`: high-level overview and current status
- `agent.md`: maintenance guide for future contributors and agents
- `docs/architecture_diagrams.md`: visual Mermaid diagrams of app/server,
  sync, auth, storage, and repository flow
- `docs/project_for_beginners.md`: Russian walkthrough of how the app,
  server, contracts, storage, and sync fit together
