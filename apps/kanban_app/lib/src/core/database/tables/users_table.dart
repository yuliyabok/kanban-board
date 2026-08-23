import 'package:drift/drift.dart';

class UsersTable extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get fullName => text().withLength(min: 1, max: 160)();
  TextColumn get position => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get passwordHash => text().nullable()();
  TextColumn get passwordSalt => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
