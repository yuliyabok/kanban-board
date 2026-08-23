<!-- Flutter-клиент Kanban Board внутри monorepo. -->

# Kanban App

This directory contains the Flutter client: UI, local Drift cache, offline-first
repositories, sync orchestration, and platform projects.

Run app commands from this directory:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

From the repository root, the same checks are available through `make get`,
`make analyze`, and `make test`.

The app may import `package:kanban_contracts` for shared API routes and DTOs. It
must not import `package:kanban_server`; server code lives separately in
`../kanban_server`.
