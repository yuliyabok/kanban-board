## Проект: Kanban Board

### Краткий статус

Проект уже представляет собой рабочее Flutter-приложение по архитектуре и
локальному хранению данных, но пока не является полностью завершенным
продуктом.

Сейчас в проекте:

- есть локальная офлайн-модель данных на Drift
- есть модули `auth`, `boards`, `tasks`, `columns`, `board_constructor`
- есть экран досок и экран канбан-доски
- есть режим конструктора доски для управления столбцами
- есть подготовленная, но не завершенная синхронизация

Ограничения текущего состояния:

- авторизация требует реального backend API
- конфиг по умолчанию указывает на `https://api.example.local`
- синхронизация и realtime пока оформлены как каркас
- часть CRUD-сценариев еще не доведена до полного UX

### Из чего состоит проект

#### 1. Точка входа и приложение

- `lib/main.dart` — запуск приложения
- `lib/src/app/bootstrap.dart` — инициализация, `ProviderScope`, логирование
- `lib/src/app/app.dart` — `MaterialApp.router`
- `lib/src/app/routing/` — маршруты и redirect-логика
- `lib/src/app/theme/` — тема и design tokens

#### 2. Базовая инфраструктура

`lib/src/core/`:

- `config/` — конфигурация окружения
- `database/` — Drift база и таблицы
- `network/` — `DioApiClient`
- `storage/` — secure storage
- `sync/` — `SyncManager` и WebSocket-абстракция
- `providers/` — общие Riverpod-провайдеры
- `error/` — исключения, failure-модели, result-тип
- `usecases/`, `utils/` — базовые вспомогательные типы

#### 3. Общий UI-слой

В проекте есть отдельный reusable UI-слой вне `src`:

`lib/core/`:

- `layout/` — `AppShell`, adaptive/responsive layout helpers
- `theme/` — spacing, colors, icons, shadows, typography, theme controller
- `widgets/` — общие кнопки, карточки, поля ввода, диалоги, skeleton и т.д.

Дополнительно:

- `lib/src/shared/ui/` — shared UI-компоненты, используемые feature-модулями

#### 4. Feature-модули

`features/auth/`

- сущности сессии и credentials
- use cases: `signIn`, `register`, `restoreSession`, `refreshSession`,
  `signOut`
- secure storage для сохранения сессии
- login/register UI
- реальный `AuthRemoteDataSource` через API

`features/boards/`

- сущность доски
- локальный datasource на Drift
- offline-first repository
- экран списка досок
- создание доски из UI

Важно:

- для boards сейчас подключен `LocalBoardRemoteDataSource`, а не реальный API

`features/columns/`

- сущность столбца доски
- Drift datasource
- use cases создания, удаления, переименования и reorder
- offline-first repository

Важно:

- для columns сейчас используется `LocalColumnRemoteDataSource`

`features/board_constructor/`

- отдельный presentation-модуль конструктора доски
- режим редактирования структуры столбцов
- добавление, переименование, reorder и удаление столбцов
- логика обработки задач при удалении столбца

`features/tasks/`

- сущность задачи
- локальный datasource на Drift
- offline-first repository
- создание, обновление, удаление, reorder задач
- поиск по задачам
- kanban-экран с колонками
- toggle complete

Важно:

- для tasks сейчас используется `LocalTaskRemoteDataSource`

### Структура данных

Сейчас база данных состоит из трех таблиц:

- `BoardsTable`
- `BoardColumnsTable`
- `TasksTable`

`schemaVersion = 3`

Что хранится:

- доски
- столбцы конкретной доски
- задачи с `boardId`
- у задачи есть nullable `columnId`
- у сущностей есть `isSynced` и `syncAction` для будущей синхронизации

### Что уже реализовано

- Clean Architecture по feature-срезам
- Riverpod DI и state management
- навигация через GoRouter
- локальная база Drift для web/desktop/mobile
- авторизация и хранение сессии
- список досок
- создание досок
- экран канбан-доски
- создание задач
- удаление задач
- reorder задач
- поиск по задачам
- работа со столбцами через конструктор доски
- базовые shared UI-компоненты и app shell

### Что еще не завершено

- рабочий backend по умолчанию для запуска auth
- полноценная sync queue
- retry-механизм синхронизации
- обработка входящих realtime-событий
- разрешение конфликтов локальных и удаленных изменений
- полный UI для редактирования и удаления досок
- полный UI для редактирования карточки задачи
- расширенные поля задач: сроки, приоритеты, участники, метки, комментарии
- полноценное покрытие unit/integration тестами

### Как воспринимать текущий проект

На текущий момент это не просто пустой шаблон, а уже собранная кодовая база с
реальной предметной моделью канбан-доски, локальной базой данных, несколькими
feature-модулями и современным UI-каркасом. При этом проект пока ближе к
сильному MVP/основе продукта, чем к полностью законченному приложению с
боевым backend и завершенной синхронизацией.
