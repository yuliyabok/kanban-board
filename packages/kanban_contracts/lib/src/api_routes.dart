// Общий список API-маршрутов. Он нужен, чтобы клиент и сервер не расходились в
// строках вроде `/tasks/:id/comments`.
final class KanbanApiRoutes {
  const KanbanApiRoutes._();

  static const health = '/health';

  static const authRegister = '/auth/register';
  static const authLogin = '/auth/login';
  static const authRefresh = '/auth/refresh';
  static const authLogout = '/auth/logout';
  static const authMe = '/auth/me';

  static const usersSearch = '/users/search';
  static String user(String id) => '/users/$id';
  static const userMe = '/users/me';

  static const workspaces = '/workspaces';
  static String workspace(String id) => '/workspaces/$id';
  static String workspaceMembers(String id) => '/workspaces/$id/members';
  static String workspaceInvitations(String id) =>
      '/workspaces/$id/invitations';

  static const boards = '/boards';
  static String board(String id) => '/boards/$id';
  static String boardMembers(String id) => '/boards/$id/members';
  static String boardInvitations(String id) => '/boards/$id/invitations';

  static const columns = '/columns';
  static String column(String id) => '/columns/$id';

  static const taskTypes = '/task-types';
  static String taskType(String id) => '/task-types/$id';

  static const tasks = '/tasks';
  static String task(String id) => '/tasks/$id';
  static String taskAssignees(String id) => '/tasks/$id/assignees';
  static String taskAssignee(String id, String userId) =>
      '/tasks/$id/assignees/$userId';
  static String taskComments(String id) => '/tasks/$id/comments';
  static String taskHistory(String id) => '/tasks/$id/history';

  static String comment(String id) => '/comments/$id';

  static const pendingInvitations = '/invitations/pending';
  static String acceptInvitation(String token) => '/invitations/$token/accept';
  static String declineInvitation(String token) =>
      '/invitations/$token/decline';

  static const changesSummary = '/changes/summary';
  static const syncDelta = '/sync/delta';
  static const syncPending = '/sync/pending';
}
