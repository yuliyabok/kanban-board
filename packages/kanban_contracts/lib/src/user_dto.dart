// Контракт пользователя для server API. Не содержит password hash/salt.
final class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
    this.position,
    this.avatarUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      position: json['position'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String email;
  final String fullName;
  final String? position;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      if (position != null) 'position': position,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
    };
  }
}
