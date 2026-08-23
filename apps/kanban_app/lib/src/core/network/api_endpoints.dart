// Фасад API-маршрутов для старого клиентского кода. Настоящие строки маршрутов
// лежат в shared package `kanban_contracts`, чтобы app и server совпадали.
import 'package:kanban_contracts/kanban_contracts.dart';

final class ApiEndpoints {
  const ApiEndpoints._();

  static const authRegister = KanbanApiRoutes.authRegister;
  static const authLogin = KanbanApiRoutes.authLogin;
  static const authRefresh = KanbanApiRoutes.authRefresh;
  static const authLogout = KanbanApiRoutes.authLogout;
  static const authMe = KanbanApiRoutes.authMe;

  static const usersSearch = KanbanApiRoutes.usersSearch;
  static String user(String id) => KanbanApiRoutes.user(id);
  static const userMe = KanbanApiRoutes.userMe;

  static const workspaces = KanbanApiRoutes.workspaces;
  static String workspaceMembers(String id) => '/workspaces/$id/members';
  static String workspaceInvitations(String id) =>
      KanbanApiRoutes.workspaceInvitations(id);
  static String workspaceMemberRole(String id, String userId) =>
      '/workspaces/$id/members/$userId/role';
  static String workspaceMember(String id, String userId) =>
      '/workspaces/$id/members/$userId';

  static String boardMembers(String id) => KanbanApiRoutes.boardMembers(id);
  static const boards = KanbanApiRoutes.boards;
  static String board(String id) => KanbanApiRoutes.board(id);
  static const columns = KanbanApiRoutes.columns;
  static String column(String id) => KanbanApiRoutes.column(id);
  static const taskTypes = KanbanApiRoutes.taskTypes;
  static String taskType(String id) => KanbanApiRoutes.taskType(id);
  static String boardInvitations(String id) =>
      KanbanApiRoutes.boardInvitations(id);
  static String boardMemberRole(String id, String userId) =>
      '/boards/$id/members/$userId/role';
  static String boardMember(String id, String userId) =>
      '/boards/$id/members/$userId';

  static String taskAssignees(String id) => KanbanApiRoutes.taskAssignees(id);
  static String taskAssignee(String id, String userId) =>
      KanbanApiRoutes.taskAssignee(id, userId);

  static const tasks = KanbanApiRoutes.tasks;
  static String taskComments(String id) => KanbanApiRoutes.taskComments(id);
  static String taskHistory(String id) => KanbanApiRoutes.taskHistory(id);
  static String comment(String id) => KanbanApiRoutes.comment(id);

  static const pendingInvitations = KanbanApiRoutes.pendingInvitations;
  static String acceptInvitation(String token) =>
      KanbanApiRoutes.acceptInvitation(token);
  static String declineInvitation(String token) =>
      KanbanApiRoutes.declineInvitation(token);

  static const changesSummary = KanbanApiRoutes.changesSummary;
  static const syncDelta = KanbanApiRoutes.syncDelta;
  static const syncPending = KanbanApiRoutes.syncPending;
}
