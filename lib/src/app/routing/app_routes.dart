enum AppRoute {
  login('/login'),
  register('/register'),
  profile('/profile'),
  settings('/settings'),
  workspaces('/workspaces'),
  invitations('/invitations'),
  acceptInvitation('/invitations/:token/accept'),
  boards('/boards'),
  calendar('/calendar'),
  boardTasks('/boards/:boardId/tasks')
  ;

  const AppRoute(this.path);

  final String path;
}
