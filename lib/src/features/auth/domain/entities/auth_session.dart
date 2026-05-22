import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String userId,
    required String email,
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
  }) = _AuthSession;
}
