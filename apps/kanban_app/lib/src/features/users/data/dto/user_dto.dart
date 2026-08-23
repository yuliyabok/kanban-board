import '../../domain/entities/user_entity.dart';

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

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    id: json['id'] as String,
    email: json['email'] as String,
    fullName: json['fullName'] as String,
    position: json['position'] as String?,
    avatarUrl: json['avatarUrl'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  final String id;
  final String email;
  final String fullName;
  final String? position;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'email': email,
    'fullName': fullName,
    'position': position,
    'avatarUrl': avatarUrl,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

extension UserDtoMapper on UserDto {
  UserEntity toEntity() => UserEntity(
    id: id,
    email: email,
    fullName: fullName,
    position: position,
    avatarUrl: avatarUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension UserEntityDtoMapper on UserEntity {
  UserDto toDto() => UserDto(
    id: id,
    email: email,
    fullName: fullName,
    position: position,
    avatarUrl: avatarUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
