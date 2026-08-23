enum WorkspaceRole {
  owner,
  admin,
  member,
  viewer
  ;

  static WorkspaceRole parse(String value) => WorkspaceRole.values.firstWhere(
    (role) => role.name == value,
    orElse: () => throw ArgumentError.value(value, 'value', 'Invalid role'),
  );
}

enum BoardRole {
  admin,
  editor,
  commenter,
  viewer
  ;

  static BoardRole parse(String value) => BoardRole.values.firstWhere(
    (role) => role.name == value,
    orElse: () => throw ArgumentError.value(value, 'value', 'Invalid role'),
  );
}

enum Permission {
  viewBoard,
  editBoard,
  manageBoard,
  inviteMembers,
  removeMembers,
  createTask,
  editTask,
  deleteTask,
  moveTask,
  assignTask,
  commentTask,
  deleteComment,
  manageWorkspace,
}

enum InvitationStatus {
  pending,
  accepted,
  declined,
  expired,
}
