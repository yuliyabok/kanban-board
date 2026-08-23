// Контракт логина: email и пароль, которые приложение отправляет на сервер.
final class AuthCredentialsDto {
  const AuthCredentialsDto({
    required this.email,
    required this.password,
  });

  factory AuthCredentialsDto.fromJson(Map<String, dynamic> json) {
    return AuthCredentialsDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  final String email;
  final String password;

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
