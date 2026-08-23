<!-- Справка по серверному scaffold: как запустить backend и что уже есть. -->

# Kanban Server

Dart backend scaffold for the Kanban app.

Run locally:

```bash
dart pub get
dart run bin/server.dart
```

Environment defaults:

- `HOST=0.0.0.0`
- `PORT=8080`
- `DATABASE_URL=postgres://kanban:kanban@localhost:5432/kanban`

The current scaffold exposes health, realtime echo, changes summary, sync delta,
and working auth/users/workspaces/boards/tasks endpoints backed by PostgreSQL:

- `POST /auth/register`
- `POST /auth/login`
- `POST /auth/refresh`
- `POST /auth/logout`
- `GET /auth/me`
- `GET /users/search`
- `GET /workspaces`
- `POST /workspaces`
- `GET /workspaces/:id/members`
- `GET /boards`
- `POST /boards`
- `PATCH /boards/:id`
- `DELETE /boards/:id`
- `GET /boards/:id/members`
- `POST /columns`
- `PATCH /columns/:id`
- `DELETE /columns/:id`
- `GET /task-types?boardId=...`
- `POST /task-types`
- `PATCH /task-types/:id`
- `DELETE /task-types/:id`
- `GET /tasks?boardId=...`
- `POST /tasks`
- `PATCH /tasks/:id`
- `DELETE /tasks/:id`
- `GET /tasks/:id/comments`
- `POST /tasks/:id/comments`
- `PATCH /comments/:id`
- `DELETE /comments/:id`
- `GET /tasks/:id/assignees`
- `POST /tasks/:id/assignees`
- `DELETE /tasks/:id/assignees/:userId`
- `GET /tasks/:id/history`

Other domain endpoints intentionally return a standard `not_implemented` API
error until their PostgreSQL repositories are added.
