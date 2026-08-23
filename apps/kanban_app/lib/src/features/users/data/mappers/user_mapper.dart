import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/user_entity.dart';

extension UserRowMapper on UsersTableData {
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

extension UserEntityMapper on UserEntity {
  UsersTableCompanion toCompanion({
    String? passwordHash,
    String? passwordSalt,
  }) => UsersTableCompanion.insert(
    id: id,
    email: email,
    fullName: fullName,
    position: Value(position),
    avatarUrl: Value(avatarUrl),
    passwordHash: Value(passwordHash),
    passwordSalt: Value(passwordSalt),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
