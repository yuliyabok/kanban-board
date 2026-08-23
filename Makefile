# Удобные команды для разработки всего монорепозитория: Flutter app,
# shared contracts и Dart server.
.PHONY: app-get contracts-get server-get get app-analyze contracts-analyze server-analyze analyze app-test contracts-test server-test test server-run

app-get:
	cd apps/kanban_app && flutter pub get

contracts-get:
	cd packages/kanban_contracts && dart pub get

server-get:
	cd apps/kanban_server && dart pub get

get: app-get contracts-get server-get

app-analyze:
	cd apps/kanban_app && flutter analyze

contracts-analyze:
	cd packages/kanban_contracts && dart analyze

server-analyze:
	cd apps/kanban_server && dart analyze

analyze: app-analyze contracts-analyze server-analyze

app-test:
	cd apps/kanban_app && flutter test

contracts-test:
	cd packages/kanban_contracts && dart test

server-test:
	cd apps/kanban_server && dart test

test: app-test contracts-test server-test

server-run:
	cd apps/kanban_server && dart run bin/server.dart
