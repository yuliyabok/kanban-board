// Создает и проверяет access JWT. В payload кладем user id в `sub`.
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

final class VerifiedAccessToken {
  const VerifiedAccessToken({required this.userId});

  final String userId;
}

final class JwtService {
  const JwtService({
    required String secret,
    required Duration accessTokenTtl,
  }) : _secret = secret,
       _accessTokenTtl = accessTokenTtl;

  final String _secret;
  final Duration _accessTokenTtl;

  DateTime get accessTokenExpiresAt => DateTime.now().toUtc().add(
    _accessTokenTtl,
  );

  String createAccessToken({
    required String userId,
    required String email,
  }) {
    final jwt = JWT({
      'sub': userId,
      'email': email,
    });
    return jwt.sign(SecretKey(_secret), expiresIn: _accessTokenTtl);
  }

  VerifiedAccessToken? verify(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_secret));
      final payload = jwt.payload as Map<String, dynamic>;
      final subject = payload['sub'];
      if (subject is! String || subject.isEmpty) return null;
      return VerifiedAccessToken(userId: subject);
    } on Object {
      return null;
    }
  }
}
