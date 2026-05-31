# Анализ проекта Kanban Board

## Что это за проект

`kanban_board` — кроссплатформенное Flutter-приложение для канбан-досок с
офлайн-первым локальным хранением на Drift, Riverpod для DI/state management,
GoRouter для навигации и подготовленным слоем синхронизации.

Код построен вокруг feature-first/Clean Architecture:

- `domain` описывает бизнес-модель, контракты репозиториев и use cases
- `application` собирает сценарии приложения, command services, queries и
  view state для экранов
- `data` работает с Drift/API/DTO/мапперами и реализациями репозиториев
- `presentation` содержит Riverpod-контроллеры, providers, страницы и виджеты
- `core` содержит инфраструктуру: база, сеть, storage, sync, ошибки, DI
- `lib/core` содержит UI-kit, тему, layout и переиспользуемые виджеты

## Как работает приложение

1. `lib/main.dart` вызывает `bootstrap()`.
2. `bootstrap()` включает Flutter binding, настраивает logging и запускает
   `ProviderScope` с `KanbanApp`.
3. `KanbanApp` строит `MaterialApp.router`, подключает тему и роутер.
4. `appRouterProvider` смотрит на `authControllerProvider` и перенаправляет
   неавторизованного пользователя на `/login`.
5. Инфраструктурные провайдеры из `core_providers.dart` создают конфиг,
   Drift-базу, API-клиент, secure storage, realtime connection и sync manager.
6. Feature-провайдеры собирают datasources, repositories, use cases и
   application services.
7. Application query/services собирают `BoardViewState`, фильтруют,
   группируют и оркестрируют изменения задач/колонок.
8. UI-страницы читают `AsyncValue` из providers/controllers и вызывают
   контроллеры для действий пользователя.
9. Репозитории сохраняют изменения локально и отмечают сущности полями
   `isSynced`/`syncAction` для будущей синхронизации.

## Текущий статус

Работает:

- запуск приложения, тема, маршрутизация, базовый shell
- авторизация на уровне клиента: login/register/restore/refresh/sign out
- локальная база Drift, schema version `9`
- доски, колонки, задачи, типы задач, настройки карточек
- рабочие пространства, участники, назначения, комментарии, приглашения
- экран списка досок
- экран канбан-доски
- конструктор доски: добавление, переименование, reorder и удаление колонок
- локальные mock/placeholder remote datasources для части feature-модулей

Ограничения:

- `AppConfig.development()` смотрит на `https://api.example.local`
- auth ожидает реальный backend
- sync manager пока координирует состояние, но не содержит полноценной очереди
- добавлены контракты outbox-синхронизации, но они еще не подключены к Drift
- realtime-события подготовлены архитектурно, но не обрабатываются как продуктовая
  синхронизация
- часть UI-сценариев уже есть, но не все CRUD-потоки доведены до полноценного UX

## Карта файлов

### Корень проекта

- `.gitignore` — исключения для Git.
- `.metadata` — служебная метаинформация Flutter-проекта.
- `analysis_options.yaml` — правила статического анализа Dart.
- `pubspec.yaml` — зависимости, SDK constraint и настройки Flutter.
- `pubspec.lock` — зафиксированные версии зависимостей.
- `README.md` — краткое описание проекта, запуск и текущий статус.
- `ANALYSIS.md` — этот документ: устройство проекта и архитектурный аудит.
- `DESIGN_SYSTEM.md` — описание дизайн-системы.
- `agent.md` — памятка для сопровождения проекта.
- `RUN_WEB.sh` — быстрый запуск web-версии.
- `build_desktop.sh` — сборка desktop-версии.
- `flutter_fix_linux.sh` — вспомогательный скрипт для Linux/Flutter.
- `devtools_options.yaml` — настройки Dart/Flutter DevTools.
- `kanban_board.iml` — IDE-файл проекта.

### Точка входа и app layer

- `lib/main.dart` — минимальная точка входа, вызывает `bootstrap()`.
- `lib/src/app/bootstrap.dart` — инициализация Flutter, logging и `ProviderScope`.
- `lib/src/app/app.dart` — корневой `MaterialApp.router`, тема и router config.
- `lib/src/app/routing/app_routes.dart` — enum/описание маршрутов приложения.
- `lib/src/app/routing/app_router.dart` — GoRouter, redirect по auth-состоянию.
- `lib/src/app/theme/app_design_tokens.dart` — design tokens для нового UI.
- `lib/src/app/theme/app_theme.dart` — Material theme на основе design tokens.

### Core: инфраструктура

- `lib/src/core/config/app_config.dart` — конфигурация окружения: API URL,
  websocket URL, имя базы.
- `lib/src/core/providers/core_providers.dart` — общие Riverpod-провайдеры:
  config, database, API client, storage, realtime, sync.
- `lib/src/core/network/api_client.dart` — абстракция API client и Dio-реализация.
- `lib/src/core/network/api_endpoints.dart` — константы endpoint-ов backend API.
- `lib/src/core/error/app_exception.dart` — исключения infrastructural/data layer.
- `lib/src/core/error/failure.dart` — failure-модели для domain/application layer.
- `lib/src/core/error/result.dart` — `Success/Error` result-тип без throw в use cases.
- `lib/src/core/usecases/use_case.dart` — базовые интерфейсы use case.
- `lib/src/core/utils/typedefs.dart` — общие typedef-ы.

### Core: база данных

- `lib/src/core/database/app_database.dart` — Drift database, список таблиц,
  schema version `9`, миграции.
- `lib/src/core/database/app_database.g.dart` — сгенерированный Drift-код,
  руками не редактировать.
- `lib/src/core/database/tables/boards_table.dart` — таблица досок.
- `lib/src/core/database/tables/board_columns_table.dart` — таблица колонок доски.
- `lib/src/core/database/tables/tasks_table.dart` — таблица задач и подзадач.
- `lib/src/core/database/tables/task_types_table.dart` — типы задач на доске.
- `lib/src/core/database/tables/board_card_settings_table.dart` — настройки вида
  карточек и колонок.
- `lib/src/core/database/tables/users_table.dart` — пользователи.
- `lib/src/core/database/tables/workspaces_table.dart` — рабочие пространства.
- `lib/src/core/database/tables/workspace_members_table.dart` — участники
  рабочих пространств.
- `lib/src/core/database/tables/board_members_table.dart` — участники досок.
- `lib/src/core/database/tables/task_assignees_table.dart` — назначения задач.
- `lib/src/core/database/tables/task_comments_table.dart` — комментарии задач.
- `lib/src/core/database/tables/invitations_table.dart` — приглашения.

### Core: storage и sync

- `lib/src/core/storage/secure_storage.dart` — secure storage для auth-сессии.
- `lib/src/core/storage/device_storage.dart` — platform interface для storage.
- `lib/src/core/storage/device_storage/device_storage_io.dart` — IO-реализация.
- `lib/src/core/storage/device_storage/device_storage_web.dart` — web-реализация.
- `lib/src/core/storage/device_storage/device_storage_stub.dart` — fallback/stub.
- `lib/src/core/sync/sync_manager.dart` — coordinator синхронизации и ее статусы.
- `lib/src/core/sync/realtime_connection.dart` — websocket connection abstraction.
- `lib/src/core/sync/realtime_service.dart` — сервис realtime-событий, сейчас mock.

### UI-kit и layout

- `lib/core/layout/app_shell.dart` — общий shell экранов: заголовок, поиск, actions.
- `lib/core/layout/adaptive_layout.dart` — adaptive layout helper.
- `lib/core/layout/responsive_builder.dart` — responsive builder.
- `lib/core/theme/app_theme.dart` — старая/общая тема приложения.
- `lib/core/theme/theme_controller.dart` — контроллер смены theme mode.
- `lib/core/theme/app_colors.dart` — палитра цветов.
- `lib/core/theme/app_text_styles.dart` — типографика.
- `lib/core/theme/app_spacing.dart` — отступы.
- `lib/core/theme/app_radius.dart` — радиусы.
- `lib/core/theme/app_shadows.dart` — тени.
- `lib/core/theme/app_durations.dart` — длительности анимаций.
- `lib/core/theme/app_breakpoints.dart` — классы устройств и breakpoints.
- `lib/core/theme/app_icons.dart` — единая точка иконок.
- `lib/core/theme/app_board_background_palette.dart` — палитра фона доски/колонок.
- `lib/core/theme/app_task_text_color_palette.dart` — палитра текста карточек.
- `lib/core/theme/app_task_type_color_palette.dart` — палитра типов задач.
- `lib/core/widgets/app_button.dart` — общая кнопка.
- `lib/core/widgets/app_icon_button.dart` — общая icon-кнопка.
- `lib/core/widgets/app_text_field.dart` — общее поле ввода.
- `lib/core/widgets/app_card.dart` — общая карточка.
- `lib/core/widgets/app_dialog.dart` — общий диалог.
- `lib/core/widgets/app_context_menu.dart` — контекстное меню.
- `lib/core/widgets/app_empty_state.dart` — пустое состояние.
- `lib/core/widgets/app_loading_skeleton.dart` — skeleton loading.
- `lib/src/shared/ui/app_adaptive.dart` — shared adaptive helpers.
- `lib/src/shared/ui/app_empty_state.dart` — shared empty state для feature UI.
- `lib/src/shared/ui/loading_skeleton.dart` — shared skeleton.
- `lib/src/shared/ui/premium_card.dart` — декоративная/акцентная shared card.

### Auth

- `auth/domain/entities/*.dart` — domain-сущности credentials, session,
  registration data.
- `auth/domain/repositories/auth_repository.dart` — контракт auth-репозитория.
- `auth/domain/usecases/*.dart` — sign in, register, restore, refresh, sign out.
- `auth/data/dto/*.dart` — DTO для API.
- `auth/data/mappers/auth_mapper.dart` — преобразование DTO/domain.
- `auth/data/datasources/auth_local_datasource.dart` — хранение сессии локально.
- `auth/data/datasources/auth_remote_datasource.dart` — API-запросы авторизации.
- `auth/data/repositories/default_auth_repository.dart` — реализация auth flow.
- `auth/presentation/providers/auth_providers.dart` — DI auth feature.
- `auth/presentation/controllers/auth_controller.dart` — состояние сессии и действия.
- `auth/presentation/pages/login_page.dart` — экран входа.
- `auth/presentation/pages/register_page.dart` — экран регистрации.
- `auth/presentation/pages/profile_page.dart` — экран профиля.
- `auth/presentation/widgets/login_form.dart` — форма входа.

### Boards

- `boards/domain/entities/board_entity.dart` — domain-сущность доски.
- `boards/domain/repositories/board_repository.dart` — контракт досок.
- `boards/domain/usecases/create_board.dart` — создание доски.
- `boards/domain/usecases/watch_boards.dart` — поток досок пользователя.
- `boards/data/datasources/board_local_datasource.dart` — Drift-доступ к доскам.
- `boards/data/datasources/board_remote_datasource.dart` — remote datasource,
  сейчас локальный placeholder для sync path.
- `boards/data/mappers/board_mapper.dart` — Drift/DTO/domain mapping.
- `boards/data/repositories/offline_first_board_repository.dart` — offline-first
  репозиторий досок.
- `boards/presentation/providers/board_providers.dart` — DI досок.
- `boards/presentation/controllers/boards_controller.dart` — действия экрана досок.
- `boards/presentation/pages/boards_page.dart` — список досок и создание доски.
- `boards/presentation/widgets/board_card.dart` — карточка доски.

### Columns

- `columns/domain/entities/board_column_entity.dart` — domain-сущность колонки.
- `columns/domain/repositories/column_repository.dart` — контракт колонок.
- `columns/domain/usecases/*.dart` — watch/create/delete/rename/reorder колонок.
- `columns/data/dto/board_column_dto.dart` — DTO колонки.
- `columns/data/mappers/board_column_mapper.dart` — mapping колонки.
- `columns/data/datasources/column_local_datasource.dart` — Drift-доступ.
- `columns/data/datasources/column_remote_datasource.dart` — remote placeholder.
- `columns/data/repositories/offline_first_column_repository.dart` — offline-first
  репозиторий колонок.
- `columns/presentation/providers/column_providers.dart` — DI колонок.

### Tasks

- `tasks/domain/entities/task_entity.dart` — domain-сущность задачи/подзадачи.
- `tasks/domain/value_objects/task_enums.dart` — статусы, приоритеты и периоды.
- `tasks/domain/repositories/task_repository.dart` — контракт задач.
- `tasks/domain/usecases/*.dart` — создание, обновление, удаление, reorder,
  подзадачи, период, тип задачи, watch задач доски.
- `tasks/data/dto/task_dto.dart` — DTO задачи.
- `tasks/data/mappers/task_mapper.dart` — mapping задачи.
- `tasks/data/datasources/task_local_datasource.dart` — Drift-доступ к задачам.
- `tasks/data/datasources/task_remote_datasource.dart` — remote placeholder.
- `tasks/data/repositories/offline_first_task_repository.dart` — offline-first
  репозиторий задач.
- `tasks/presentation/providers/task_providers.dart` — DI задач.
- `tasks/presentation/controllers/tasks_controller.dart` — application actions
  для задач: create, update, move, reorder, delete, subtasks.
- `tasks/presentation/controllers/task_card_controller.dart` — состояние/действия
  карточки задачи.
- `tasks/presentation/controllers/task_details_controller.dart` — состояние
  деталей задачи.
- `tasks/presentation/controllers/task_period_controller.dart` — управление
  периодом задачи.
- `tasks/presentation/pages/tasks_page.dart` — основной экран канбан-доски.
- `tasks/presentation/widgets/board_column_view.dart` — UI одной колонки.
- `tasks/presentation/widgets/task_tile.dart` — компактное отображение задачи.
- `tasks/presentation/widgets/task_card/*.dart` — карточка задачи и ее части:
  badges, quick actions, progress, subtasks, period picker, assignees.

### Board constructor

- `board_constructor/presentation/controllers/board_constructor_state.dart` —
  draft-состояние конструктора доски.
- `board_constructor/presentation/controllers/board_constructor_controller.dart`
  — редактирование draft-колонок и сохранение изменений.
- `board_constructor/presentation/widgets/constructor_toolbar.dart` — toolbar
  режима конструктора.
- `board_constructor/presentation/widgets/constructor_column_card.dart` —
  карточка редактируемой колонки.
- `board_constructor/presentation/widgets/constructor_appearance_panel.dart` —
  настройки внешнего вида.
- `board_constructor/presentation/widgets/constructor_task_types_panel.dart` —
  управление типами задач.

### Board settings и task types

- `board_settings/domain/entities/board_card_settings.dart` — настройки карточек.
- `board_settings/domain/repositories/board_settings_repository.dart` — контракт.
- `board_settings/domain/usecases/*.dart` — watch/update настроек.
- `board_settings/data/datasources/board_card_settings_local_datasource.dart` —
  Drift-доступ к настройкам.
- `board_settings/data/mappers/board_card_settings_mapper.dart` — mapping.
- `board_settings/data/repositories/local_board_settings_repository.dart` —
  локальный репозиторий настроек.
- `board_settings/presentation/controllers/board_card_settings_controller.dart`
  — сохранение настроек карточек.
- `board_settings/presentation/providers/board_card_settings_providers.dart` —
  DI настроек.
- `board_settings/presentation/widgets/task_card_settings_panel.dart` —
  UI-панель настройки карточек.
- `task_types/domain/entities/task_type_entity.dart` — тип задачи.
- `task_types/domain/repositories/task_type_repository.dart` — контракт типов.
- `task_types/domain/usecases/*.dart` — watch/create/update типов.
- `task_types/data/*` — datasource, DTO, mapper, offline-first repository.
- `task_types/presentation/controllers/task_types_controller.dart` — действия
  для типов задач.
- `task_types/presentation/providers/task_type_providers.dart` — DI типов.
- `task_types/presentation/widgets/task_type_color_picker.dart` — выбор цвета.

### Collaboration: users, members, assignees, comments, invitations

- `users/domain/entities/user_entity.dart` — пользователь.
- `users/domain/repositories/user_repository.dart` — контракт пользователей.
- `users/domain/usecases/user_usecases.dart` — сценарии работы с пользователями.
- `users/data/*` — local/remote datasources, DTO, mapper, repository.
- `users/presentation/providers/user_providers.dart` — DI пользователей.
- `board_members/domain/entities/board_member_entity.dart` — участник доски.
- `board_members/domain/repositories/board_member_repository.dart` — контракт.
- `board_members/domain/usecases/board_member_usecases.dart` — сценарии members.
- `board_members/data/*` — datasources, DTO, mapper, repository.
- `board_members/presentation/providers/board_member_providers.dart` — DI.
- `board_members/presentation/widgets/*.dart` — панель участников, приглашение,
  avatar stack, dropdown роли.
- `task_assignees/domain/entities/task_assignee_entity.dart` — назначение задачи.
- `task_assignees/domain/repositories/task_assignee_repository.dart` — контракт.
- `task_assignees/domain/usecases/task_assignee_usecases.dart` — assign/unassign.
- `task_assignees/data/*` — datasources, DTO, mapper, repository.
- `task_assignees/presentation/providers/task_assignee_providers.dart` — DI.
- `task_assignees/presentation/widgets/*.dart` — picker, аватары, фильтр "мои".
- `comments/domain/entities/task_comment_entity.dart` — комментарий задачи.
- `comments/domain/repositories/task_comment_repository.dart` — контракт.
- `comments/domain/usecases/task_comment_usecases.dart` — CRUD комментариев.
- `comments/data/*` — datasources, DTO, mapper, repository.
- `comments/presentation/providers/task_comment_providers.dart` — DI.
- `comments/presentation/widgets/*.dart` — список, input, item, edit/delete UI.
- `invitations/domain/entities/invitation_entity.dart` — приглашение.
- `invitations/domain/repositories/invitation_repository.dart` — контракт.
- `invitations/domain/usecases/invitation_usecases.dart` — accept/list/create.
- `invitations/data/*` — local/remote datasources, DTO, mapper, repository.
- `invitations/presentation/pages/*.dart` — accept/pending invitations screens.
- `invitations/presentation/providers/invitation_providers.dart` — DI.
- `invitations/presentation/widgets/invitation_status_badge.dart` — badge статуса.

### Workspaces и permissions

- `workspaces/domain/entities/workspace_entity.dart` — рабочее пространство.
- `workspaces/domain/repositories/workspace_repository.dart` — контракт.
- `workspaces/domain/usecases/workspace_usecases.dart` — CRUD/workspace members.
- `workspaces/data/*` — datasources, DTO, mapper, repository.
- `workspaces/presentation/providers/workspace_providers.dart` — DI.
- `workspaces/presentation/pages/*.dart` — список, участники, настройки workspace.
- `workspaces/presentation/widgets/invite_workspace_member_dialog.dart` —
  приглашение участника workspace.
- `permissions/domain/entities/permission.dart` — permission-модель.
- `permissions/domain/repositories/permission_repository.dart` — контракт.
- `permissions/domain/usecases/permission_usecases.dart` — проверка прав.
- `permissions/data/repositories/default_permission_repository.dart` — реализация.
- `permissions/presentation/providers/permission_providers.dart` — DI прав.

### Generated Dart files

- `*.freezed.dart` — сгенерированные immutable/copyWith/union helpers Freezed.
- `*.g.dart` — сгенерированная JSON/Drift-сериализация.

Эти файлы не редактируются руками. Их обновляют командой:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Tests

- `test/widget_test.dart` — smoke/widget test.
- `test/auth_local_datasource_test.dart` — проверка локального auth datasource.
- `test/collaboration_architecture_test.dart` — архитектурные проверки
  collaboration-модулей.

### Platform folders

- `android/` — Android runner, Gradle config, manifest, launch resources.
- `ios/` — iOS runner, Xcode project, app icons, launch screens.
- `linux/` — Linux runner и CMake.
- `macos/` — macOS runner, Xcode project, entitlements.
- `windows/` — Windows runner, CMake, resources.
- `web/` — web runner, manifest, `index.html`, Drift worker и `sqlite3.wasm`.

## Где бизнес-логика и интерфейс уже отделены хорошо

- Domain-сущности не зависят от Flutter UI.
- Use cases вынесены из виджетов и возвращают `Result`.
- Data layer отделен через repository contracts.
- Drift-таблицы и DTO не протекают напрямую в UI: используются mappers.
- Riverpod providers собирают зависимости централизованно.
- Большая часть виджетов получает callbacks, а не работает напрямую с базой.

## Где логика смешивается с UI

### 1. `TasksPage` слишком много знает

`tasks_page.dart` одновременно:

- собирает много async-состояний
- фильтрует задачи по поиску и "мои задачи"
- управляет bottom sheets/dialogs
- переключает режим конструктора
- дергает auth/sign out
- открывает настройки, участников, карточки, комментарии
- содержит keyboard shortcuts

Оптимизация:

- вынести query/filter/selected task/create-column state в отдельный controller,
  например `TaskBoardController`
- сделать отдельную view model: `TaskBoardViewState`
- в странице оставить только layout и отображение `AsyncValue`
- вынести построение колонок в отдельный `TaskBoardView`

### 2. `BoardColumnView` собирает derived model внутри widget

Виджет сам ищет:

- родительскую задачу
- список подзадач
- тип задачи

Это не storage-бизнес-логика, но это application/view logic. При росте доски
такие `where()` внутри `ListView.builder` будут повторяться много раз.

Оптимизация:

- подготовить `TaskCardViewModel` заранее в provider/controller
- построить индексы `tasksByParentId`, `taskById`, `taskTypeById`
- передавать в колонку уже готовые карточки/модели

### 3. `TasksController.reorder*` делает reorder через много update calls

Сейчас reorder пересчитывает позиции в controller и вызывает `updateTask` для
каждой задачи. Это бизнес-операция уровня use case/repository.

Оптимизация:

- добавить use case `ReorderTasks`/`MoveTaskToColumn`
- добавить repository-методы batch update positions
- делать транзакцию в local datasource

### 4. `BoardConstructorController.save()` содержит сложную orchestration logic

Контроллер решает, что делать с задачами удаленной колонки, создает/удаляет/
переименовывает колонки и запускает reorder. Это application service, но он уже
плотно находится в presentation layer.

Оптимизация:

- вынести сохранение draft-а в use case `SaveBoardStructure`
- оставить в controller только draft-состояние формы
- use case должен принимать `BoardStructureDraft` и `DeletedColumnTaskPlan`
- операции по колонкам и задачам выполнять транзакционно, насколько позволяет
  repository/data layer

### 5. Permissions почти не видны в UI actions

Модуль permissions есть, но страницы и контроллеры должны системно проверять
права перед действиями: invite, delete, rename, move, configure.

Оптимизация:

- добавить scoped providers `canEditBoardProvider`, `canManageMembersProvider`
- блокировать actions на уровне UI
- повторять проверку в use cases, чтобы защита не была только визуальной

### 6. Дублируются UI-kit слои

Есть `lib/core/widgets` и `lib/src/shared/ui`. Это не ошибка, но со временем
может привести к двум параллельным дизайн-системам.

Оптимизация:

- выбрать один основной слой UI primitives
- `src/shared/ui` оставить для feature-neutral composite widgets
- primitives типа Button/Card/TextField держать в `lib/core/widgets`

## Рекомендуемая целевая схема разделения

```text
presentation/page
  только layout, async states, dialogs, callbacks

presentation/controller
  состояние экрана, draft forms, вызов use cases

domain/usecase
  бизнес-сценарий: reorder, move, save board structure, permissions

domain/repository
  контракт хранения/синхронизации

data/repository
  offline-first orchestration

data/datasource
  Drift/API details, transactions, DTO
```

## Приоритет оптимизаций

1. Вынести из `TasksPage` состояние фильтров, selected task и подготовку board
   view model.
2. Добавить use cases `MoveTaskToColumn` и `ReorderTasks`.
3. Вынести сохранение конструктора в `SaveBoardStructure`.
4. Подготовить `TaskCardViewModel` вне `BoardColumnView`.
5. Добавить batch/transaction методы в task/column local datasources.
6. Системно подключить permissions к actions.
7. Убрать разрастание двух UI-kit слоев.

## Короткий вывод

Архитектурная база у проекта хорошая: feature-модули, domain/data/presentation,
repositories, use cases и локальная база уже разделены. Основная зона роста —
не инфраструктура, а presentation layer: несколько экранов и контроллеров
начали брать на себя orchestration logic. Если вынести reorder/move/save
structure/filter view model в use cases и controllers/view models, бизнес-логика
и интерфейс будут разделены значительно чище.
