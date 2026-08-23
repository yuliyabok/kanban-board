// Внутренние модели auth-слоя сервера. Они содержат password hash/salt и не
// уходят наружу в клиентский API.
import 'package:kanban_contracts/kanban_contracts.dart';

final class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.passwordHash,
    required this.passwordSalt,
    required this.createdAt,
    required this.updatedAt,
    this.position,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final String? position;
  final String? avatarUrl;
  final String passwordHash;
  final String passwordSalt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserDto toPublicDto() {
    return UserDto(
      id: id,
      email: email,
      fullName: fullName,
      position: position,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

final class RefreshSession {
  const RefreshSession({
    required this.id,
    required this.userId,
    required this.refreshTokenHash,
    required this.expiresAt,
    required this.createdAt,
    this.revokedAt,
  });

  final String id;
  final String userId;
  final String refreshTokenHash;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime? revokedAt;

  bool get isActive =>
      revokedAt == null && expiresAt.isAfter(DateTime.now().toUtc());
}
