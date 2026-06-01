# Kanban Board

Flutter kanban board with offline-first local data, modular feature slices, and
an in-progress board constructor.

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

- real backend configuration for the app out of the box
- full sync queue and retry worker
- realtime event processing
- complete CRUD UI for boards and tasks
- broad automated test coverage

Important note:

- `auth` uses real API endpoints from `AppConfig.development()`
- `boards`, `tasks`, and `columns` are currently wired to local mock-like
  remote datasources, so their "remote sync" path is still a placeholder
- default config points to `https://api.example.local`, so login will not work
  until a real backend is connected

## What The Project Consists Of

Top-level application areas:

- `lib/main.dart`: entry point
- `lib/src/app/`: app bootstrap, router, routes, design tokens, main theme
- `lib/src/core/`: database, network client, secure storage, sync abstractions,
  errors, provider wiring
- `lib/src/features/auth/`: auth entities, use cases, repository, login UI
- `lib/src/features/boards/`: boards domain, local storage, repository, boards
  screen
- `lib/src/features/columns/`: kanban columns domain, local storage,
  repository, use cases
- `lib/src/features/board_constructor/`: constructor mode for managing board
  columns
- `lib/src/features/tasks/`: task entities, repository, board page, task UI
- `lib/src/features/task_types/`: board-specific task type setup
- `lib/src/features/board_settings/`: card and column appearance settings
- `lib/src/features/workspaces/`: workspace entities, data access, and screens
- `lib/src/features/board_members/`: board membership and roles
- `lib/src/features/task_assignees/`: task assignment
- `lib/src/features/comments/`: task comments
- `lib/src/features/invitations/`: invite and accept flows
- `lib/src/features/permissions/`: permission checks
- `lib/src/shared/ui/`: shared UI helpers used by feature screens
- `lib/core/`: reusable layout, theme, and widget primitives used by the new UI

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
lib/src/features/<feature>/
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

`lib/src/core/sync/` also contains the first outbox contracts
(`SyncOperation`, `SyncOutbox`, conflict resolver) for the future backend sync
worker. Current repositories still keep the transitional `isSynced/syncAction`
metadata until the outbox is persisted in Drift.

## Routes

Current routes:

- `/login`
- `/boards`
- `/boards/:boardId/tasks`

## Local Database

Drift schema version: `9`

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
flutter pub get
```

Generate code:

```bash
dart run build_runner build
```

Analyze:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Run web:

```bash
flutter run -d chrome
```

Build web:

```bash
flutter build web
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
`lib/src/core/config/app_config.dart`.

## Documentation Files

- `README.md`: high-level overview and current status
- `ANALYSIS.md`: detailed project breakdown in Russian
- `agent.md`: maintenance guide for future contributors and agents
