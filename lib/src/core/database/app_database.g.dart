// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BoardsTableTable extends BoardsTable
    with TableInfo<$BoardsTableTable, BoardsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BoardsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncActionMeta = const VerificationMeta(
    'syncAction',
  );
  @override
  late final GeneratedColumn<String> syncAction = GeneratedColumn<String>(
    'sync_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    title,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'boards_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BoardsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('sync_action')) {
      context.handle(
        _syncActionMeta,
        syncAction.isAcceptableOrUnknown(data['sync_action']!, _syncActionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BoardsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BoardsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      syncAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_action'],
      ),
    );
  }

  @override
  $BoardsTableTable createAlias(String alias) {
    return $BoardsTableTable(attachedDatabase, alias);
  }
}

class BoardsTableData extends DataClass implements Insertable<BoardsTableData> {
  final String id;
  final String ownerId;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isSynced;
  final String? syncAction;
  const BoardsTableData({
    required this.id,
    required this.ownerId,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  BoardsTableCompanion toCompanion(bool nullToAbsent) {
    return BoardsTableCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory BoardsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BoardsTableData(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  BoardsTableData copyWith({
    String? id,
    String? ownerId,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => BoardsTableData(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  BoardsTableData copyWithCompanion(BoardsTableCompanion data) {
    return BoardsTableData(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BoardsTableData(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    title,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoardsTableData &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class BoardsTableCompanion extends UpdateCompanion<BoardsTableData> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const BoardsTableCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BoardsTableCompanion.insert({
    required String id,
    required String ownerId,
    required String title,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BoardsTableData> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BoardsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return BoardsTableCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isSynced: isSynced ?? this.isSynced,
      syncAction: syncAction ?? this.syncAction,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (syncAction.present) {
      map['sync_action'] = Variable<String>(syncAction.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoardsTableCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BoardColumnsTableTable extends BoardColumnsTable
    with TableInfo<$BoardColumnsTableTable, BoardColumnsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BoardColumnsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boardIdMeta = const VerificationMeta(
    'boardId',
  );
  @override
  late final GeneratedColumn<String> boardId = GeneratedColumn<String>(
    'board_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncActionMeta = const VerificationMeta(
    'syncAction',
  );
  @override
  late final GeneratedColumn<String> syncAction = GeneratedColumn<String>(
    'sync_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    boardId,
    title,
    position,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'board_columns_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BoardColumnsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('board_id')) {
      context.handle(
        _boardIdMeta,
        boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('sync_action')) {
      context.handle(
        _syncActionMeta,
        syncAction.isAcceptableOrUnknown(data['sync_action']!, _syncActionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BoardColumnsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BoardColumnsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      boardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      syncAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_action'],
      ),
    );
  }

  @override
  $BoardColumnsTableTable createAlias(String alias) {
    return $BoardColumnsTableTable(attachedDatabase, alias);
  }
}

class BoardColumnsTableData extends DataClass
    implements Insertable<BoardColumnsTableData> {
  final String id;
  final String boardId;
  final String title;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isSynced;
  final String? syncAction;
  const BoardColumnsTableData({
    required this.id,
    required this.boardId,
    required this.title,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['board_id'] = Variable<String>(boardId);
    map['title'] = Variable<String>(title);
    map['position'] = Variable<int>(position);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  BoardColumnsTableCompanion toCompanion(bool nullToAbsent) {
    return BoardColumnsTableCompanion(
      id: Value(id),
      boardId: Value(boardId),
      title: Value(title),
      position: Value(position),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory BoardColumnsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BoardColumnsTableData(
      id: serializer.fromJson<String>(json['id']),
      boardId: serializer.fromJson<String>(json['boardId']),
      title: serializer.fromJson<String>(json['title']),
      position: serializer.fromJson<int>(json['position']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'boardId': serializer.toJson<String>(boardId),
      'title': serializer.toJson<String>(title),
      'position': serializer.toJson<int>(position),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  BoardColumnsTableData copyWith({
    String? id,
    String? boardId,
    String? title,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => BoardColumnsTableData(
    id: id ?? this.id,
    boardId: boardId ?? this.boardId,
    title: title ?? this.title,
    position: position ?? this.position,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  BoardColumnsTableData copyWithCompanion(BoardColumnsTableCompanion data) {
    return BoardColumnsTableData(
      id: data.id.present ? data.id.value : this.id,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      title: data.title.present ? data.title.value : this.title,
      position: data.position.present ? data.position.value : this.position,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BoardColumnsTableData(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('title: $title, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    boardId,
    title,
    position,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoardColumnsTableData &&
          other.id == this.id &&
          other.boardId == this.boardId &&
          other.title == this.title &&
          other.position == this.position &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class BoardColumnsTableCompanion
    extends UpdateCompanion<BoardColumnsTableData> {
  final Value<String> id;
  final Value<String> boardId;
  final Value<String> title;
  final Value<int> position;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const BoardColumnsTableCompanion({
    this.id = const Value.absent(),
    this.boardId = const Value.absent(),
    this.title = const Value.absent(),
    this.position = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BoardColumnsTableCompanion.insert({
    required String id,
    required String boardId,
    required String title,
    required int position,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       boardId = Value(boardId),
       title = Value(title),
       position = Value(position),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BoardColumnsTableData> custom({
    Expression<String>? id,
    Expression<String>? boardId,
    Expression<String>? title,
    Expression<int>? position,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (boardId != null) 'board_id': boardId,
      if (title != null) 'title': title,
      if (position != null) 'position': position,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BoardColumnsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? boardId,
    Value<String>? title,
    Value<int>? position,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return BoardColumnsTableCompanion(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isSynced: isSynced ?? this.isSynced,
      syncAction: syncAction ?? this.syncAction,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (syncAction.present) {
      map['sync_action'] = Variable<String>(syncAction.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoardColumnsTableCompanion(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('title: $title, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskTypesTableTable extends TaskTypesTable
    with TableInfo<$TaskTypesTableTable, TaskTypesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTypesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boardIdMeta = const VerificationMeta(
    'boardId',
  );
  @override
  late final GeneratedColumn<String> boardId = GeneratedColumn<String>(
    'board_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncActionMeta = const VerificationMeta(
    'syncAction',
  );
  @override
  late final GeneratedColumn<String> syncAction = GeneratedColumn<String>(
    'sync_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    boardId,
    name,
    color,
    icon,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_types_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskTypesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('board_id')) {
      context.handle(
        _boardIdMeta,
        boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('sync_action')) {
      context.handle(
        _syncActionMeta,
        syncAction.isAcceptableOrUnknown(data['sync_action']!, _syncActionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskTypesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskTypesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      boardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      syncAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_action'],
      ),
    );
  }

  @override
  $TaskTypesTableTable createAlias(String alias) {
    return $TaskTypesTableTable(attachedDatabase, alias);
  }
}

class TaskTypesTableData extends DataClass
    implements Insertable<TaskTypesTableData> {
  final String id;
  final String boardId;
  final String name;
  final String color;
  final String icon;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isSynced;
  final String? syncAction;
  const TaskTypesTableData({
    required this.id,
    required this.boardId,
    required this.name,
    required this.color,
    required this.icon,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['board_id'] = Variable<String>(boardId);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    map['icon'] = Variable<String>(icon);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  TaskTypesTableCompanion toCompanion(bool nullToAbsent) {
    return TaskTypesTableCompanion(
      id: Value(id),
      boardId: Value(boardId),
      name: Value(name),
      color: Value(color),
      icon: Value(icon),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory TaskTypesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskTypesTableData(
      id: serializer.fromJson<String>(json['id']),
      boardId: serializer.fromJson<String>(json['boardId']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      icon: serializer.fromJson<String>(json['icon']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'boardId': serializer.toJson<String>(boardId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'icon': serializer.toJson<String>(icon),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  TaskTypesTableData copyWith({
    String? id,
    String? boardId,
    String? name,
    String? color,
    String? icon,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => TaskTypesTableData(
    id: id ?? this.id,
    boardId: boardId ?? this.boardId,
    name: name ?? this.name,
    color: color ?? this.color,
    icon: icon ?? this.icon,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  TaskTypesTableData copyWithCompanion(TaskTypesTableCompanion data) {
    return TaskTypesTableData(
      id: data.id.present ? data.id.value : this.id,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskTypesTableData(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    boardId,
    name,
    color,
    icon,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskTypesTableData &&
          other.id == this.id &&
          other.boardId == this.boardId &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class TaskTypesTableCompanion extends UpdateCompanion<TaskTypesTableData> {
  final Value<String> id;
  final Value<String> boardId;
  final Value<String> name;
  final Value<String> color;
  final Value<String> icon;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const TaskTypesTableCompanion({
    this.id = const Value.absent(),
    this.boardId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskTypesTableCompanion.insert({
    required String id,
    this.boardId = const Value.absent(),
    required String name,
    required String color,
    required String icon,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       color = Value(color),
       icon = Value(icon),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TaskTypesTableData> custom({
    Expression<String>? id,
    Expression<String>? boardId,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (boardId != null) 'board_id': boardId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskTypesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? boardId,
    Value<String>? name,
    Value<String>? color,
    Value<String>? icon,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return TaskTypesTableCompanion(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isSynced: isSynced ?? this.isSynced,
      syncAction: syncAction ?? this.syncAction,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (syncAction.present) {
      map['sync_action'] = Variable<String>(syncAction.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskTypesTableCompanion(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BoardCardSettingsTableTable extends BoardCardSettingsTable
    with TableInfo<$BoardCardSettingsTableTable, BoardCardSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BoardCardSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _boardIdMeta = const VerificationMeta(
    'boardId',
  );
  @override
  late final GeneratedColumn<String> boardId = GeneratedColumn<String>(
    'board_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _showDescriptionMeta = const VerificationMeta(
    'showDescription',
  );
  @override
  late final GeneratedColumn<bool> showDescription = GeneratedColumn<bool>(
    'show_description',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_description" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showTaskTypeMeta = const VerificationMeta(
    'showTaskType',
  );
  @override
  late final GeneratedColumn<bool> showTaskType = GeneratedColumn<bool>(
    'show_task_type',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_task_type" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showPeriodMeta = const VerificationMeta(
    'showPeriod',
  );
  @override
  late final GeneratedColumn<bool> showPeriod = GeneratedColumn<bool>(
    'show_period',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_period" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showSubtaskProgressMeta =
      const VerificationMeta('showSubtaskProgress');
  @override
  late final GeneratedColumn<bool> showSubtaskProgress = GeneratedColumn<bool>(
    'show_subtask_progress',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_subtask_progress" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showPriorityMeta = const VerificationMeta(
    'showPriority',
  );
  @override
  late final GeneratedColumn<bool> showPriority = GeneratedColumn<bool>(
    'show_priority',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_priority" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showAssigneeMeta = const VerificationMeta(
    'showAssignee',
  );
  @override
  late final GeneratedColumn<bool> showAssignee = GeneratedColumn<bool>(
    'show_assignee',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_assignee" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showLabelsMeta = const VerificationMeta(
    'showLabels',
  );
  @override
  late final GeneratedColumn<bool> showLabels = GeneratedColumn<bool>(
    'show_labels',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_labels" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showCreatedAtMeta = const VerificationMeta(
    'showCreatedAt',
  );
  @override
  late final GeneratedColumn<bool> showCreatedAt = GeneratedColumn<bool>(
    'show_created_at',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_created_at" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _showQuickActionsMeta = const VerificationMeta(
    'showQuickActions',
  );
  @override
  late final GeneratedColumn<bool> showQuickActions = GeneratedColumn<bool>(
    'show_quick_actions',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_quick_actions" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _densityMeta = const VerificationMeta(
    'density',
  );
  @override
  late final GeneratedColumn<String> density = GeneratedColumn<String>(
    'density',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('compact'),
  );
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  @override
  late final GeneratedColumn<String> style = GeneratedColumn<String>(
    'style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('bordered'),
  );
  static const VerificationMeta _typeBadgePlacementMeta =
      const VerificationMeta('typeBadgePlacement');
  @override
  late final GeneratedColumn<String> typeBadgePlacement =
      GeneratedColumn<String>(
        'type_badge_placement',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('top'),
      );
  static const VerificationMeta _typeColorModeMeta = const VerificationMeta(
    'typeColorMode',
  );
  @override
  late final GeneratedColumn<String> typeColorMode = GeneratedColumn<String>(
    'type_color_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('smallDot'),
  );
  static const VerificationMeta _cardBackgroundColorMeta =
      const VerificationMeta('cardBackgroundColor');
  @override
  late final GeneratedColumn<String> cardBackgroundColor =
      GeneratedColumn<String>(
        'card_background_color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('default'),
      );
  static const VerificationMeta _columnBackgroundColorMeta =
      const VerificationMeta('columnBackgroundColor');
  @override
  late final GeneratedColumn<String> columnBackgroundColor =
      GeneratedColumn<String>(
        'column_background_color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('default'),
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    boardId,
    showDescription,
    showTaskType,
    showPeriod,
    showSubtaskProgress,
    showPriority,
    showAssignee,
    showLabels,
    showCreatedAt,
    showQuickActions,
    density,
    style,
    typeBadgePlacement,
    typeColorMode,
    cardBackgroundColor,
    columnBackgroundColor,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'board_card_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BoardCardSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('board_id')) {
      context.handle(
        _boardIdMeta,
        boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('show_description')) {
      context.handle(
        _showDescriptionMeta,
        showDescription.isAcceptableOrUnknown(
          data['show_description']!,
          _showDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('show_task_type')) {
      context.handle(
        _showTaskTypeMeta,
        showTaskType.isAcceptableOrUnknown(
          data['show_task_type']!,
          _showTaskTypeMeta,
        ),
      );
    }
    if (data.containsKey('show_period')) {
      context.handle(
        _showPeriodMeta,
        showPeriod.isAcceptableOrUnknown(data['show_period']!, _showPeriodMeta),
      );
    }
    if (data.containsKey('show_subtask_progress')) {
      context.handle(
        _showSubtaskProgressMeta,
        showSubtaskProgress.isAcceptableOrUnknown(
          data['show_subtask_progress']!,
          _showSubtaskProgressMeta,
        ),
      );
    }
    if (data.containsKey('show_priority')) {
      context.handle(
        _showPriorityMeta,
        showPriority.isAcceptableOrUnknown(
          data['show_priority']!,
          _showPriorityMeta,
        ),
      );
    }
    if (data.containsKey('show_assignee')) {
      context.handle(
        _showAssigneeMeta,
        showAssignee.isAcceptableOrUnknown(
          data['show_assignee']!,
          _showAssigneeMeta,
        ),
      );
    }
    if (data.containsKey('show_labels')) {
      context.handle(
        _showLabelsMeta,
        showLabels.isAcceptableOrUnknown(data['show_labels']!, _showLabelsMeta),
      );
    }
    if (data.containsKey('show_created_at')) {
      context.handle(
        _showCreatedAtMeta,
        showCreatedAt.isAcceptableOrUnknown(
          data['show_created_at']!,
          _showCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('show_quick_actions')) {
      context.handle(
        _showQuickActionsMeta,
        showQuickActions.isAcceptableOrUnknown(
          data['show_quick_actions']!,
          _showQuickActionsMeta,
        ),
      );
    }
    if (data.containsKey('density')) {
      context.handle(
        _densityMeta,
        density.isAcceptableOrUnknown(data['density']!, _densityMeta),
      );
    }
    if (data.containsKey('style')) {
      context.handle(
        _styleMeta,
        style.isAcceptableOrUnknown(data['style']!, _styleMeta),
      );
    }
    if (data.containsKey('type_badge_placement')) {
      context.handle(
        _typeBadgePlacementMeta,
        typeBadgePlacement.isAcceptableOrUnknown(
          data['type_badge_placement']!,
          _typeBadgePlacementMeta,
        ),
      );
    }
    if (data.containsKey('type_color_mode')) {
      context.handle(
        _typeColorModeMeta,
        typeColorMode.isAcceptableOrUnknown(
          data['type_color_mode']!,
          _typeColorModeMeta,
        ),
      );
    }
    if (data.containsKey('card_background_color')) {
      context.handle(
        _cardBackgroundColorMeta,
        cardBackgroundColor.isAcceptableOrUnknown(
          data['card_background_color']!,
          _cardBackgroundColorMeta,
        ),
      );
    }
    if (data.containsKey('column_background_color')) {
      context.handle(
        _columnBackgroundColorMeta,
        columnBackgroundColor.isAcceptableOrUnknown(
          data['column_background_color']!,
          _columnBackgroundColorMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {boardId};
  @override
  BoardCardSettingsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BoardCardSettingsTableData(
      boardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_id'],
      )!,
      showDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_description'],
      )!,
      showTaskType: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_task_type'],
      )!,
      showPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_period'],
      )!,
      showSubtaskProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_subtask_progress'],
      )!,
      showPriority: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_priority'],
      )!,
      showAssignee: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_assignee'],
      )!,
      showLabels: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_labels'],
      )!,
      showCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_created_at'],
      )!,
      showQuickActions: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_quick_actions'],
      )!,
      density: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}density'],
      )!,
      style: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}style'],
      )!,
      typeBadgePlacement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_badge_placement'],
      )!,
      typeColorMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_color_mode'],
      )!,
      cardBackgroundColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_background_color'],
      )!,
      columnBackgroundColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}column_background_color'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BoardCardSettingsTableTable createAlias(String alias) {
    return $BoardCardSettingsTableTable(attachedDatabase, alias);
  }
}

class BoardCardSettingsTableData extends DataClass
    implements Insertable<BoardCardSettingsTableData> {
  final String boardId;
  final bool showDescription;
  final bool showTaskType;
  final bool showPeriod;
  final bool showSubtaskProgress;
  final bool showPriority;
  final bool showAssignee;
  final bool showLabels;
  final bool showCreatedAt;
  final bool showQuickActions;
  final String density;
  final String style;
  final String typeBadgePlacement;
  final String typeColorMode;
  final String cardBackgroundColor;
  final String columnBackgroundColor;
  final DateTime updatedAt;
  const BoardCardSettingsTableData({
    required this.boardId,
    required this.showDescription,
    required this.showTaskType,
    required this.showPeriod,
    required this.showSubtaskProgress,
    required this.showPriority,
    required this.showAssignee,
    required this.showLabels,
    required this.showCreatedAt,
    required this.showQuickActions,
    required this.density,
    required this.style,
    required this.typeBadgePlacement,
    required this.typeColorMode,
    required this.cardBackgroundColor,
    required this.columnBackgroundColor,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['board_id'] = Variable<String>(boardId);
    map['show_description'] = Variable<bool>(showDescription);
    map['show_task_type'] = Variable<bool>(showTaskType);
    map['show_period'] = Variable<bool>(showPeriod);
    map['show_subtask_progress'] = Variable<bool>(showSubtaskProgress);
    map['show_priority'] = Variable<bool>(showPriority);
    map['show_assignee'] = Variable<bool>(showAssignee);
    map['show_labels'] = Variable<bool>(showLabels);
    map['show_created_at'] = Variable<bool>(showCreatedAt);
    map['show_quick_actions'] = Variable<bool>(showQuickActions);
    map['density'] = Variable<String>(density);
    map['style'] = Variable<String>(style);
    map['type_badge_placement'] = Variable<String>(typeBadgePlacement);
    map['type_color_mode'] = Variable<String>(typeColorMode);
    map['card_background_color'] = Variable<String>(cardBackgroundColor);
    map['column_background_color'] = Variable<String>(columnBackgroundColor);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BoardCardSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return BoardCardSettingsTableCompanion(
      boardId: Value(boardId),
      showDescription: Value(showDescription),
      showTaskType: Value(showTaskType),
      showPeriod: Value(showPeriod),
      showSubtaskProgress: Value(showSubtaskProgress),
      showPriority: Value(showPriority),
      showAssignee: Value(showAssignee),
      showLabels: Value(showLabels),
      showCreatedAt: Value(showCreatedAt),
      showQuickActions: Value(showQuickActions),
      density: Value(density),
      style: Value(style),
      typeBadgePlacement: Value(typeBadgePlacement),
      typeColorMode: Value(typeColorMode),
      cardBackgroundColor: Value(cardBackgroundColor),
      columnBackgroundColor: Value(columnBackgroundColor),
      updatedAt: Value(updatedAt),
    );
  }

  factory BoardCardSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BoardCardSettingsTableData(
      boardId: serializer.fromJson<String>(json['boardId']),
      showDescription: serializer.fromJson<bool>(json['showDescription']),
      showTaskType: serializer.fromJson<bool>(json['showTaskType']),
      showPeriod: serializer.fromJson<bool>(json['showPeriod']),
      showSubtaskProgress: serializer.fromJson<bool>(
        json['showSubtaskProgress'],
      ),
      showPriority: serializer.fromJson<bool>(json['showPriority']),
      showAssignee: serializer.fromJson<bool>(json['showAssignee']),
      showLabels: serializer.fromJson<bool>(json['showLabels']),
      showCreatedAt: serializer.fromJson<bool>(json['showCreatedAt']),
      showQuickActions: serializer.fromJson<bool>(json['showQuickActions']),
      density: serializer.fromJson<String>(json['density']),
      style: serializer.fromJson<String>(json['style']),
      typeBadgePlacement: serializer.fromJson<String>(
        json['typeBadgePlacement'],
      ),
      typeColorMode: serializer.fromJson<String>(json['typeColorMode']),
      cardBackgroundColor: serializer.fromJson<String>(
        json['cardBackgroundColor'],
      ),
      columnBackgroundColor: serializer.fromJson<String>(
        json['columnBackgroundColor'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'boardId': serializer.toJson<String>(boardId),
      'showDescription': serializer.toJson<bool>(showDescription),
      'showTaskType': serializer.toJson<bool>(showTaskType),
      'showPeriod': serializer.toJson<bool>(showPeriod),
      'showSubtaskProgress': serializer.toJson<bool>(showSubtaskProgress),
      'showPriority': serializer.toJson<bool>(showPriority),
      'showAssignee': serializer.toJson<bool>(showAssignee),
      'showLabels': serializer.toJson<bool>(showLabels),
      'showCreatedAt': serializer.toJson<bool>(showCreatedAt),
      'showQuickActions': serializer.toJson<bool>(showQuickActions),
      'density': serializer.toJson<String>(density),
      'style': serializer.toJson<String>(style),
      'typeBadgePlacement': serializer.toJson<String>(typeBadgePlacement),
      'typeColorMode': serializer.toJson<String>(typeColorMode),
      'cardBackgroundColor': serializer.toJson<String>(cardBackgroundColor),
      'columnBackgroundColor': serializer.toJson<String>(columnBackgroundColor),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BoardCardSettingsTableData copyWith({
    String? boardId,
    bool? showDescription,
    bool? showTaskType,
    bool? showPeriod,
    bool? showSubtaskProgress,
    bool? showPriority,
    bool? showAssignee,
    bool? showLabels,
    bool? showCreatedAt,
    bool? showQuickActions,
    String? density,
    String? style,
    String? typeBadgePlacement,
    String? typeColorMode,
    String? cardBackgroundColor,
    String? columnBackgroundColor,
    DateTime? updatedAt,
  }) => BoardCardSettingsTableData(
    boardId: boardId ?? this.boardId,
    showDescription: showDescription ?? this.showDescription,
    showTaskType: showTaskType ?? this.showTaskType,
    showPeriod: showPeriod ?? this.showPeriod,
    showSubtaskProgress: showSubtaskProgress ?? this.showSubtaskProgress,
    showPriority: showPriority ?? this.showPriority,
    showAssignee: showAssignee ?? this.showAssignee,
    showLabels: showLabels ?? this.showLabels,
    showCreatedAt: showCreatedAt ?? this.showCreatedAt,
    showQuickActions: showQuickActions ?? this.showQuickActions,
    density: density ?? this.density,
    style: style ?? this.style,
    typeBadgePlacement: typeBadgePlacement ?? this.typeBadgePlacement,
    typeColorMode: typeColorMode ?? this.typeColorMode,
    cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
    columnBackgroundColor: columnBackgroundColor ?? this.columnBackgroundColor,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BoardCardSettingsTableData copyWithCompanion(
    BoardCardSettingsTableCompanion data,
  ) {
    return BoardCardSettingsTableData(
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      showDescription: data.showDescription.present
          ? data.showDescription.value
          : this.showDescription,
      showTaskType: data.showTaskType.present
          ? data.showTaskType.value
          : this.showTaskType,
      showPeriod: data.showPeriod.present
          ? data.showPeriod.value
          : this.showPeriod,
      showSubtaskProgress: data.showSubtaskProgress.present
          ? data.showSubtaskProgress.value
          : this.showSubtaskProgress,
      showPriority: data.showPriority.present
          ? data.showPriority.value
          : this.showPriority,
      showAssignee: data.showAssignee.present
          ? data.showAssignee.value
          : this.showAssignee,
      showLabels: data.showLabels.present
          ? data.showLabels.value
          : this.showLabels,
      showCreatedAt: data.showCreatedAt.present
          ? data.showCreatedAt.value
          : this.showCreatedAt,
      showQuickActions: data.showQuickActions.present
          ? data.showQuickActions.value
          : this.showQuickActions,
      density: data.density.present ? data.density.value : this.density,
      style: data.style.present ? data.style.value : this.style,
      typeBadgePlacement: data.typeBadgePlacement.present
          ? data.typeBadgePlacement.value
          : this.typeBadgePlacement,
      typeColorMode: data.typeColorMode.present
          ? data.typeColorMode.value
          : this.typeColorMode,
      cardBackgroundColor: data.cardBackgroundColor.present
          ? data.cardBackgroundColor.value
          : this.cardBackgroundColor,
      columnBackgroundColor: data.columnBackgroundColor.present
          ? data.columnBackgroundColor.value
          : this.columnBackgroundColor,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BoardCardSettingsTableData(')
          ..write('boardId: $boardId, ')
          ..write('showDescription: $showDescription, ')
          ..write('showTaskType: $showTaskType, ')
          ..write('showPeriod: $showPeriod, ')
          ..write('showSubtaskProgress: $showSubtaskProgress, ')
          ..write('showPriority: $showPriority, ')
          ..write('showAssignee: $showAssignee, ')
          ..write('showLabels: $showLabels, ')
          ..write('showCreatedAt: $showCreatedAt, ')
          ..write('showQuickActions: $showQuickActions, ')
          ..write('density: $density, ')
          ..write('style: $style, ')
          ..write('typeBadgePlacement: $typeBadgePlacement, ')
          ..write('typeColorMode: $typeColorMode, ')
          ..write('cardBackgroundColor: $cardBackgroundColor, ')
          ..write('columnBackgroundColor: $columnBackgroundColor, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    boardId,
    showDescription,
    showTaskType,
    showPeriod,
    showSubtaskProgress,
    showPriority,
    showAssignee,
    showLabels,
    showCreatedAt,
    showQuickActions,
    density,
    style,
    typeBadgePlacement,
    typeColorMode,
    cardBackgroundColor,
    columnBackgroundColor,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoardCardSettingsTableData &&
          other.boardId == this.boardId &&
          other.showDescription == this.showDescription &&
          other.showTaskType == this.showTaskType &&
          other.showPeriod == this.showPeriod &&
          other.showSubtaskProgress == this.showSubtaskProgress &&
          other.showPriority == this.showPriority &&
          other.showAssignee == this.showAssignee &&
          other.showLabels == this.showLabels &&
          other.showCreatedAt == this.showCreatedAt &&
          other.showQuickActions == this.showQuickActions &&
          other.density == this.density &&
          other.style == this.style &&
          other.typeBadgePlacement == this.typeBadgePlacement &&
          other.typeColorMode == this.typeColorMode &&
          other.cardBackgroundColor == this.cardBackgroundColor &&
          other.columnBackgroundColor == this.columnBackgroundColor &&
          other.updatedAt == this.updatedAt);
}

class BoardCardSettingsTableCompanion
    extends UpdateCompanion<BoardCardSettingsTableData> {
  final Value<String> boardId;
  final Value<bool> showDescription;
  final Value<bool> showTaskType;
  final Value<bool> showPeriod;
  final Value<bool> showSubtaskProgress;
  final Value<bool> showPriority;
  final Value<bool> showAssignee;
  final Value<bool> showLabels;
  final Value<bool> showCreatedAt;
  final Value<bool> showQuickActions;
  final Value<String> density;
  final Value<String> style;
  final Value<String> typeBadgePlacement;
  final Value<String> typeColorMode;
  final Value<String> cardBackgroundColor;
  final Value<String> columnBackgroundColor;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BoardCardSettingsTableCompanion({
    this.boardId = const Value.absent(),
    this.showDescription = const Value.absent(),
    this.showTaskType = const Value.absent(),
    this.showPeriod = const Value.absent(),
    this.showSubtaskProgress = const Value.absent(),
    this.showPriority = const Value.absent(),
    this.showAssignee = const Value.absent(),
    this.showLabels = const Value.absent(),
    this.showCreatedAt = const Value.absent(),
    this.showQuickActions = const Value.absent(),
    this.density = const Value.absent(),
    this.style = const Value.absent(),
    this.typeBadgePlacement = const Value.absent(),
    this.typeColorMode = const Value.absent(),
    this.cardBackgroundColor = const Value.absent(),
    this.columnBackgroundColor = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BoardCardSettingsTableCompanion.insert({
    required String boardId,
    this.showDescription = const Value.absent(),
    this.showTaskType = const Value.absent(),
    this.showPeriod = const Value.absent(),
    this.showSubtaskProgress = const Value.absent(),
    this.showPriority = const Value.absent(),
    this.showAssignee = const Value.absent(),
    this.showLabels = const Value.absent(),
    this.showCreatedAt = const Value.absent(),
    this.showQuickActions = const Value.absent(),
    this.density = const Value.absent(),
    this.style = const Value.absent(),
    this.typeBadgePlacement = const Value.absent(),
    this.typeColorMode = const Value.absent(),
    this.cardBackgroundColor = const Value.absent(),
    this.columnBackgroundColor = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : boardId = Value(boardId),
       updatedAt = Value(updatedAt);
  static Insertable<BoardCardSettingsTableData> custom({
    Expression<String>? boardId,
    Expression<bool>? showDescription,
    Expression<bool>? showTaskType,
    Expression<bool>? showPeriod,
    Expression<bool>? showSubtaskProgress,
    Expression<bool>? showPriority,
    Expression<bool>? showAssignee,
    Expression<bool>? showLabels,
    Expression<bool>? showCreatedAt,
    Expression<bool>? showQuickActions,
    Expression<String>? density,
    Expression<String>? style,
    Expression<String>? typeBadgePlacement,
    Expression<String>? typeColorMode,
    Expression<String>? cardBackgroundColor,
    Expression<String>? columnBackgroundColor,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (boardId != null) 'board_id': boardId,
      if (showDescription != null) 'show_description': showDescription,
      if (showTaskType != null) 'show_task_type': showTaskType,
      if (showPeriod != null) 'show_period': showPeriod,
      if (showSubtaskProgress != null)
        'show_subtask_progress': showSubtaskProgress,
      if (showPriority != null) 'show_priority': showPriority,
      if (showAssignee != null) 'show_assignee': showAssignee,
      if (showLabels != null) 'show_labels': showLabels,
      if (showCreatedAt != null) 'show_created_at': showCreatedAt,
      if (showQuickActions != null) 'show_quick_actions': showQuickActions,
      if (density != null) 'density': density,
      if (style != null) 'style': style,
      if (typeBadgePlacement != null)
        'type_badge_placement': typeBadgePlacement,
      if (typeColorMode != null) 'type_color_mode': typeColorMode,
      if (cardBackgroundColor != null)
        'card_background_color': cardBackgroundColor,
      if (columnBackgroundColor != null)
        'column_background_color': columnBackgroundColor,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BoardCardSettingsTableCompanion copyWith({
    Value<String>? boardId,
    Value<bool>? showDescription,
    Value<bool>? showTaskType,
    Value<bool>? showPeriod,
    Value<bool>? showSubtaskProgress,
    Value<bool>? showPriority,
    Value<bool>? showAssignee,
    Value<bool>? showLabels,
    Value<bool>? showCreatedAt,
    Value<bool>? showQuickActions,
    Value<String>? density,
    Value<String>? style,
    Value<String>? typeBadgePlacement,
    Value<String>? typeColorMode,
    Value<String>? cardBackgroundColor,
    Value<String>? columnBackgroundColor,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BoardCardSettingsTableCompanion(
      boardId: boardId ?? this.boardId,
      showDescription: showDescription ?? this.showDescription,
      showTaskType: showTaskType ?? this.showTaskType,
      showPeriod: showPeriod ?? this.showPeriod,
      showSubtaskProgress: showSubtaskProgress ?? this.showSubtaskProgress,
      showPriority: showPriority ?? this.showPriority,
      showAssignee: showAssignee ?? this.showAssignee,
      showLabels: showLabels ?? this.showLabels,
      showCreatedAt: showCreatedAt ?? this.showCreatedAt,
      showQuickActions: showQuickActions ?? this.showQuickActions,
      density: density ?? this.density,
      style: style ?? this.style,
      typeBadgePlacement: typeBadgePlacement ?? this.typeBadgePlacement,
      typeColorMode: typeColorMode ?? this.typeColorMode,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      columnBackgroundColor:
          columnBackgroundColor ?? this.columnBackgroundColor,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (showDescription.present) {
      map['show_description'] = Variable<bool>(showDescription.value);
    }
    if (showTaskType.present) {
      map['show_task_type'] = Variable<bool>(showTaskType.value);
    }
    if (showPeriod.present) {
      map['show_period'] = Variable<bool>(showPeriod.value);
    }
    if (showSubtaskProgress.present) {
      map['show_subtask_progress'] = Variable<bool>(showSubtaskProgress.value);
    }
    if (showPriority.present) {
      map['show_priority'] = Variable<bool>(showPriority.value);
    }
    if (showAssignee.present) {
      map['show_assignee'] = Variable<bool>(showAssignee.value);
    }
    if (showLabels.present) {
      map['show_labels'] = Variable<bool>(showLabels.value);
    }
    if (showCreatedAt.present) {
      map['show_created_at'] = Variable<bool>(showCreatedAt.value);
    }
    if (showQuickActions.present) {
      map['show_quick_actions'] = Variable<bool>(showQuickActions.value);
    }
    if (density.present) {
      map['density'] = Variable<String>(density.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(style.value);
    }
    if (typeBadgePlacement.present) {
      map['type_badge_placement'] = Variable<String>(typeBadgePlacement.value);
    }
    if (typeColorMode.present) {
      map['type_color_mode'] = Variable<String>(typeColorMode.value);
    }
    if (cardBackgroundColor.present) {
      map['card_background_color'] = Variable<String>(
        cardBackgroundColor.value,
      );
    }
    if (columnBackgroundColor.present) {
      map['column_background_color'] = Variable<String>(
        columnBackgroundColor.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoardCardSettingsTableCompanion(')
          ..write('boardId: $boardId, ')
          ..write('showDescription: $showDescription, ')
          ..write('showTaskType: $showTaskType, ')
          ..write('showPeriod: $showPeriod, ')
          ..write('showSubtaskProgress: $showSubtaskProgress, ')
          ..write('showPriority: $showPriority, ')
          ..write('showAssignee: $showAssignee, ')
          ..write('showLabels: $showLabels, ')
          ..write('showCreatedAt: $showCreatedAt, ')
          ..write('showQuickActions: $showQuickActions, ')
          ..write('density: $density, ')
          ..write('style: $style, ')
          ..write('typeBadgePlacement: $typeBadgePlacement, ')
          ..write('typeColorMode: $typeColorMode, ')
          ..write('cardBackgroundColor: $cardBackgroundColor, ')
          ..write('columnBackgroundColor: $columnBackgroundColor, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTableTable extends TasksTable
    with TableInfo<$TasksTableTable, TasksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boardIdMeta = const VerificationMeta(
    'boardId',
  );
  @override
  late final GeneratedColumn<String> boardId = GeneratedColumn<String>(
    'board_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _columnIdMeta = const VerificationMeta(
    'columnId',
  );
  @override
  late final GeneratedColumn<String> columnId = GeneratedColumn<String>(
    'column_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentTaskIdMeta = const VerificationMeta(
    'parentTaskId',
  );
  @override
  late final GeneratedColumn<String> parentTaskId = GeneratedColumn<String>(
    'parent_task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taskTypeIdMeta = const VerificationMeta(
    'taskTypeId',
  );
  @override
  late final GeneratedColumn<String> taskTypeId = GeneratedColumn<String>(
    'task_type_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardBackgroundColorMeta =
      const VerificationMeta('cardBackgroundColor');
  @override
  late final GeneratedColumn<String> cardBackgroundColor =
      GeneratedColumn<String>(
        'card_background_color',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _cardTextColorMeta = const VerificationMeta(
    'cardTextColor',
  );
  @override
  late final GeneratedColumn<String> cardTextColor = GeneratedColumn<String>(
    'card_text_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('todo'),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _assigneeNameMeta = const VerificationMeta(
    'assigneeName',
  );
  @override
  late final GeneratedColumn<String> assigneeName = GeneratedColumn<String>(
    'assignee_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelsJsonMeta = const VerificationMeta(
    'labelsJson',
  );
  @override
  late final GeneratedColumn<String> labelsJson = GeneratedColumn<String>(
    'labels_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedDurationMinutesMeta =
      const VerificationMeta('estimatedDurationMinutes');
  @override
  late final GeneratedColumn<int> estimatedDurationMinutes =
      GeneratedColumn<int>(
        'estimated_duration_minutes',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _actualDurationMinutesMeta =
      const VerificationMeta('actualDurationMinutes');
  @override
  late final GeneratedColumn<int> actualDurationMinutes = GeneratedColumn<int>(
    'actual_duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodTypeMeta = const VerificationMeta(
    'periodType',
  );
  @override
  late final GeneratedColumn<String> periodType = GeneratedColumn<String>(
    'period_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('custom'),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncActionMeta = const VerificationMeta(
    'syncAction',
  );
  @override
  late final GeneratedColumn<String> syncAction = GeneratedColumn<String>(
    'sync_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    boardId,
    columnId,
    parentTaskId,
    taskTypeId,
    title,
    description,
    cardBackgroundColor,
    cardTextColor,
    position,
    depth,
    status,
    priority,
    assigneeName,
    labelsJson,
    startDate,
    dueDate,
    completedAt,
    estimatedDurationMinutes,
    actualDurationMinutes,
    periodType,
    isCompleted,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TasksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('board_id')) {
      context.handle(
        _boardIdMeta,
        boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('column_id')) {
      context.handle(
        _columnIdMeta,
        columnId.isAcceptableOrUnknown(data['column_id']!, _columnIdMeta),
      );
    }
    if (data.containsKey('parent_task_id')) {
      context.handle(
        _parentTaskIdMeta,
        parentTaskId.isAcceptableOrUnknown(
          data['parent_task_id']!,
          _parentTaskIdMeta,
        ),
      );
    }
    if (data.containsKey('task_type_id')) {
      context.handle(
        _taskTypeIdMeta,
        taskTypeId.isAcceptableOrUnknown(
          data['task_type_id']!,
          _taskTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('card_background_color')) {
      context.handle(
        _cardBackgroundColorMeta,
        cardBackgroundColor.isAcceptableOrUnknown(
          data['card_background_color']!,
          _cardBackgroundColorMeta,
        ),
      );
    }
    if (data.containsKey('card_text_color')) {
      context.handle(
        _cardTextColorMeta,
        cardTextColor.isAcceptableOrUnknown(
          data['card_text_color']!,
          _cardTextColorMeta,
        ),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
        _depthMeta,
        depth.isAcceptableOrUnknown(data['depth']!, _depthMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('assignee_name')) {
      context.handle(
        _assigneeNameMeta,
        assigneeName.isAcceptableOrUnknown(
          data['assignee_name']!,
          _assigneeNameMeta,
        ),
      );
    }
    if (data.containsKey('labels_json')) {
      context.handle(
        _labelsJsonMeta,
        labelsJson.isAcceptableOrUnknown(data['labels_json']!, _labelsJsonMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('estimated_duration_minutes')) {
      context.handle(
        _estimatedDurationMinutesMeta,
        estimatedDurationMinutes.isAcceptableOrUnknown(
          data['estimated_duration_minutes']!,
          _estimatedDurationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('actual_duration_minutes')) {
      context.handle(
        _actualDurationMinutesMeta,
        actualDurationMinutes.isAcceptableOrUnknown(
          data['actual_duration_minutes']!,
          _actualDurationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('period_type')) {
      context.handle(
        _periodTypeMeta,
        periodType.isAcceptableOrUnknown(data['period_type']!, _periodTypeMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('sync_action')) {
      context.handle(
        _syncActionMeta,
        syncAction.isAcceptableOrUnknown(data['sync_action']!, _syncActionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      boardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_id'],
      )!,
      columnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}column_id'],
      ),
      parentTaskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_task_id'],
      ),
      taskTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_type_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      cardBackgroundColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_background_color'],
      ),
      cardTextColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_text_color'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      depth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      assigneeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assignee_name'],
      ),
      labelsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}labels_json'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      estimatedDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_duration_minutes'],
      ),
      actualDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_duration_minutes'],
      ),
      periodType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_type'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      syncAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_action'],
      ),
    );
  }

  @override
  $TasksTableTable createAlias(String alias) {
    return $TasksTableTable(attachedDatabase, alias);
  }
}

class TasksTableData extends DataClass implements Insertable<TasksTableData> {
  final String id;
  final String boardId;
  final String? columnId;
  final String? parentTaskId;
  final String? taskTypeId;
  final String title;
  final String? description;
  final String? cardBackgroundColor;
  final String? cardTextColor;
  final int position;
  final int depth;
  final String status;
  final String priority;
  final String? assigneeName;
  final String labelsJson;
  final DateTime? startDate;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final int? estimatedDurationMinutes;
  final int? actualDurationMinutes;
  final String periodType;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isSynced;
  final String? syncAction;
  const TasksTableData({
    required this.id,
    required this.boardId,
    this.columnId,
    this.parentTaskId,
    this.taskTypeId,
    required this.title,
    this.description,
    this.cardBackgroundColor,
    this.cardTextColor,
    required this.position,
    required this.depth,
    required this.status,
    required this.priority,
    this.assigneeName,
    required this.labelsJson,
    this.startDate,
    this.dueDate,
    this.completedAt,
    this.estimatedDurationMinutes,
    this.actualDurationMinutes,
    required this.periodType,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['board_id'] = Variable<String>(boardId);
    if (!nullToAbsent || columnId != null) {
      map['column_id'] = Variable<String>(columnId);
    }
    if (!nullToAbsent || parentTaskId != null) {
      map['parent_task_id'] = Variable<String>(parentTaskId);
    }
    if (!nullToAbsent || taskTypeId != null) {
      map['task_type_id'] = Variable<String>(taskTypeId);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || cardBackgroundColor != null) {
      map['card_background_color'] = Variable<String>(cardBackgroundColor);
    }
    if (!nullToAbsent || cardTextColor != null) {
      map['card_text_color'] = Variable<String>(cardTextColor);
    }
    map['position'] = Variable<int>(position);
    map['depth'] = Variable<int>(depth);
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || assigneeName != null) {
      map['assignee_name'] = Variable<String>(assigneeName);
    }
    map['labels_json'] = Variable<String>(labelsJson);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || estimatedDurationMinutes != null) {
      map['estimated_duration_minutes'] = Variable<int>(
        estimatedDurationMinutes,
      );
    }
    if (!nullToAbsent || actualDurationMinutes != null) {
      map['actual_duration_minutes'] = Variable<int>(actualDurationMinutes);
    }
    map['period_type'] = Variable<String>(periodType);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  TasksTableCompanion toCompanion(bool nullToAbsent) {
    return TasksTableCompanion(
      id: Value(id),
      boardId: Value(boardId),
      columnId: columnId == null && nullToAbsent
          ? const Value.absent()
          : Value(columnId),
      parentTaskId: parentTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTaskId),
      taskTypeId: taskTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskTypeId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      cardBackgroundColor: cardBackgroundColor == null && nullToAbsent
          ? const Value.absent()
          : Value(cardBackgroundColor),
      cardTextColor: cardTextColor == null && nullToAbsent
          ? const Value.absent()
          : Value(cardTextColor),
      position: Value(position),
      depth: Value(depth),
      status: Value(status),
      priority: Value(priority),
      assigneeName: assigneeName == null && nullToAbsent
          ? const Value.absent()
          : Value(assigneeName),
      labelsJson: Value(labelsJson),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      estimatedDurationMinutes: estimatedDurationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDurationMinutes),
      actualDurationMinutes: actualDurationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDurationMinutes),
      periodType: Value(periodType),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory TasksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasksTableData(
      id: serializer.fromJson<String>(json['id']),
      boardId: serializer.fromJson<String>(json['boardId']),
      columnId: serializer.fromJson<String?>(json['columnId']),
      parentTaskId: serializer.fromJson<String?>(json['parentTaskId']),
      taskTypeId: serializer.fromJson<String?>(json['taskTypeId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      cardBackgroundColor: serializer.fromJson<String?>(
        json['cardBackgroundColor'],
      ),
      cardTextColor: serializer.fromJson<String?>(json['cardTextColor']),
      position: serializer.fromJson<int>(json['position']),
      depth: serializer.fromJson<int>(json['depth']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      assigneeName: serializer.fromJson<String?>(json['assigneeName']),
      labelsJson: serializer.fromJson<String>(json['labelsJson']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      estimatedDurationMinutes: serializer.fromJson<int?>(
        json['estimatedDurationMinutes'],
      ),
      actualDurationMinutes: serializer.fromJson<int?>(
        json['actualDurationMinutes'],
      ),
      periodType: serializer.fromJson<String>(json['periodType']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'boardId': serializer.toJson<String>(boardId),
      'columnId': serializer.toJson<String?>(columnId),
      'parentTaskId': serializer.toJson<String?>(parentTaskId),
      'taskTypeId': serializer.toJson<String?>(taskTypeId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'cardBackgroundColor': serializer.toJson<String?>(cardBackgroundColor),
      'cardTextColor': serializer.toJson<String?>(cardTextColor),
      'position': serializer.toJson<int>(position),
      'depth': serializer.toJson<int>(depth),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'assigneeName': serializer.toJson<String?>(assigneeName),
      'labelsJson': serializer.toJson<String>(labelsJson),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'estimatedDurationMinutes': serializer.toJson<int?>(
        estimatedDurationMinutes,
      ),
      'actualDurationMinutes': serializer.toJson<int?>(actualDurationMinutes),
      'periodType': serializer.toJson<String>(periodType),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  TasksTableData copyWith({
    String? id,
    String? boardId,
    Value<String?> columnId = const Value.absent(),
    Value<String?> parentTaskId = const Value.absent(),
    Value<String?> taskTypeId = const Value.absent(),
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> cardBackgroundColor = const Value.absent(),
    Value<String?> cardTextColor = const Value.absent(),
    int? position,
    int? depth,
    String? status,
    String? priority,
    Value<String?> assigneeName = const Value.absent(),
    String? labelsJson,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<int?> estimatedDurationMinutes = const Value.absent(),
    Value<int?> actualDurationMinutes = const Value.absent(),
    String? periodType,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => TasksTableData(
    id: id ?? this.id,
    boardId: boardId ?? this.boardId,
    columnId: columnId.present ? columnId.value : this.columnId,
    parentTaskId: parentTaskId.present ? parentTaskId.value : this.parentTaskId,
    taskTypeId: taskTypeId.present ? taskTypeId.value : this.taskTypeId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    cardBackgroundColor: cardBackgroundColor.present
        ? cardBackgroundColor.value
        : this.cardBackgroundColor,
    cardTextColor: cardTextColor.present
        ? cardTextColor.value
        : this.cardTextColor,
    position: position ?? this.position,
    depth: depth ?? this.depth,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    assigneeName: assigneeName.present ? assigneeName.value : this.assigneeName,
    labelsJson: labelsJson ?? this.labelsJson,
    startDate: startDate.present ? startDate.value : this.startDate,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    estimatedDurationMinutes: estimatedDurationMinutes.present
        ? estimatedDurationMinutes.value
        : this.estimatedDurationMinutes,
    actualDurationMinutes: actualDurationMinutes.present
        ? actualDurationMinutes.value
        : this.actualDurationMinutes,
    periodType: periodType ?? this.periodType,
    isCompleted: isCompleted ?? this.isCompleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  TasksTableData copyWithCompanion(TasksTableCompanion data) {
    return TasksTableData(
      id: data.id.present ? data.id.value : this.id,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      columnId: data.columnId.present ? data.columnId.value : this.columnId,
      parentTaskId: data.parentTaskId.present
          ? data.parentTaskId.value
          : this.parentTaskId,
      taskTypeId: data.taskTypeId.present
          ? data.taskTypeId.value
          : this.taskTypeId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      cardBackgroundColor: data.cardBackgroundColor.present
          ? data.cardBackgroundColor.value
          : this.cardBackgroundColor,
      cardTextColor: data.cardTextColor.present
          ? data.cardTextColor.value
          : this.cardTextColor,
      position: data.position.present ? data.position.value : this.position,
      depth: data.depth.present ? data.depth.value : this.depth,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      assigneeName: data.assigneeName.present
          ? data.assigneeName.value
          : this.assigneeName,
      labelsJson: data.labelsJson.present
          ? data.labelsJson.value
          : this.labelsJson,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      estimatedDurationMinutes: data.estimatedDurationMinutes.present
          ? data.estimatedDurationMinutes.value
          : this.estimatedDurationMinutes,
      actualDurationMinutes: data.actualDurationMinutes.present
          ? data.actualDurationMinutes.value
          : this.actualDurationMinutes,
      periodType: data.periodType.present
          ? data.periodType.value
          : this.periodType,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableData(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('columnId: $columnId, ')
          ..write('parentTaskId: $parentTaskId, ')
          ..write('taskTypeId: $taskTypeId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('cardBackgroundColor: $cardBackgroundColor, ')
          ..write('cardTextColor: $cardTextColor, ')
          ..write('position: $position, ')
          ..write('depth: $depth, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('assigneeName: $assigneeName, ')
          ..write('labelsJson: $labelsJson, ')
          ..write('startDate: $startDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('completedAt: $completedAt, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('periodType: $periodType, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    boardId,
    columnId,
    parentTaskId,
    taskTypeId,
    title,
    description,
    cardBackgroundColor,
    cardTextColor,
    position,
    depth,
    status,
    priority,
    assigneeName,
    labelsJson,
    startDate,
    dueDate,
    completedAt,
    estimatedDurationMinutes,
    actualDurationMinutes,
    periodType,
    isCompleted,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasksTableData &&
          other.id == this.id &&
          other.boardId == this.boardId &&
          other.columnId == this.columnId &&
          other.parentTaskId == this.parentTaskId &&
          other.taskTypeId == this.taskTypeId &&
          other.title == this.title &&
          other.description == this.description &&
          other.cardBackgroundColor == this.cardBackgroundColor &&
          other.cardTextColor == this.cardTextColor &&
          other.position == this.position &&
          other.depth == this.depth &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.assigneeName == this.assigneeName &&
          other.labelsJson == this.labelsJson &&
          other.startDate == this.startDate &&
          other.dueDate == this.dueDate &&
          other.completedAt == this.completedAt &&
          other.estimatedDurationMinutes == this.estimatedDurationMinutes &&
          other.actualDurationMinutes == this.actualDurationMinutes &&
          other.periodType == this.periodType &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class TasksTableCompanion extends UpdateCompanion<TasksTableData> {
  final Value<String> id;
  final Value<String> boardId;
  final Value<String?> columnId;
  final Value<String?> parentTaskId;
  final Value<String?> taskTypeId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> cardBackgroundColor;
  final Value<String?> cardTextColor;
  final Value<int> position;
  final Value<int> depth;
  final Value<String> status;
  final Value<String> priority;
  final Value<String?> assigneeName;
  final Value<String> labelsJson;
  final Value<DateTime?> startDate;
  final Value<DateTime?> dueDate;
  final Value<DateTime?> completedAt;
  final Value<int?> estimatedDurationMinutes;
  final Value<int?> actualDurationMinutes;
  final Value<String> periodType;
  final Value<bool> isCompleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const TasksTableCompanion({
    this.id = const Value.absent(),
    this.boardId = const Value.absent(),
    this.columnId = const Value.absent(),
    this.parentTaskId = const Value.absent(),
    this.taskTypeId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.cardBackgroundColor = const Value.absent(),
    this.cardTextColor = const Value.absent(),
    this.position = const Value.absent(),
    this.depth = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.assigneeName = const Value.absent(),
    this.labelsJson = const Value.absent(),
    this.startDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.actualDurationMinutes = const Value.absent(),
    this.periodType = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksTableCompanion.insert({
    required String id,
    required String boardId,
    this.columnId = const Value.absent(),
    this.parentTaskId = const Value.absent(),
    this.taskTypeId = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.cardBackgroundColor = const Value.absent(),
    this.cardTextColor = const Value.absent(),
    required int position,
    this.depth = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.assigneeName = const Value.absent(),
    this.labelsJson = const Value.absent(),
    this.startDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.actualDurationMinutes = const Value.absent(),
    this.periodType = const Value.absent(),
    this.isCompleted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       boardId = Value(boardId),
       title = Value(title),
       position = Value(position),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TasksTableData> custom({
    Expression<String>? id,
    Expression<String>? boardId,
    Expression<String>? columnId,
    Expression<String>? parentTaskId,
    Expression<String>? taskTypeId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? cardBackgroundColor,
    Expression<String>? cardTextColor,
    Expression<int>? position,
    Expression<int>? depth,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<String>? assigneeName,
    Expression<String>? labelsJson,
    Expression<DateTime>? startDate,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? completedAt,
    Expression<int>? estimatedDurationMinutes,
    Expression<int>? actualDurationMinutes,
    Expression<String>? periodType,
    Expression<bool>? isCompleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (boardId != null) 'board_id': boardId,
      if (columnId != null) 'column_id': columnId,
      if (parentTaskId != null) 'parent_task_id': parentTaskId,
      if (taskTypeId != null) 'task_type_id': taskTypeId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (cardBackgroundColor != null)
        'card_background_color': cardBackgroundColor,
      if (cardTextColor != null) 'card_text_color': cardTextColor,
      if (position != null) 'position': position,
      if (depth != null) 'depth': depth,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (assigneeName != null) 'assignee_name': assigneeName,
      if (labelsJson != null) 'labels_json': labelsJson,
      if (startDate != null) 'start_date': startDate,
      if (dueDate != null) 'due_date': dueDate,
      if (completedAt != null) 'completed_at': completedAt,
      if (estimatedDurationMinutes != null)
        'estimated_duration_minutes': estimatedDurationMinutes,
      if (actualDurationMinutes != null)
        'actual_duration_minutes': actualDurationMinutes,
      if (periodType != null) 'period_type': periodType,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? boardId,
    Value<String?>? columnId,
    Value<String?>? parentTaskId,
    Value<String?>? taskTypeId,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? cardBackgroundColor,
    Value<String?>? cardTextColor,
    Value<int>? position,
    Value<int>? depth,
    Value<String>? status,
    Value<String>? priority,
    Value<String?>? assigneeName,
    Value<String>? labelsJson,
    Value<DateTime?>? startDate,
    Value<DateTime?>? dueDate,
    Value<DateTime?>? completedAt,
    Value<int?>? estimatedDurationMinutes,
    Value<int?>? actualDurationMinutes,
    Value<String>? periodType,
    Value<bool>? isCompleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return TasksTableCompanion(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      columnId: columnId ?? this.columnId,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      taskTypeId: taskTypeId ?? this.taskTypeId,
      title: title ?? this.title,
      description: description ?? this.description,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      cardTextColor: cardTextColor ?? this.cardTextColor,
      position: position ?? this.position,
      depth: depth ?? this.depth,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assigneeName: assigneeName ?? this.assigneeName,
      labelsJson: labelsJson ?? this.labelsJson,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      actualDurationMinutes:
          actualDurationMinutes ?? this.actualDurationMinutes,
      periodType: periodType ?? this.periodType,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isSynced: isSynced ?? this.isSynced,
      syncAction: syncAction ?? this.syncAction,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (columnId.present) {
      map['column_id'] = Variable<String>(columnId.value);
    }
    if (parentTaskId.present) {
      map['parent_task_id'] = Variable<String>(parentTaskId.value);
    }
    if (taskTypeId.present) {
      map['task_type_id'] = Variable<String>(taskTypeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (cardBackgroundColor.present) {
      map['card_background_color'] = Variable<String>(
        cardBackgroundColor.value,
      );
    }
    if (cardTextColor.present) {
      map['card_text_color'] = Variable<String>(cardTextColor.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (assigneeName.present) {
      map['assignee_name'] = Variable<String>(assigneeName.value);
    }
    if (labelsJson.present) {
      map['labels_json'] = Variable<String>(labelsJson.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (estimatedDurationMinutes.present) {
      map['estimated_duration_minutes'] = Variable<int>(
        estimatedDurationMinutes.value,
      );
    }
    if (actualDurationMinutes.present) {
      map['actual_duration_minutes'] = Variable<int>(
        actualDurationMinutes.value,
      );
    }
    if (periodType.present) {
      map['period_type'] = Variable<String>(periodType.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (syncAction.present) {
      map['sync_action'] = Variable<String>(syncAction.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableCompanion(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('columnId: $columnId, ')
          ..write('parentTaskId: $parentTaskId, ')
          ..write('taskTypeId: $taskTypeId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('cardBackgroundColor: $cardBackgroundColor, ')
          ..write('cardTextColor: $cardTextColor, ')
          ..write('position: $position, ')
          ..write('depth: $depth, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('assigneeName: $assigneeName, ')
          ..write('labelsJson: $labelsJson, ')
          ..write('startDate: $startDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('completedAt: $completedAt, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('periodType: $periodType, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BoardsTableTable boardsTable = $BoardsTableTable(this);
  late final $BoardColumnsTableTable boardColumnsTable =
      $BoardColumnsTableTable(this);
  late final $TaskTypesTableTable taskTypesTable = $TaskTypesTableTable(this);
  late final $BoardCardSettingsTableTable boardCardSettingsTable =
      $BoardCardSettingsTableTable(this);
  late final $TasksTableTable tasksTable = $TasksTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    boardsTable,
    boardColumnsTable,
    taskTypesTable,
    boardCardSettingsTable,
    tasksTable,
  ];
}

typedef $$BoardsTableTableCreateCompanionBuilder =
    BoardsTableCompanion Function({
      required String id,
      required String ownerId,
      required String title,
      Value<String?> description,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$BoardsTableTableUpdateCompanionBuilder =
    BoardsTableCompanion Function({
      Value<String> id,
      Value<String> ownerId,
      Value<String> title,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$BoardsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BoardsTableTable> {
  $$BoardsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BoardsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BoardsTableTable> {
  $$BoardsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BoardsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BoardsTableTable> {
  $$BoardsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$BoardsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BoardsTableTable,
          BoardsTableData,
          $$BoardsTableTableFilterComposer,
          $$BoardsTableTableOrderingComposer,
          $$BoardsTableTableAnnotationComposer,
          $$BoardsTableTableCreateCompanionBuilder,
          $$BoardsTableTableUpdateCompanionBuilder,
          (
            BoardsTableData,
            BaseReferences<_$AppDatabase, $BoardsTableTable, BoardsTableData>,
          ),
          BoardsTableData,
          PrefetchHooks Function()
        > {
  $$BoardsTableTableTableManager(_$AppDatabase db, $BoardsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BoardsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BoardsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BoardsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BoardsTableCompanion(
                id: id,
                ownerId: ownerId,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String title,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BoardsTableCompanion.insert(
                id: id,
                ownerId: ownerId,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BoardsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BoardsTableTable,
      BoardsTableData,
      $$BoardsTableTableFilterComposer,
      $$BoardsTableTableOrderingComposer,
      $$BoardsTableTableAnnotationComposer,
      $$BoardsTableTableCreateCompanionBuilder,
      $$BoardsTableTableUpdateCompanionBuilder,
      (
        BoardsTableData,
        BaseReferences<_$AppDatabase, $BoardsTableTable, BoardsTableData>,
      ),
      BoardsTableData,
      PrefetchHooks Function()
    >;
typedef $$BoardColumnsTableTableCreateCompanionBuilder =
    BoardColumnsTableCompanion Function({
      required String id,
      required String boardId,
      required String title,
      required int position,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$BoardColumnsTableTableUpdateCompanionBuilder =
    BoardColumnsTableCompanion Function({
      Value<String> id,
      Value<String> boardId,
      Value<String> title,
      Value<int> position,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$BoardColumnsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BoardColumnsTableTable> {
  $$BoardColumnsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BoardColumnsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BoardColumnsTableTable> {
  $$BoardColumnsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BoardColumnsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BoardColumnsTableTable> {
  $$BoardColumnsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get boardId =>
      $composableBuilder(column: $table.boardId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$BoardColumnsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BoardColumnsTableTable,
          BoardColumnsTableData,
          $$BoardColumnsTableTableFilterComposer,
          $$BoardColumnsTableTableOrderingComposer,
          $$BoardColumnsTableTableAnnotationComposer,
          $$BoardColumnsTableTableCreateCompanionBuilder,
          $$BoardColumnsTableTableUpdateCompanionBuilder,
          (
            BoardColumnsTableData,
            BaseReferences<
              _$AppDatabase,
              $BoardColumnsTableTable,
              BoardColumnsTableData
            >,
          ),
          BoardColumnsTableData,
          PrefetchHooks Function()
        > {
  $$BoardColumnsTableTableTableManager(
    _$AppDatabase db,
    $BoardColumnsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BoardColumnsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BoardColumnsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BoardColumnsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> boardId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BoardColumnsTableCompanion(
                id: id,
                boardId: boardId,
                title: title,
                position: position,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String boardId,
                required String title,
                required int position,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BoardColumnsTableCompanion.insert(
                id: id,
                boardId: boardId,
                title: title,
                position: position,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BoardColumnsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BoardColumnsTableTable,
      BoardColumnsTableData,
      $$BoardColumnsTableTableFilterComposer,
      $$BoardColumnsTableTableOrderingComposer,
      $$BoardColumnsTableTableAnnotationComposer,
      $$BoardColumnsTableTableCreateCompanionBuilder,
      $$BoardColumnsTableTableUpdateCompanionBuilder,
      (
        BoardColumnsTableData,
        BaseReferences<
          _$AppDatabase,
          $BoardColumnsTableTable,
          BoardColumnsTableData
        >,
      ),
      BoardColumnsTableData,
      PrefetchHooks Function()
    >;
typedef $$TaskTypesTableTableCreateCompanionBuilder =
    TaskTypesTableCompanion Function({
      required String id,
      Value<String> boardId,
      required String name,
      required String color,
      required String icon,
      Value<String?> description,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$TaskTypesTableTableUpdateCompanionBuilder =
    TaskTypesTableCompanion Function({
      Value<String> id,
      Value<String> boardId,
      Value<String> name,
      Value<String> color,
      Value<String> icon,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$TaskTypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskTypesTableTable> {
  $$TaskTypesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaskTypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskTypesTableTable> {
  $$TaskTypesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaskTypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskTypesTableTable> {
  $$TaskTypesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get boardId =>
      $composableBuilder(column: $table.boardId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$TaskTypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaskTypesTableTable,
          TaskTypesTableData,
          $$TaskTypesTableTableFilterComposer,
          $$TaskTypesTableTableOrderingComposer,
          $$TaskTypesTableTableAnnotationComposer,
          $$TaskTypesTableTableCreateCompanionBuilder,
          $$TaskTypesTableTableUpdateCompanionBuilder,
          (
            TaskTypesTableData,
            BaseReferences<
              _$AppDatabase,
              $TaskTypesTableTable,
              TaskTypesTableData
            >,
          ),
          TaskTypesTableData,
          PrefetchHooks Function()
        > {
  $$TaskTypesTableTableTableManager(
    _$AppDatabase db,
    $TaskTypesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTypesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTypesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTypesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> boardId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaskTypesTableCompanion(
                id: id,
                boardId: boardId,
                name: name,
                color: color,
                icon: icon,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> boardId = const Value.absent(),
                required String name,
                required String color,
                required String icon,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaskTypesTableCompanion.insert(
                id: id,
                boardId: boardId,
                name: name,
                color: color,
                icon: icon,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaskTypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaskTypesTableTable,
      TaskTypesTableData,
      $$TaskTypesTableTableFilterComposer,
      $$TaskTypesTableTableOrderingComposer,
      $$TaskTypesTableTableAnnotationComposer,
      $$TaskTypesTableTableCreateCompanionBuilder,
      $$TaskTypesTableTableUpdateCompanionBuilder,
      (
        TaskTypesTableData,
        BaseReferences<_$AppDatabase, $TaskTypesTableTable, TaskTypesTableData>,
      ),
      TaskTypesTableData,
      PrefetchHooks Function()
    >;
typedef $$BoardCardSettingsTableTableCreateCompanionBuilder =
    BoardCardSettingsTableCompanion Function({
      required String boardId,
      Value<bool> showDescription,
      Value<bool> showTaskType,
      Value<bool> showPeriod,
      Value<bool> showSubtaskProgress,
      Value<bool> showPriority,
      Value<bool> showAssignee,
      Value<bool> showLabels,
      Value<bool> showCreatedAt,
      Value<bool> showQuickActions,
      Value<String> density,
      Value<String> style,
      Value<String> typeBadgePlacement,
      Value<String> typeColorMode,
      Value<String> cardBackgroundColor,
      Value<String> columnBackgroundColor,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BoardCardSettingsTableTableUpdateCompanionBuilder =
    BoardCardSettingsTableCompanion Function({
      Value<String> boardId,
      Value<bool> showDescription,
      Value<bool> showTaskType,
      Value<bool> showPeriod,
      Value<bool> showSubtaskProgress,
      Value<bool> showPriority,
      Value<bool> showAssignee,
      Value<bool> showLabels,
      Value<bool> showCreatedAt,
      Value<bool> showQuickActions,
      Value<String> density,
      Value<String> style,
      Value<String> typeBadgePlacement,
      Value<String> typeColorMode,
      Value<String> cardBackgroundColor,
      Value<String> columnBackgroundColor,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BoardCardSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BoardCardSettingsTableTable> {
  $$BoardCardSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showDescription => $composableBuilder(
    column: $table.showDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showTaskType => $composableBuilder(
    column: $table.showTaskType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showPeriod => $composableBuilder(
    column: $table.showPeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showSubtaskProgress => $composableBuilder(
    column: $table.showSubtaskProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showPriority => $composableBuilder(
    column: $table.showPriority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showAssignee => $composableBuilder(
    column: $table.showAssignee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showLabels => $composableBuilder(
    column: $table.showLabels,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showCreatedAt => $composableBuilder(
    column: $table.showCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showQuickActions => $composableBuilder(
    column: $table.showQuickActions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeBadgePlacement => $composableBuilder(
    column: $table.typeBadgePlacement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeColorMode => $composableBuilder(
    column: $table.typeColorMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardBackgroundColor => $composableBuilder(
    column: $table.cardBackgroundColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get columnBackgroundColor => $composableBuilder(
    column: $table.columnBackgroundColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BoardCardSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BoardCardSettingsTableTable> {
  $$BoardCardSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showDescription => $composableBuilder(
    column: $table.showDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showTaskType => $composableBuilder(
    column: $table.showTaskType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showPeriod => $composableBuilder(
    column: $table.showPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showSubtaskProgress => $composableBuilder(
    column: $table.showSubtaskProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showPriority => $composableBuilder(
    column: $table.showPriority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showAssignee => $composableBuilder(
    column: $table.showAssignee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showLabels => $composableBuilder(
    column: $table.showLabels,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showCreatedAt => $composableBuilder(
    column: $table.showCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showQuickActions => $composableBuilder(
    column: $table.showQuickActions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeBadgePlacement => $composableBuilder(
    column: $table.typeBadgePlacement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeColorMode => $composableBuilder(
    column: $table.typeColorMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardBackgroundColor => $composableBuilder(
    column: $table.cardBackgroundColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get columnBackgroundColor => $composableBuilder(
    column: $table.columnBackgroundColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BoardCardSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BoardCardSettingsTableTable> {
  $$BoardCardSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get boardId =>
      $composableBuilder(column: $table.boardId, builder: (column) => column);

  GeneratedColumn<bool> get showDescription => $composableBuilder(
    column: $table.showDescription,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showTaskType => $composableBuilder(
    column: $table.showTaskType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showPeriod => $composableBuilder(
    column: $table.showPeriod,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showSubtaskProgress => $composableBuilder(
    column: $table.showSubtaskProgress,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showPriority => $composableBuilder(
    column: $table.showPriority,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showAssignee => $composableBuilder(
    column: $table.showAssignee,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showLabels => $composableBuilder(
    column: $table.showLabels,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showCreatedAt => $composableBuilder(
    column: $table.showCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showQuickActions => $composableBuilder(
    column: $table.showQuickActions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get density =>
      $composableBuilder(column: $table.density, builder: (column) => column);

  GeneratedColumn<String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<String> get typeBadgePlacement => $composableBuilder(
    column: $table.typeBadgePlacement,
    builder: (column) => column,
  );

  GeneratedColumn<String> get typeColorMode => $composableBuilder(
    column: $table.typeColorMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cardBackgroundColor => $composableBuilder(
    column: $table.cardBackgroundColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get columnBackgroundColor => $composableBuilder(
    column: $table.columnBackgroundColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BoardCardSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BoardCardSettingsTableTable,
          BoardCardSettingsTableData,
          $$BoardCardSettingsTableTableFilterComposer,
          $$BoardCardSettingsTableTableOrderingComposer,
          $$BoardCardSettingsTableTableAnnotationComposer,
          $$BoardCardSettingsTableTableCreateCompanionBuilder,
          $$BoardCardSettingsTableTableUpdateCompanionBuilder,
          (
            BoardCardSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $BoardCardSettingsTableTable,
              BoardCardSettingsTableData
            >,
          ),
          BoardCardSettingsTableData,
          PrefetchHooks Function()
        > {
  $$BoardCardSettingsTableTableTableManager(
    _$AppDatabase db,
    $BoardCardSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BoardCardSettingsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BoardCardSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BoardCardSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> boardId = const Value.absent(),
                Value<bool> showDescription = const Value.absent(),
                Value<bool> showTaskType = const Value.absent(),
                Value<bool> showPeriod = const Value.absent(),
                Value<bool> showSubtaskProgress = const Value.absent(),
                Value<bool> showPriority = const Value.absent(),
                Value<bool> showAssignee = const Value.absent(),
                Value<bool> showLabels = const Value.absent(),
                Value<bool> showCreatedAt = const Value.absent(),
                Value<bool> showQuickActions = const Value.absent(),
                Value<String> density = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<String> typeBadgePlacement = const Value.absent(),
                Value<String> typeColorMode = const Value.absent(),
                Value<String> cardBackgroundColor = const Value.absent(),
                Value<String> columnBackgroundColor = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BoardCardSettingsTableCompanion(
                boardId: boardId,
                showDescription: showDescription,
                showTaskType: showTaskType,
                showPeriod: showPeriod,
                showSubtaskProgress: showSubtaskProgress,
                showPriority: showPriority,
                showAssignee: showAssignee,
                showLabels: showLabels,
                showCreatedAt: showCreatedAt,
                showQuickActions: showQuickActions,
                density: density,
                style: style,
                typeBadgePlacement: typeBadgePlacement,
                typeColorMode: typeColorMode,
                cardBackgroundColor: cardBackgroundColor,
                columnBackgroundColor: columnBackgroundColor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String boardId,
                Value<bool> showDescription = const Value.absent(),
                Value<bool> showTaskType = const Value.absent(),
                Value<bool> showPeriod = const Value.absent(),
                Value<bool> showSubtaskProgress = const Value.absent(),
                Value<bool> showPriority = const Value.absent(),
                Value<bool> showAssignee = const Value.absent(),
                Value<bool> showLabels = const Value.absent(),
                Value<bool> showCreatedAt = const Value.absent(),
                Value<bool> showQuickActions = const Value.absent(),
                Value<String> density = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<String> typeBadgePlacement = const Value.absent(),
                Value<String> typeColorMode = const Value.absent(),
                Value<String> cardBackgroundColor = const Value.absent(),
                Value<String> columnBackgroundColor = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BoardCardSettingsTableCompanion.insert(
                boardId: boardId,
                showDescription: showDescription,
                showTaskType: showTaskType,
                showPeriod: showPeriod,
                showSubtaskProgress: showSubtaskProgress,
                showPriority: showPriority,
                showAssignee: showAssignee,
                showLabels: showLabels,
                showCreatedAt: showCreatedAt,
                showQuickActions: showQuickActions,
                density: density,
                style: style,
                typeBadgePlacement: typeBadgePlacement,
                typeColorMode: typeColorMode,
                cardBackgroundColor: cardBackgroundColor,
                columnBackgroundColor: columnBackgroundColor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BoardCardSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BoardCardSettingsTableTable,
      BoardCardSettingsTableData,
      $$BoardCardSettingsTableTableFilterComposer,
      $$BoardCardSettingsTableTableOrderingComposer,
      $$BoardCardSettingsTableTableAnnotationComposer,
      $$BoardCardSettingsTableTableCreateCompanionBuilder,
      $$BoardCardSettingsTableTableUpdateCompanionBuilder,
      (
        BoardCardSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $BoardCardSettingsTableTable,
          BoardCardSettingsTableData
        >,
      ),
      BoardCardSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$TasksTableTableCreateCompanionBuilder =
    TasksTableCompanion Function({
      required String id,
      required String boardId,
      Value<String?> columnId,
      Value<String?> parentTaskId,
      Value<String?> taskTypeId,
      required String title,
      Value<String?> description,
      Value<String?> cardBackgroundColor,
      Value<String?> cardTextColor,
      required int position,
      Value<int> depth,
      Value<String> status,
      Value<String> priority,
      Value<String?> assigneeName,
      Value<String> labelsJson,
      Value<DateTime?> startDate,
      Value<DateTime?> dueDate,
      Value<DateTime?> completedAt,
      Value<int?> estimatedDurationMinutes,
      Value<int?> actualDurationMinutes,
      Value<String> periodType,
      Value<bool> isCompleted,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$TasksTableTableUpdateCompanionBuilder =
    TasksTableCompanion Function({
      Value<String> id,
      Value<String> boardId,
      Value<String?> columnId,
      Value<String?> parentTaskId,
      Value<String?> taskTypeId,
      Value<String> title,
      Value<String?> description,
      Value<String?> cardBackgroundColor,
      Value<String?> cardTextColor,
      Value<int> position,
      Value<int> depth,
      Value<String> status,
      Value<String> priority,
      Value<String?> assigneeName,
      Value<String> labelsJson,
      Value<DateTime?> startDate,
      Value<DateTime?> dueDate,
      Value<DateTime?> completedAt,
      Value<int?> estimatedDurationMinutes,
      Value<int?> actualDurationMinutes,
      Value<String> periodType,
      Value<bool> isCompleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$TasksTableTableFilterComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get columnId => $composableBuilder(
    column: $table.columnId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentTaskId => $composableBuilder(
    column: $table.parentTaskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskTypeId => $composableBuilder(
    column: $table.taskTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardBackgroundColor => $composableBuilder(
    column: $table.cardBackgroundColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardTextColor => $composableBuilder(
    column: $table.cardTextColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assigneeName => $composableBuilder(
    column: $table.assigneeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualDurationMinutes => $composableBuilder(
    column: $table.actualDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get columnId => $composableBuilder(
    column: $table.columnId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentTaskId => $composableBuilder(
    column: $table.parentTaskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskTypeId => $composableBuilder(
    column: $table.taskTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardBackgroundColor => $composableBuilder(
    column: $table.cardBackgroundColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardTextColor => $composableBuilder(
    column: $table.cardTextColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assigneeName => $composableBuilder(
    column: $table.assigneeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualDurationMinutes => $composableBuilder(
    column: $table.actualDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get boardId =>
      $composableBuilder(column: $table.boardId, builder: (column) => column);

  GeneratedColumn<String> get columnId =>
      $composableBuilder(column: $table.columnId, builder: (column) => column);

  GeneratedColumn<String> get parentTaskId => $composableBuilder(
    column: $table.parentTaskId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taskTypeId => $composableBuilder(
    column: $table.taskTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cardBackgroundColor => $composableBuilder(
    column: $table.cardBackgroundColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cardTextColor => $composableBuilder(
    column: $table.cardTextColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get assigneeName => $composableBuilder(
    column: $table.assigneeName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualDurationMinutes => $composableBuilder(
    column: $table.actualDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$TasksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTableTable,
          TasksTableData,
          $$TasksTableTableFilterComposer,
          $$TasksTableTableOrderingComposer,
          $$TasksTableTableAnnotationComposer,
          $$TasksTableTableCreateCompanionBuilder,
          $$TasksTableTableUpdateCompanionBuilder,
          (
            TasksTableData,
            BaseReferences<_$AppDatabase, $TasksTableTable, TasksTableData>,
          ),
          TasksTableData,
          PrefetchHooks Function()
        > {
  $$TasksTableTableTableManager(_$AppDatabase db, $TasksTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> boardId = const Value.absent(),
                Value<String?> columnId = const Value.absent(),
                Value<String?> parentTaskId = const Value.absent(),
                Value<String?> taskTypeId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> cardBackgroundColor = const Value.absent(),
                Value<String?> cardTextColor = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> depth = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String?> assigneeName = const Value.absent(),
                Value<String> labelsJson = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> estimatedDurationMinutes = const Value.absent(),
                Value<int?> actualDurationMinutes = const Value.absent(),
                Value<String> periodType = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion(
                id: id,
                boardId: boardId,
                columnId: columnId,
                parentTaskId: parentTaskId,
                taskTypeId: taskTypeId,
                title: title,
                description: description,
                cardBackgroundColor: cardBackgroundColor,
                cardTextColor: cardTextColor,
                position: position,
                depth: depth,
                status: status,
                priority: priority,
                assigneeName: assigneeName,
                labelsJson: labelsJson,
                startDate: startDate,
                dueDate: dueDate,
                completedAt: completedAt,
                estimatedDurationMinutes: estimatedDurationMinutes,
                actualDurationMinutes: actualDurationMinutes,
                periodType: periodType,
                isCompleted: isCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String boardId,
                Value<String?> columnId = const Value.absent(),
                Value<String?> parentTaskId = const Value.absent(),
                Value<String?> taskTypeId = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> cardBackgroundColor = const Value.absent(),
                Value<String?> cardTextColor = const Value.absent(),
                required int position,
                Value<int> depth = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String?> assigneeName = const Value.absent(),
                Value<String> labelsJson = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> estimatedDurationMinutes = const Value.absent(),
                Value<int?> actualDurationMinutes = const Value.absent(),
                Value<String> periodType = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion.insert(
                id: id,
                boardId: boardId,
                columnId: columnId,
                parentTaskId: parentTaskId,
                taskTypeId: taskTypeId,
                title: title,
                description: description,
                cardBackgroundColor: cardBackgroundColor,
                cardTextColor: cardTextColor,
                position: position,
                depth: depth,
                status: status,
                priority: priority,
                assigneeName: assigneeName,
                labelsJson: labelsJson,
                startDate: startDate,
                dueDate: dueDate,
                completedAt: completedAt,
                estimatedDurationMinutes: estimatedDurationMinutes,
                actualDurationMinutes: actualDurationMinutes,
                periodType: periodType,
                isCompleted: isCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTableTable,
      TasksTableData,
      $$TasksTableTableFilterComposer,
      $$TasksTableTableOrderingComposer,
      $$TasksTableTableAnnotationComposer,
      $$TasksTableTableCreateCompanionBuilder,
      $$TasksTableTableUpdateCompanionBuilder,
      (
        TasksTableData,
        BaseReferences<_$AppDatabase, $TasksTableTable, TasksTableData>,
      ),
      TasksTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BoardsTableTableTableManager get boardsTable =>
      $$BoardsTableTableTableManager(_db, _db.boardsTable);
  $$BoardColumnsTableTableTableManager get boardColumnsTable =>
      $$BoardColumnsTableTableTableManager(_db, _db.boardColumnsTable);
  $$TaskTypesTableTableTableManager get taskTypesTable =>
      $$TaskTypesTableTableTableManager(_db, _db.taskTypesTable);
  $$BoardCardSettingsTableTableTableManager get boardCardSettingsTable =>
      $$BoardCardSettingsTableTableTableManager(
        _db,
        _db.boardCardSettingsTable,
      );
  $$TasksTableTableTableManager get tasksTable =>
      $$TasksTableTableTableManager(_db, _db.tasksTable);
}
