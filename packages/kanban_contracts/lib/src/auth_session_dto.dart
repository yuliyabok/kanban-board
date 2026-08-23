// Контракт auth-сессии: сервер возвращает его после register/login/refresh.
final class AuthSessionDto {
  const AuthSessionDto({
    required this.userId,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory AuthSessionDto.fromJson(Map<String, dynamic> json) {
    return AuthSessionDto(
      userId: json['userId'] as String,
      email: json['email'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String).toUtc(),
    );
  }

  final String userId;
  final String email;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toUtc().toIso8601String(),
    };
  }
}
