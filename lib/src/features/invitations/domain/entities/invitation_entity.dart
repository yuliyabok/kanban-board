import '../../../permissions/domain/entities/permission.dart';

final class InvitationEntity {
  const InvitationEntity({
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
    this.declinedAt,
    this.isSynced = false,
  });

  final String id;
  final String email;
  final String? workspaceId;
  final String? boardId;
  final String role;
  final String token;
  final String invitedBy;
  final DateTime expiresAt;
  final DateTime? acceptedAt;
  final DateTime? declinedAt;
  final DateTime createdAt;
  final bool isSynced;

  InvitationStatus get status {
    if (acceptedAt != null) return InvitationStatus.accepted;
    if (declinedAt != null) return InvitationStatus.declined;
    if (expiresAt.isBefore(DateTime.now().toUtc())) {
      return InvitationStatus.expired;
    }
    return InvitationStatus.pending;
  }

  InvitationEntity copyWith({
    String? id,
    String? email,
    String? workspaceId,
    String? boardId,
    String? role,
    String? token,
    String? invitedBy,
    DateTime? expiresAt,
    DateTime? acceptedAt,
    DateTime? declinedAt,
    DateTime? createdAt,
    bool? isSynced,
  }) {
    return InvitationEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      workspaceId: workspaceId ?? this.workspaceId,
      boardId: boardId ?? this.boardId,
      role: role ?? this.role,
      token: token ?? this.token,
      invitedBy: invitedBy ?? this.invitedBy,
      expiresAt: expiresAt ?? this.expiresAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      declinedAt: declinedAt ?? this.declinedAt,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
