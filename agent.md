# Agent Guide

This document describes the current shape of the project for future agents and
contributors.

## Project Summary

`kanban_board` is a Flutter kanban application with:

- local offline-first persistence through Drift
- Riverpod-based dependency wiring
- feature-oriented Clean Architecture
- a richer UI layer split between `lib/src/...` and shared primitives in
  `lib/core/...`
- a board constructor flow for managing kanban columns

The app is partially product-ready at the local-data layer, but backend sync is
still incomplete.

## What Exists Today

Implemented modules:

- `auth`
- `boards`
- `tasks`
- `columns`
- `board_constructor`

Implemented infrastructure:

- app bootstrap and routing
- Drift database with three tables
- secure storage
- Dio API client
- WebSocket abstraction
- sync manager abstraction
- reusable shell, layout, theme, and widget primitives

## Actual Runtime State

Be careful not to overstate backend support.

- `auth` uses API-backed datasources
- `boards` currently use `LocalBoardRemoteDataSource`
- `tasks` currently use `LocalTaskRemoteDataSource`
- `columns` currently use `LocalColumnRemoteDataSource`
- `SyncManager` exists, but pending-operation orchestration is still a stub

This means the app has local kanban behavior, but does not yet have end-to-end
remote collaboration.

## Project Layout

High-level layout:

```text
lib/
  core/                 reusable UI/layout/theme primitives
  src/
    app/                bootstrap, router, theme tokens
    core/               database, network, storage, sync, providers, errors
    features/
      auth/
      boards/
      columns/
      board_constructor/
      tasks/
    shared/ui/          shared UI helpers
```

Feature layout convention:

```text
lib/src/features/<feature>/
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

`board_constructor` is presentation-only for now and coordinates `columns` and
`tasks`.

## Database

Current Drift schema version: `3`

Tables:

- `BoardsTable`
- `BoardColumnsTable`
- `TasksTable`

Important model detail:

- tasks now support nullable `columnId`
- all three tables include `isSynced` and `syncAction`

When updating schema:

1. Update or add table files in `lib/src/core/database/tables/`
2. Update `@DriftDatabase(...)`
3. Increment `schemaVersion`
4. Add a migration in `onUpgrade`
5. Run code generation
6. Run analysis and tests

Codegen command:

```bash
dart run build_runner build
```

## Auth Contract

Expected auth endpoints:

```http
POST /auth/register
POST /auth/login
POST /auth/refresh
POST /auth/logout
```

Default development config still points to placeholder URLs in
`lib/src/core/config/app_config.dart`.

## Main Screens

- `/login`
- `/boards`
- `/boards/:boardId/tasks`

The tasks screen is the most advanced UI surface. It currently combines:

- board shell layout
- search
- task creation
- task reorder and completion
- column-based presentation
- constructor mode for editing columns

## What Is Missing

- real backend configuration for default local runs
- end-to-end remote datasources for boards, tasks, and columns
- sync outbox / retry worker
- realtime event merge into Drift
- conflict resolution strategy
- full board editing and deletion UX
- fuller task details UX
- broader automated tests

## Commands

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

Test:

```bash
flutter test
```

Build web:

```bash
flutter build web
```

Run web:

```bash
flutter run -d chrome
```

## Working Notes

- Prefer documenting the real state of the project over the intended state
- Do not describe sync as finished
- Do not describe boards/tasks/columns as API-backed unless providers were
  switched away from local remotes
- If you change architecture, update `README.md`, `ANALYSIS.md`, and this file
