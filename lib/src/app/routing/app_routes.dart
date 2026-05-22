enum AppRoute {
  login('/login'),
  boards('/boards'),
  boardTasks('/boards/:boardId/tasks')
  ;

  const AppRoute(this.path);

  final String path;
}
