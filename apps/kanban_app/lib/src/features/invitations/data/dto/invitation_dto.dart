final class InvitationDto {
  const InvitationDto({
    required this.id,
    required this.email,
    required this.role,
    required this.token,
    required this.invitedBy,
    required this.expiresAt,
    required this.createdAt,
    this.workspaceId,
    this.boardId,
    this.acceptedAt,
  });

  factory InvitationDto.fromJson(Map<String, dynamic> json) => InvitationDto(
    id: json['id'] as String,
    email: json['email'] as String,
    workspaceId: json['workspaceId'] as String?,
    boardId: json['boardId'] as String?,
    role: json['role'] as String,
    token: json['token'] as String,
    invitedBy: json['invitedBy'] as String,
    expiresAt: DateTime.parse(json['expiresAt'] as String),
    acceptedAt: json['acceptedAt'] == null
        ? null
        : DateTime.parse(json['acceptedAt'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  final String id;
  final String email;
  final String? workspaceId;
  final String? boardId;
  final String role;
  final String token;
  final String invitedBy;
  final DateTime expiresAt;
  final DateTime? acceptedAt;
  final DateTime createdAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'email': email,
    'workspaceId': workspaceId,
    'boardId': boardId,
    'role': role,
    'token': token,
    'invitedBy': invitedBy,
    'expiresAt': expiresAt.toIso8601String(),
    'acceptedAt': acceptedAt?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };
}
