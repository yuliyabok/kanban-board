final class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
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
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? position,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
