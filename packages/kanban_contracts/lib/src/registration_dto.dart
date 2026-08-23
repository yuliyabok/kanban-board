// Контракт регистрации: минимальные данные для создания нового пользователя.
final class RegistrationDto {
  const RegistrationDto({
    required this.email,
    required this.password,
    this.displayName,
  });

  factory RegistrationDto.fromJson(Map<String, dynamic> json) {
    return RegistrationDto(
      email: json['email'] as String,
      password: json['password'] as String,
      displayName: json['displayName'] as String?,
    );
  }

  final String email;
  final String password;
  final String? displayName;

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
      if (displayName != null) 'displayName': displayName,
    };
  }
}
