final class ApiEndpoints {
  const ApiEndpoints._();

  static const authRegister = '/auth/register';
  static const authLogin = '/auth/login';
  static const authRefresh = '/auth/refresh';
  static const authLogout = '/auth/logout';
  static const authMe = '/auth/me';

  static const usersSearch = '/users/search';
  static String user(String id) => '/users/$id';
  static const userMe = '/users/me';

  static const workspaces = '/workspaces';
  static String workspaceMembers(String id) => '/workspaces/$id/members';
  static String workspaceInvitations(String id) =>
      '/workspaces/$id/invitations';
  static String workspaceMemberRole(String id, String userId) =>
      '/workspaces/$id/members/$userId/role';
  static String workspaceMember(String id, String userId) =>
      '/workspaces/$id/members/$userId';

  static String boardMembers(String id) => '/boards/$id/members';
  static String boardInvitations(String id) => '/boards/$id/invitations';
  static String boardMemberRole(String id, String userId) =>
      '/boards/$id/members/$userId/role';
  static String boardMember(String id, String userId) =>
      '/boards/$id/members/$userId';

  static String taskAssignees(String id) => '/tasks/$id/assignees';
  static String taskAssignee(String id, String userId) =>
      '/tasks/$id/assignees/$userId';

  static String taskComments(String id) => '/tasks/$id/comments';
  static String comment(String id) => '/comments/$id';

  static const pendingInvitations = '/invitations/pending';
  static String acceptInvitation(String token) => '/invitations/$token/accept';
  static String declineInvitation(String token) =>
      '/invitations/$token/decline';
}
