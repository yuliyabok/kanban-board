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
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
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
    workspaceId,
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
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
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
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      ),
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
  final String? workspaceId;
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
    this.workspaceId,
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
    if (!nullToAbsent || workspaceId != null) {
      map['workspace_id'] = Variable<String>(workspaceId);
    }
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
      workspaceId: workspaceId == null && nullToAbsent
          ? const Value.absent()
          : Value(workspaceId),
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
      workspaceId: serializer.fromJson<String?>(json['workspaceId']),
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
      'workspaceId': serializer.toJson<String?>(workspaceId),
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
    Value<String?> workspaceId = const Value.absent(),
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
    workspaceId: workspaceId.present ? workspaceId.value : this.workspaceId,
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
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
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
          ..write('workspaceId: $workspaceId, ')
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
    workspaceId,
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
          other.workspaceId == this.workspaceId &&
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
  final Value<String?> workspaceId;
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
    this.workspaceId = const Value.absent(),
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
    this.workspaceId = const Value.absent(),
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
    Expression<String>? workspaceId,
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
      if (workspaceId != null) 'workspace_id': workspaceId,
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
    Value<String?>? workspaceId,
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
      workspaceId: workspaceId ?? this.workspaceId,
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
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
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
          ..write('workspaceId: $workspaceId, ')
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

class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordSaltMeta = const VerificationMeta(
    'passwordSalt',
  );
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
    'password_salt',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    fullName,
    position,
    avatarUrl,
    passwordHash,
    passwordSalt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('password_salt')) {
      context.handle(
        _passwordSaltMeta,
        passwordSalt.isAcceptableOrUnknown(
          data['password_salt']!,
          _passwordSaltMeta,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      ),
      passwordSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_salt'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  final String id;
  final String email;
  final String fullName;
  final String? position;
  final String? avatarUrl;
  final String? passwordHash;
  final String? passwordSalt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UsersTableData({
    required this.id,
    required this.email,
    required this.fullName,
    this.position,
    this.avatarUrl,
    this.passwordHash,
    this.passwordSalt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    if (!nullToAbsent || passwordSalt != null) {
      map['password_salt'] = Variable<String>(passwordSalt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      email: Value(email),
      fullName: Value(fullName),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      passwordSalt: passwordSalt == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordSalt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UsersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      fullName: serializer.fromJson<String>(json['fullName']),
      position: serializer.fromJson<String?>(json['position']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String?>(json['passwordSalt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'fullName': serializer.toJson<String>(fullName),
      'position': serializer.toJson<String?>(position),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'passwordSalt': serializer.toJson<String?>(passwordSalt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UsersTableData copyWith({
    String? id,
    String? email,
    String? fullName,
    Value<String?> position = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> passwordHash = const Value.absent(),
    Value<String?> passwordSalt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UsersTableData(
    id: id ?? this.id,
    email: email ?? this.email,
    fullName: fullName ?? this.fullName,
    position: position.present ? position.value : this.position,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    passwordHash: passwordHash.present ? passwordHash.value : this.passwordHash,
    passwordSalt: passwordSalt.present ? passwordSalt.value : this.passwordSalt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      position: data.position.present ? data.position.value : this.position,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    email,
    fullName,
    position,
    avatarUrl,
    passwordHash,
    passwordSalt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.email == this.email &&
          other.fullName == this.fullName &&
          other.position == this.position &&
          other.avatarUrl == this.avatarUrl &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> fullName;
  final Value<String?> position;
  final Value<String?> avatarUrl;
  final Value<String?> passwordHash;
  final Value<String?> passwordSalt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.fullName = const Value.absent(),
    this.position = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersTableCompanion.insert({
    required String id,
    required String email,
    required String fullName,
    this.position = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       fullName = Value(fullName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UsersTableData> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? fullName,
    Expression<String>? position,
    Expression<String>? avatarUrl,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (fullName != null) 'full_name': fullName,
      if (position != null) 'position': position,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String>? fullName,
    Value<String?>? position,
    Value<String?>? avatarUrl,
    Value<String?>? passwordHash,
    Value<String?>? passwordSalt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UsersTableCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkspacesTableTable extends WorkspacesTable
    with TableInfo<$WorkspacesTableTable, WorkspacesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspacesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
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
    name,
    ownerId,
    createdAt,
    updatedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspaces_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkspacesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
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
  WorkspacesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkspacesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
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
  $WorkspacesTableTable createAlias(String alias) {
    return $WorkspacesTableTable(attachedDatabase, alias);
  }
}

class WorkspacesTableData extends DataClass
    implements Insertable<WorkspacesTableData> {
  final String id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  final String? syncAction;
  const WorkspacesTableData({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['owner_id'] = Variable<String>(ownerId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  WorkspacesTableCompanion toCompanion(bool nullToAbsent) {
    return WorkspacesTableCompanion(
      id: Value(id),
      name: Value(name),
      ownerId: Value(ownerId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory WorkspacesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkspacesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'ownerId': serializer.toJson<String>(ownerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  WorkspacesTableData copyWith({
    String? id,
    String? name,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => WorkspacesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    ownerId: ownerId ?? this.ownerId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  WorkspacesTableData copyWithCompanion(WorkspacesTableCompanion data) {
    return WorkspacesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkspacesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ownerId: $ownerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    ownerId,
    createdAt,
    updatedAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspacesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.ownerId == this.ownerId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class WorkspacesTableCompanion extends UpdateCompanion<WorkspacesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> ownerId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const WorkspacesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkspacesTableCompanion.insert({
    required String id,
    required String name,
    required String ownerId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkspacesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? ownerId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ownerId != null) 'owner_id': ownerId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkspacesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? ownerId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return WorkspacesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
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
    return (StringBuffer('WorkspacesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ownerId: $ownerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkspaceMembersTableTable extends WorkspaceMembersTable
    with TableInfo<$WorkspaceMembersTableTable, WorkspaceMembersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspaceMembersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    workspaceId,
    userId,
    role,
    joinedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspace_members_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkspaceMembersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
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
  WorkspaceMembersTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkspaceMembersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      )!,
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
  $WorkspaceMembersTableTable createAlias(String alias) {
    return $WorkspaceMembersTableTable(attachedDatabase, alias);
  }
}

class WorkspaceMembersTableData extends DataClass
    implements Insertable<WorkspaceMembersTableData> {
  final String id;
  final String workspaceId;
  final String userId;
  final String role;
  final DateTime joinedAt;
  final bool isSynced;
  final String? syncAction;
  const WorkspaceMembersTableData({
    required this.id,
    required this.workspaceId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  WorkspaceMembersTableCompanion toCompanion(bool nullToAbsent) {
    return WorkspaceMembersTableCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      userId: Value(userId),
      role: Value(role),
      joinedAt: Value(joinedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory WorkspaceMembersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkspaceMembersTableData(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  WorkspaceMembersTableData copyWith({
    String? id,
    String? workspaceId,
    String? userId,
    String? role,
    DateTime? joinedAt,
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => WorkspaceMembersTableData(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    joinedAt: joinedAt ?? this.joinedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  WorkspaceMembersTableData copyWithCompanion(
    WorkspaceMembersTableCompanion data,
  ) {
    return WorkspaceMembersTableData(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkspaceMembersTableData(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    userId,
    role,
    joinedAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceMembersTableData &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.joinedAt == this.joinedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class WorkspaceMembersTableCompanion
    extends UpdateCompanion<WorkspaceMembersTableData> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> userId;
  final Value<String> role;
  final Value<DateTime> joinedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const WorkspaceMembersTableCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkspaceMembersTableCompanion.insert({
    required String id,
    required String workspaceId,
    required String userId,
    required String role,
    required DateTime joinedAt,
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       userId = Value(userId),
       role = Value(role),
       joinedAt = Value(joinedAt);
  static Insertable<WorkspaceMembersTableData> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<DateTime>? joinedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkspaceMembersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? userId,
    Value<String>? role,
    Value<DateTime>? joinedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return WorkspaceMembersTableCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
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
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
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
    return (StringBuffer('WorkspaceMembersTableCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BoardMembersTableTable extends BoardMembersTable
    with TableInfo<$BoardMembersTableTable, BoardMembersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BoardMembersTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    userId,
    role,
    joinedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'board_members_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BoardMembersTableData> instance, {
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
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
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
  BoardMembersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BoardMembersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      boardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      )!,
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
  $BoardMembersTableTable createAlias(String alias) {
    return $BoardMembersTableTable(attachedDatabase, alias);
  }
}

class BoardMembersTableData extends DataClass
    implements Insertable<BoardMembersTableData> {
  final String id;
  final String boardId;
  final String userId;
  final String role;
  final DateTime joinedAt;
  final bool isSynced;
  final String? syncAction;
  const BoardMembersTableData({
    required this.id,
    required this.boardId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['board_id'] = Variable<String>(boardId);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  BoardMembersTableCompanion toCompanion(bool nullToAbsent) {
    return BoardMembersTableCompanion(
      id: Value(id),
      boardId: Value(boardId),
      userId: Value(userId),
      role: Value(role),
      joinedAt: Value(joinedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory BoardMembersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BoardMembersTableData(
      id: serializer.fromJson<String>(json['id']),
      boardId: serializer.fromJson<String>(json['boardId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
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
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  BoardMembersTableData copyWith({
    String? id,
    String? boardId,
    String? userId,
    String? role,
    DateTime? joinedAt,
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => BoardMembersTableData(
    id: id ?? this.id,
    boardId: boardId ?? this.boardId,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    joinedAt: joinedAt ?? this.joinedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  BoardMembersTableData copyWithCompanion(BoardMembersTableCompanion data) {
    return BoardMembersTableData(
      id: data.id.present ? data.id.value : this.id,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BoardMembersTableData(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, boardId, userId, role, joinedAt, isSynced, syncAction);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoardMembersTableData &&
          other.id == this.id &&
          other.boardId == this.boardId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.joinedAt == this.joinedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class BoardMembersTableCompanion
    extends UpdateCompanion<BoardMembersTableData> {
  final Value<String> id;
  final Value<String> boardId;
  final Value<String> userId;
  final Value<String> role;
  final Value<DateTime> joinedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const BoardMembersTableCompanion({
    this.id = const Value.absent(),
    this.boardId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BoardMembersTableCompanion.insert({
    required String id,
    required String boardId,
    required String userId,
    required String role,
    required DateTime joinedAt,
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       boardId = Value(boardId),
       userId = Value(userId),
       role = Value(role),
       joinedAt = Value(joinedAt);
  static Insertable<BoardMembersTableData> custom({
    Expression<String>? id,
    Expression<String>? boardId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<DateTime>? joinedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (boardId != null) 'board_id': boardId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BoardMembersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? boardId,
    Value<String>? userId,
    Value<String>? role,
    Value<DateTime>? joinedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return BoardMembersTableCompanion(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
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
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
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
    return (StringBuffer('BoardMembersTableCompanion(')
          ..write('id: $id, ')
          ..write('boardId: $boardId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskAssigneesTableTable extends TaskAssigneesTable
    with TableInfo<$TaskAssigneesTableTable, TaskAssigneesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskAssigneesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assignedByMeta = const VerificationMeta(
    'assignedBy',
  );
  @override
  late final GeneratedColumn<String> assignedBy = GeneratedColumn<String>(
    'assigned_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assignedAtMeta = const VerificationMeta(
    'assignedAt',
  );
  @override
  late final GeneratedColumn<DateTime> assignedAt = GeneratedColumn<DateTime>(
    'assigned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    taskId,
    userId,
    assignedBy,
    assignedAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_assignees_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskAssigneesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('assigned_by')) {
      context.handle(
        _assignedByMeta,
        assignedBy.isAcceptableOrUnknown(data['assigned_by']!, _assignedByMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedByMeta);
    }
    if (data.containsKey('assigned_at')) {
      context.handle(
        _assignedAtMeta,
        assignedAt.isAcceptableOrUnknown(data['assigned_at']!, _assignedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedAtMeta);
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
  TaskAssigneesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskAssigneesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      assignedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_by'],
      )!,
      assignedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}assigned_at'],
      )!,
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
  $TaskAssigneesTableTable createAlias(String alias) {
    return $TaskAssigneesTableTable(attachedDatabase, alias);
  }
}

class TaskAssigneesTableData extends DataClass
    implements Insertable<TaskAssigneesTableData> {
  final String id;
  final String taskId;
  final String userId;
  final String assignedBy;
  final DateTime assignedAt;
  final bool isSynced;
  final String? syncAction;
  const TaskAssigneesTableData({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.assignedBy,
    required this.assignedAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['user_id'] = Variable<String>(userId);
    map['assigned_by'] = Variable<String>(assignedBy);
    map['assigned_at'] = Variable<DateTime>(assignedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  TaskAssigneesTableCompanion toCompanion(bool nullToAbsent) {
    return TaskAssigneesTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      userId: Value(userId),
      assignedBy: Value(assignedBy),
      assignedAt: Value(assignedAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory TaskAssigneesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskAssigneesTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      userId: serializer.fromJson<String>(json['userId']),
      assignedBy: serializer.fromJson<String>(json['assignedBy']),
      assignedAt: serializer.fromJson<DateTime>(json['assignedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'userId': serializer.toJson<String>(userId),
      'assignedBy': serializer.toJson<String>(assignedBy),
      'assignedAt': serializer.toJson<DateTime>(assignedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  TaskAssigneesTableData copyWith({
    String? id,
    String? taskId,
    String? userId,
    String? assignedBy,
    DateTime? assignedAt,
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => TaskAssigneesTableData(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    userId: userId ?? this.userId,
    assignedBy: assignedBy ?? this.assignedBy,
    assignedAt: assignedAt ?? this.assignedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  TaskAssigneesTableData copyWithCompanion(TaskAssigneesTableCompanion data) {
    return TaskAssigneesTableData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      userId: data.userId.present ? data.userId.value : this.userId,
      assignedBy: data.assignedBy.present
          ? data.assignedBy.value
          : this.assignedBy,
      assignedAt: data.assignedAt.present
          ? data.assignedAt.value
          : this.assignedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskAssigneesTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('userId: $userId, ')
          ..write('assignedBy: $assignedBy, ')
          ..write('assignedAt: $assignedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    taskId,
    userId,
    assignedBy,
    assignedAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskAssigneesTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.userId == this.userId &&
          other.assignedBy == this.assignedBy &&
          other.assignedAt == this.assignedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class TaskAssigneesTableCompanion
    extends UpdateCompanion<TaskAssigneesTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> userId;
  final Value<String> assignedBy;
  final Value<DateTime> assignedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const TaskAssigneesTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.userId = const Value.absent(),
    this.assignedBy = const Value.absent(),
    this.assignedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskAssigneesTableCompanion.insert({
    required String id,
    required String taskId,
    required String userId,
    required String assignedBy,
    required DateTime assignedAt,
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       taskId = Value(taskId),
       userId = Value(userId),
       assignedBy = Value(assignedBy),
       assignedAt = Value(assignedAt);
  static Insertable<TaskAssigneesTableData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? userId,
    Expression<String>? assignedBy,
    Expression<DateTime>? assignedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (userId != null) 'user_id': userId,
      if (assignedBy != null) 'assigned_by': assignedBy,
      if (assignedAt != null) 'assigned_at': assignedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskAssigneesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? taskId,
    Value<String>? userId,
    Value<String>? assignedBy,
    Value<DateTime>? assignedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return TaskAssigneesTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      assignedBy: assignedBy ?? this.assignedBy,
      assignedAt: assignedAt ?? this.assignedAt,
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
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (assignedBy.present) {
      map['assigned_by'] = Variable<String>(assignedBy.value);
    }
    if (assignedAt.present) {
      map['assigned_at'] = Variable<DateTime>(assignedAt.value);
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
    return (StringBuffer('TaskAssigneesTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('userId: $userId, ')
          ..write('assignedBy: $assignedBy, ')
          ..write('assignedAt: $assignedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskCommentsTableTable extends TaskCommentsTable
    with TableInfo<$TaskCommentsTableTable, TaskCommentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskCommentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 5000,
    ),
    type: DriftSqlType.string,
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
    taskId,
    authorId,
    content,
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
  static const String $name = 'task_comments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskCommentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
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
  TaskCommentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskCommentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
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
  $TaskCommentsTableTable createAlias(String alias) {
    return $TaskCommentsTableTable(attachedDatabase, alias);
  }
}

class TaskCommentsTableData extends DataClass
    implements Insertable<TaskCommentsTableData> {
  final String id;
  final String taskId;
  final String authorId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isSynced;
  final String? syncAction;
  const TaskCommentsTableData({
    required this.id,
    required this.taskId,
    required this.authorId,
    required this.content,
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
    map['task_id'] = Variable<String>(taskId);
    map['author_id'] = Variable<String>(authorId);
    map['content'] = Variable<String>(content);
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

  TaskCommentsTableCompanion toCompanion(bool nullToAbsent) {
    return TaskCommentsTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      authorId: Value(authorId),
      content: Value(content),
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

  factory TaskCommentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskCommentsTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      authorId: serializer.fromJson<String>(json['authorId']),
      content: serializer.fromJson<String>(json['content']),
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
      'taskId': serializer.toJson<String>(taskId),
      'authorId': serializer.toJson<String>(authorId),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  TaskCommentsTableData copyWith({
    String? id,
    String? taskId,
    String? authorId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => TaskCommentsTableData(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    authorId: authorId ?? this.authorId,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  TaskCommentsTableData copyWithCompanion(TaskCommentsTableCompanion data) {
    return TaskCommentsTableData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      content: data.content.present ? data.content.value : this.content,
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
    return (StringBuffer('TaskCommentsTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('authorId: $authorId, ')
          ..write('content: $content, ')
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
    taskId,
    authorId,
    content,
    createdAt,
    updatedAt,
    deletedAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskCommentsTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.authorId == this.authorId &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class TaskCommentsTableCompanion
    extends UpdateCompanion<TaskCommentsTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> authorId;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const TaskCommentsTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskCommentsTableCompanion.insert({
    required String id,
    required String taskId,
    required String authorId,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       taskId = Value(taskId),
       authorId = Value(authorId),
       content = Value(content),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TaskCommentsTableData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? authorId,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (authorId != null) 'author_id': authorId,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskCommentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? taskId,
    Value<String>? authorId,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return TaskCommentsTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
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
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
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
    return (StringBuffer('TaskCommentsTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('authorId: $authorId, ')
          ..write('content: $content, ')
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

class $TaskHistoryTableTable extends TaskHistoryTable
    with TableInfo<$TaskHistoryTableTable, TaskHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
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
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsJsonMeta = const VerificationMeta(
    'detailsJson',
  );
  @override
  late final GeneratedColumn<String> detailsJson = GeneratedColumn<String>(
    'details_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actorUserIdMeta = const VerificationMeta(
    'actorUserId',
  );
  @override
  late final GeneratedColumn<String> actorUserId = GeneratedColumn<String>(
    'actor_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    boardId,
    action,
    summary,
    detailsJson,
    actorUserId,
    changedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('board_id')) {
      context.handle(
        _boardIdMeta,
        boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('details_json')) {
      context.handle(
        _detailsJsonMeta,
        detailsJson.isAcceptableOrUnknown(
          data['details_json']!,
          _detailsJsonMeta,
        ),
      );
    }
    if (data.containsKey('actor_user_id')) {
      context.handle(
        _actorUserIdMeta,
        actorUserId.isAcceptableOrUnknown(
          data['actor_user_id']!,
          _actorUserIdMeta,
        ),
      );
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskHistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      boardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      detailsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details_json'],
      ),
      actorUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_user_id'],
      ),
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}changed_at'],
      )!,
    );
  }

  @override
  $TaskHistoryTableTable createAlias(String alias) {
    return $TaskHistoryTableTable(attachedDatabase, alias);
  }
}

class TaskHistoryTableData extends DataClass
    implements Insertable<TaskHistoryTableData> {
  final String id;
  final String taskId;
  final String boardId;
  final String action;
  final String summary;
  final String? detailsJson;
  final String? actorUserId;
  final DateTime changedAt;
  const TaskHistoryTableData({
    required this.id,
    required this.taskId,
    required this.boardId,
    required this.action,
    required this.summary,
    this.detailsJson,
    this.actorUserId,
    required this.changedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['board_id'] = Variable<String>(boardId);
    map['action'] = Variable<String>(action);
    map['summary'] = Variable<String>(summary);
    if (!nullToAbsent || detailsJson != null) {
      map['details_json'] = Variable<String>(detailsJson);
    }
    if (!nullToAbsent || actorUserId != null) {
      map['actor_user_id'] = Variable<String>(actorUserId);
    }
    map['changed_at'] = Variable<DateTime>(changedAt);
    return map;
  }

  TaskHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return TaskHistoryTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      boardId: Value(boardId),
      action: Value(action),
      summary: Value(summary),
      detailsJson: detailsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(detailsJson),
      actorUserId: actorUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(actorUserId),
      changedAt: Value(changedAt),
    );
  }

  factory TaskHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskHistoryTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      boardId: serializer.fromJson<String>(json['boardId']),
      action: serializer.fromJson<String>(json['action']),
      summary: serializer.fromJson<String>(json['summary']),
      detailsJson: serializer.fromJson<String?>(json['detailsJson']),
      actorUserId: serializer.fromJson<String?>(json['actorUserId']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'boardId': serializer.toJson<String>(boardId),
      'action': serializer.toJson<String>(action),
      'summary': serializer.toJson<String>(summary),
      'detailsJson': serializer.toJson<String?>(detailsJson),
      'actorUserId': serializer.toJson<String?>(actorUserId),
      'changedAt': serializer.toJson<DateTime>(changedAt),
    };
  }

  TaskHistoryTableData copyWith({
    String? id,
    String? taskId,
    String? boardId,
    String? action,
    String? summary,
    Value<String?> detailsJson = const Value.absent(),
    Value<String?> actorUserId = const Value.absent(),
    DateTime? changedAt,
  }) => TaskHistoryTableData(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    boardId: boardId ?? this.boardId,
    action: action ?? this.action,
    summary: summary ?? this.summary,
    detailsJson: detailsJson.present ? detailsJson.value : this.detailsJson,
    actorUserId: actorUserId.present ? actorUserId.value : this.actorUserId,
    changedAt: changedAt ?? this.changedAt,
  );
  TaskHistoryTableData copyWithCompanion(TaskHistoryTableCompanion data) {
    return TaskHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      action: data.action.present ? data.action.value : this.action,
      summary: data.summary.present ? data.summary.value : this.summary,
      detailsJson: data.detailsJson.present
          ? data.detailsJson.value
          : this.detailsJson,
      actorUserId: data.actorUserId.present
          ? data.actorUserId.value
          : this.actorUserId,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskHistoryTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('boardId: $boardId, ')
          ..write('action: $action, ')
          ..write('summary: $summary, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('actorUserId: $actorUserId, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    taskId,
    boardId,
    action,
    summary,
    detailsJson,
    actorUserId,
    changedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskHistoryTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.boardId == this.boardId &&
          other.action == this.action &&
          other.summary == this.summary &&
          other.detailsJson == this.detailsJson &&
          other.actorUserId == this.actorUserId &&
          other.changedAt == this.changedAt);
}

class TaskHistoryTableCompanion extends UpdateCompanion<TaskHistoryTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> boardId;
  final Value<String> action;
  final Value<String> summary;
  final Value<String?> detailsJson;
  final Value<String?> actorUserId;
  final Value<DateTime> changedAt;
  final Value<int> rowid;
  const TaskHistoryTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.boardId = const Value.absent(),
    this.action = const Value.absent(),
    this.summary = const Value.absent(),
    this.detailsJson = const Value.absent(),
    this.actorUserId = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskHistoryTableCompanion.insert({
    required String id,
    required String taskId,
    required String boardId,
    required String action,
    required String summary,
    this.detailsJson = const Value.absent(),
    this.actorUserId = const Value.absent(),
    required DateTime changedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       taskId = Value(taskId),
       boardId = Value(boardId),
       action = Value(action),
       summary = Value(summary),
       changedAt = Value(changedAt);
  static Insertable<TaskHistoryTableData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? boardId,
    Expression<String>? action,
    Expression<String>? summary,
    Expression<String>? detailsJson,
    Expression<String>? actorUserId,
    Expression<DateTime>? changedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (boardId != null) 'board_id': boardId,
      if (action != null) 'action': action,
      if (summary != null) 'summary': summary,
      if (detailsJson != null) 'details_json': detailsJson,
      if (actorUserId != null) 'actor_user_id': actorUserId,
      if (changedAt != null) 'changed_at': changedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskHistoryTableCompanion copyWith({
    Value<String>? id,
    Value<String>? taskId,
    Value<String>? boardId,
    Value<String>? action,
    Value<String>? summary,
    Value<String?>? detailsJson,
    Value<String?>? actorUserId,
    Value<DateTime>? changedAt,
    Value<int>? rowid,
  }) {
    return TaskHistoryTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      boardId: boardId ?? this.boardId,
      action: action ?? this.action,
      summary: summary ?? this.summary,
      detailsJson: detailsJson ?? this.detailsJson,
      actorUserId: actorUserId ?? this.actorUserId,
      changedAt: changedAt ?? this.changedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (detailsJson.present) {
      map['details_json'] = Variable<String>(detailsJson.value);
    }
    if (actorUserId.present) {
      map['actor_user_id'] = Variable<String>(actorUserId.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('boardId: $boardId, ')
          ..write('action: $action, ')
          ..write('summary: $summary, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('actorUserId: $actorUserId, ')
          ..write('changedAt: $changedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvitationsTableTable extends InvitationsTable
    with TableInfo<$InvitationsTableTable, InvitationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvitationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _boardIdMeta = const VerificationMeta(
    'boardId',
  );
  @override
  late final GeneratedColumn<String> boardId = GeneratedColumn<String>(
    'board_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invitedByMeta = const VerificationMeta(
    'invitedBy',
  );
  @override
  late final GeneratedColumn<String> invitedBy = GeneratedColumn<String>(
    'invited_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _acceptedAtMeta = const VerificationMeta(
    'acceptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> acceptedAt = GeneratedColumn<DateTime>(
    'accepted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _declinedAtMeta = const VerificationMeta(
    'declinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> declinedAt = GeneratedColumn<DateTime>(
    'declined_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
    email,
    workspaceId,
    boardId,
    role,
    token,
    invitedBy,
    expiresAt,
    acceptedAt,
    declinedAt,
    createdAt,
    isSynced,
    syncAction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invitations_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvitationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    }
    if (data.containsKey('board_id')) {
      context.handle(
        _boardIdMeta,
        boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('invited_by')) {
      context.handle(
        _invitedByMeta,
        invitedBy.isAcceptableOrUnknown(data['invited_by']!, _invitedByMeta),
      );
    } else if (isInserting) {
      context.missing(_invitedByMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('accepted_at')) {
      context.handle(
        _acceptedAtMeta,
        acceptedAt.isAcceptableOrUnknown(data['accepted_at']!, _acceptedAtMeta),
      );
    }
    if (data.containsKey('declined_at')) {
      context.handle(
        _declinedAtMeta,
        declinedAt.isAcceptableOrUnknown(data['declined_at']!, _declinedAtMeta),
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
  InvitationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvitationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      ),
      boardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_id'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      token: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token'],
      )!,
      invitedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invited_by'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      acceptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}accepted_at'],
      ),
      declinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}declined_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
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
  $InvitationsTableTable createAlias(String alias) {
    return $InvitationsTableTable(attachedDatabase, alias);
  }
}

class InvitationsTableData extends DataClass
    implements Insertable<InvitationsTableData> {
  final String id;
  final String email;
  final String? workspaceId;
  final String? boardId;
  final String role;
  final String token;
  final String invitedBy;
  final DateTime expiresAt;
  final DateTime? acceptedAt;
  final DateTime? declinedAt;
  final DateTime createdAt;
  final bool isSynced;
  final String? syncAction;
  const InvitationsTableData({
    required this.id,
    required this.email,
    this.workspaceId,
    this.boardId,
    required this.role,
    required this.token,
    required this.invitedBy,
    required this.expiresAt,
    this.acceptedAt,
    this.declinedAt,
    required this.createdAt,
    required this.isSynced,
    this.syncAction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || workspaceId != null) {
      map['workspace_id'] = Variable<String>(workspaceId);
    }
    if (!nullToAbsent || boardId != null) {
      map['board_id'] = Variable<String>(boardId);
    }
    map['role'] = Variable<String>(role);
    map['token'] = Variable<String>(token);
    map['invited_by'] = Variable<String>(invitedBy);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    if (!nullToAbsent || acceptedAt != null) {
      map['accepted_at'] = Variable<DateTime>(acceptedAt);
    }
    if (!nullToAbsent || declinedAt != null) {
      map['declined_at'] = Variable<DateTime>(declinedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || syncAction != null) {
      map['sync_action'] = Variable<String>(syncAction);
    }
    return map;
  }

  InvitationsTableCompanion toCompanion(bool nullToAbsent) {
    return InvitationsTableCompanion(
      id: Value(id),
      email: Value(email),
      workspaceId: workspaceId == null && nullToAbsent
          ? const Value.absent()
          : Value(workspaceId),
      boardId: boardId == null && nullToAbsent
          ? const Value.absent()
          : Value(boardId),
      role: Value(role),
      token: Value(token),
      invitedBy: Value(invitedBy),
      expiresAt: Value(expiresAt),
      acceptedAt: acceptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acceptedAt),
      declinedAt: declinedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(declinedAt),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
      syncAction: syncAction == null && nullToAbsent
          ? const Value.absent()
          : Value(syncAction),
    );
  }

  factory InvitationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvitationsTableData(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      workspaceId: serializer.fromJson<String?>(json['workspaceId']),
      boardId: serializer.fromJson<String?>(json['boardId']),
      role: serializer.fromJson<String>(json['role']),
      token: serializer.fromJson<String>(json['token']),
      invitedBy: serializer.fromJson<String>(json['invitedBy']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      acceptedAt: serializer.fromJson<DateTime?>(json['acceptedAt']),
      declinedAt: serializer.fromJson<DateTime?>(json['declinedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      syncAction: serializer.fromJson<String?>(json['syncAction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'workspaceId': serializer.toJson<String?>(workspaceId),
      'boardId': serializer.toJson<String?>(boardId),
      'role': serializer.toJson<String>(role),
      'token': serializer.toJson<String>(token),
      'invitedBy': serializer.toJson<String>(invitedBy),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'acceptedAt': serializer.toJson<DateTime?>(acceptedAt),
      'declinedAt': serializer.toJson<DateTime?>(declinedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'syncAction': serializer.toJson<String?>(syncAction),
    };
  }

  InvitationsTableData copyWith({
    String? id,
    String? email,
    Value<String?> workspaceId = const Value.absent(),
    Value<String?> boardId = const Value.absent(),
    String? role,
    String? token,
    String? invitedBy,
    DateTime? expiresAt,
    Value<DateTime?> acceptedAt = const Value.absent(),
    Value<DateTime?> declinedAt = const Value.absent(),
    DateTime? createdAt,
    bool? isSynced,
    Value<String?> syncAction = const Value.absent(),
  }) => InvitationsTableData(
    id: id ?? this.id,
    email: email ?? this.email,
    workspaceId: workspaceId.present ? workspaceId.value : this.workspaceId,
    boardId: boardId.present ? boardId.value : this.boardId,
    role: role ?? this.role,
    token: token ?? this.token,
    invitedBy: invitedBy ?? this.invitedBy,
    expiresAt: expiresAt ?? this.expiresAt,
    acceptedAt: acceptedAt.present ? acceptedAt.value : this.acceptedAt,
    declinedAt: declinedAt.present ? declinedAt.value : this.declinedAt,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
    syncAction: syncAction.present ? syncAction.value : this.syncAction,
  );
  InvitationsTableData copyWithCompanion(InvitationsTableCompanion data) {
    return InvitationsTableData(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      role: data.role.present ? data.role.value : this.role,
      token: data.token.present ? data.token.value : this.token,
      invitedBy: data.invitedBy.present ? data.invitedBy.value : this.invitedBy,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      acceptedAt: data.acceptedAt.present
          ? data.acceptedAt.value
          : this.acceptedAt,
      declinedAt: data.declinedAt.present
          ? data.declinedAt.value
          : this.declinedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      syncAction: data.syncAction.present
          ? data.syncAction.value
          : this.syncAction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvitationsTableData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('boardId: $boardId, ')
          ..write('role: $role, ')
          ..write('token: $token, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('declinedAt: $declinedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    email,
    workspaceId,
    boardId,
    role,
    token,
    invitedBy,
    expiresAt,
    acceptedAt,
    declinedAt,
    createdAt,
    isSynced,
    syncAction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvitationsTableData &&
          other.id == this.id &&
          other.email == this.email &&
          other.workspaceId == this.workspaceId &&
          other.boardId == this.boardId &&
          other.role == this.role &&
          other.token == this.token &&
          other.invitedBy == this.invitedBy &&
          other.expiresAt == this.expiresAt &&
          other.acceptedAt == this.acceptedAt &&
          other.declinedAt == this.declinedAt &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced &&
          other.syncAction == this.syncAction);
}

class InvitationsTableCompanion extends UpdateCompanion<InvitationsTableData> {
  final Value<String> id;
  final Value<String> email;
  final Value<String?> workspaceId;
  final Value<String?> boardId;
  final Value<String> role;
  final Value<String> token;
  final Value<String> invitedBy;
  final Value<DateTime> expiresAt;
  final Value<DateTime?> acceptedAt;
  final Value<DateTime?> declinedAt;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<String?> syncAction;
  final Value<int> rowid;
  const InvitationsTableCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.boardId = const Value.absent(),
    this.role = const Value.absent(),
    this.token = const Value.absent(),
    this.invitedBy = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.acceptedAt = const Value.absent(),
    this.declinedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvitationsTableCompanion.insert({
    required String id,
    required String email,
    this.workspaceId = const Value.absent(),
    this.boardId = const Value.absent(),
    required String role,
    required String token,
    required String invitedBy,
    required DateTime expiresAt,
    this.acceptedAt = const Value.absent(),
    this.declinedAt = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.syncAction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       role = Value(role),
       token = Value(token),
       invitedBy = Value(invitedBy),
       expiresAt = Value(expiresAt),
       createdAt = Value(createdAt);
  static Insertable<InvitationsTableData> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? workspaceId,
    Expression<String>? boardId,
    Expression<String>? role,
    Expression<String>? token,
    Expression<String>? invitedBy,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? acceptedAt,
    Expression<DateTime>? declinedAt,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<String>? syncAction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (boardId != null) 'board_id': boardId,
      if (role != null) 'role': role,
      if (token != null) 'token': token,
      if (invitedBy != null) 'invited_by': invitedBy,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (acceptedAt != null) 'accepted_at': acceptedAt,
      if (declinedAt != null) 'declined_at': declinedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (syncAction != null) 'sync_action': syncAction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvitationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String?>? workspaceId,
    Value<String?>? boardId,
    Value<String>? role,
    Value<String>? token,
    Value<String>? invitedBy,
    Value<DateTime>? expiresAt,
    Value<DateTime?>? acceptedAt,
    Value<DateTime?>? declinedAt,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
    Value<String?>? syncAction,
    Value<int>? rowid,
  }) {
    return InvitationsTableCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      workspaceId: workspaceId ?? this.workspaceId,
      boardId: boardId ?? this.boardId,
      role: role ?? this.role,
      token: token ?? this.token,
      invitedBy: invitedBy ?? this.invitedBy,
      expiresAt: expiresAt ?? this.expiresAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      declinedAt: declinedAt ?? this.declinedAt,
      createdAt: createdAt ?? this.createdAt,
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
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (invitedBy.present) {
      map['invited_by'] = Variable<String>(invitedBy.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (acceptedAt.present) {
      map['accepted_at'] = Variable<DateTime>(acceptedAt.value);
    }
    if (declinedAt.present) {
      map['declined_at'] = Variable<DateTime>(declinedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('InvitationsTableCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('boardId: $boardId, ')
          ..write('role: $role, ')
          ..write('token: $token, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('declinedAt: $declinedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('syncAction: $syncAction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncActionsTableTable extends SyncActionsTable
    with TableInfo<$SyncActionsTableTable, SyncActionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncActionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRetryAtMeta = const VerificationMeta(
    'lastRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRetryAt = GeneratedColumn<DateTime>(
    'last_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    action,
    entityId,
    payload,
    createdAt,
    retryCount,
    lastError,
    lastRetryAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_actions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncActionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('last_retry_at')) {
      context.handle(
        _lastRetryAtMeta,
        lastRetryAt.isAcceptableOrUnknown(
          data['last_retry_at']!,
          _lastRetryAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncActionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncActionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      lastRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_retry_at'],
      ),
    );
  }

  @override
  $SyncActionsTableTable createAlias(String alias) {
    return $SyncActionsTableTable(attachedDatabase, alias);
  }
}

class SyncActionsTableData extends DataClass
    implements Insertable<SyncActionsTableData> {
  /// Уникальный ID операции
  final String id;

  /// Тип сущности: 'task', 'comment', 'assignee', 'column', etc.
  final String entityType;

  /// Действие: 'create', 'update', 'delete'
  final String action;

  /// ID сущности (task ID, comment ID, etc.)
  final String entityId;

  /// JSON-сериализованные данные сущности для отправки
  final String payload;

  /// Когда была создана операция
  final DateTime createdAt;

  /// Количество попыток отправки
  final int retryCount;

  /// Последняя ошибка (если была)
  final String? lastError;

  /// Когда была последняя попытка
  final DateTime? lastRetryAt;
  const SyncActionsTableData({
    required this.id,
    required this.entityType,
    required this.action,
    required this.entityId,
    required this.payload,
    required this.createdAt,
    required this.retryCount,
    this.lastError,
    this.lastRetryAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['action'] = Variable<String>(action);
    map['entity_id'] = Variable<String>(entityId);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || lastRetryAt != null) {
      map['last_retry_at'] = Variable<DateTime>(lastRetryAt);
    }
    return map;
  }

  SyncActionsTableCompanion toCompanion(bool nullToAbsent) {
    return SyncActionsTableCompanion(
      id: Value(id),
      entityType: Value(entityType),
      action: Value(action),
      entityId: Value(entityId),
      payload: Value(payload),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      lastRetryAt: lastRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRetryAt),
    );
  }

  factory SyncActionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncActionsTableData(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      action: serializer.fromJson<String>(json['action']),
      entityId: serializer.fromJson<String>(json['entityId']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      lastRetryAt: serializer.fromJson<DateTime?>(json['lastRetryAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'action': serializer.toJson<String>(action),
      'entityId': serializer.toJson<String>(entityId),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'lastRetryAt': serializer.toJson<DateTime?>(lastRetryAt),
    };
  }

  SyncActionsTableData copyWith({
    String? id,
    String? entityType,
    String? action,
    String? entityId,
    String? payload,
    DateTime? createdAt,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> lastRetryAt = const Value.absent(),
  }) => SyncActionsTableData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    action: action ?? this.action,
    entityId: entityId ?? this.entityId,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    lastRetryAt: lastRetryAt.present ? lastRetryAt.value : this.lastRetryAt,
  );
  SyncActionsTableData copyWithCompanion(SyncActionsTableCompanion data) {
    return SyncActionsTableData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      action: data.action.present ? data.action.value : this.action,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      lastRetryAt: data.lastRetryAt.present
          ? data.lastRetryAt.value
          : this.lastRetryAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncActionsTableData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('action: $action, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastRetryAt: $lastRetryAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    action,
    entityId,
    payload,
    createdAt,
    retryCount,
    lastError,
    lastRetryAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncActionsTableData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.action == this.action &&
          other.entityId == this.entityId &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.lastRetryAt == this.lastRetryAt);
}

class SyncActionsTableCompanion extends UpdateCompanion<SyncActionsTableData> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> action;
  final Value<String> entityId;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime?> lastRetryAt;
  final Value<int> rowid;
  const SyncActionsTableCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.action = const Value.absent(),
    this.entityId = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastRetryAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncActionsTableCompanion.insert({
    required String id,
    required String entityType,
    required String action,
    required String entityId,
    required String payload,
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastRetryAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       action = Value(action),
       entityId = Value(entityId),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncActionsTableData> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? action,
    Expression<String>? entityId,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? lastRetryAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (action != null) 'action': action,
      if (entityId != null) 'entity_id': entityId,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (lastRetryAt != null) 'last_retry_at': lastRetryAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncActionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? action,
    Value<String>? entityId,
    Value<String>? payload,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime?>? lastRetryAt,
    Value<int>? rowid,
  }) {
    return SyncActionsTableCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      action: action ?? this.action,
      entityId: entityId ?? this.entityId,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      lastRetryAt: lastRetryAt ?? this.lastRetryAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (lastRetryAt.present) {
      map['last_retry_at'] = Variable<DateTime>(lastRetryAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncActionsTableCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('action: $action, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastRetryAt: $lastRetryAt, ')
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
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $WorkspacesTableTable workspacesTable = $WorkspacesTableTable(
    this,
  );
  late final $WorkspaceMembersTableTable workspaceMembersTable =
      $WorkspaceMembersTableTable(this);
  late final $BoardMembersTableTable boardMembersTable =
      $BoardMembersTableTable(this);
  late final $TaskAssigneesTableTable taskAssigneesTable =
      $TaskAssigneesTableTable(this);
  late final $TaskCommentsTableTable taskCommentsTable =
      $TaskCommentsTableTable(this);
  late final $TaskHistoryTableTable taskHistoryTable = $TaskHistoryTableTable(
    this,
  );
  late final $InvitationsTableTable invitationsTable = $InvitationsTableTable(
    this,
  );
  late final $SyncActionsTableTable syncActionsTable = $SyncActionsTableTable(
    this,
  );
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
    usersTable,
    workspacesTable,
    workspaceMembersTable,
    boardMembersTable,
    taskAssigneesTable,
    taskCommentsTable,
    taskHistoryTable,
    invitationsTable,
    syncActionsTable,
  ];
}

typedef $$BoardsTableTableCreateCompanionBuilder =
    BoardsTableCompanion Function({
      required String id,
      required String ownerId,
      Value<String?> workspaceId,
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
      Value<String?> workspaceId,
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

  ColumnFilters<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
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

  ColumnOrderings<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
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

  GeneratedColumn<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => column,
  );

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
                Value<String?> workspaceId = const Value.absent(),
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
                workspaceId: workspaceId,
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
                Value<String?> workspaceId = const Value.absent(),
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
                workspaceId: workspaceId,
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
typedef $$UsersTableTableCreateCompanionBuilder =
    UsersTableCompanion Function({
      required String id,
      required String email,
      required String fullName,
      Value<String?> position,
      Value<String?> avatarUrl,
      Value<String?> passwordHash,
      Value<String?> passwordSalt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UsersTableTableUpdateCompanionBuilder =
    UsersTableCompanion Function({
      Value<String> id,
      Value<String> email,
      Value<String> fullName,
      Value<String?> position,
      Value<String?> avatarUrl,
      Value<String?> passwordHash,
      Value<String?> passwordSalt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
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

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
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
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
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

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
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
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTableTable,
          UsersTableData,
          $$UsersTableTableFilterComposer,
          $$UsersTableTableOrderingComposer,
          $$UsersTableTableAnnotationComposer,
          $$UsersTableTableCreateCompanionBuilder,
          $$UsersTableTableUpdateCompanionBuilder,
          (
            UsersTableData,
            BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
          ),
          UsersTableData,
          PrefetchHooks Function()
        > {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> passwordSalt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersTableCompanion(
                id: id,
                email: email,
                fullName: fullName,
                position: position,
                avatarUrl: avatarUrl,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                required String fullName,
                Value<String?> position = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> passwordSalt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersTableCompanion.insert(
                id: id,
                email: email,
                fullName: fullName,
                position: position,
                avatarUrl: avatarUrl,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                createdAt: createdAt,
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

typedef $$UsersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTableTable,
      UsersTableData,
      $$UsersTableTableFilterComposer,
      $$UsersTableTableOrderingComposer,
      $$UsersTableTableAnnotationComposer,
      $$UsersTableTableCreateCompanionBuilder,
      $$UsersTableTableUpdateCompanionBuilder,
      (
        UsersTableData,
        BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
      ),
      UsersTableData,
      PrefetchHooks Function()
    >;
typedef $$WorkspacesTableTableCreateCompanionBuilder =
    WorkspacesTableCompanion Function({
      required String id,
      required String name,
      required String ownerId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$WorkspacesTableTableUpdateCompanionBuilder =
    WorkspacesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> ownerId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$WorkspacesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkspacesTableTable> {
  $$WorkspacesTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
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

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkspacesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkspacesTableTable> {
  $$WorkspacesTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
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

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkspacesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkspacesTableTable> {
  $$WorkspacesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$WorkspacesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkspacesTableTable,
          WorkspacesTableData,
          $$WorkspacesTableTableFilterComposer,
          $$WorkspacesTableTableOrderingComposer,
          $$WorkspacesTableTableAnnotationComposer,
          $$WorkspacesTableTableCreateCompanionBuilder,
          $$WorkspacesTableTableUpdateCompanionBuilder,
          (
            WorkspacesTableData,
            BaseReferences<
              _$AppDatabase,
              $WorkspacesTableTable,
              WorkspacesTableData
            >,
          ),
          WorkspacesTableData,
          PrefetchHooks Function()
        > {
  $$WorkspacesTableTableTableManager(
    _$AppDatabase db,
    $WorkspacesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkspacesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkspacesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkspacesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspacesTableCompanion(
                id: id,
                name: name,
                ownerId: ownerId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String ownerId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspacesTableCompanion.insert(
                id: id,
                name: name,
                ownerId: ownerId,
                createdAt: createdAt,
                updatedAt: updatedAt,
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

typedef $$WorkspacesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkspacesTableTable,
      WorkspacesTableData,
      $$WorkspacesTableTableFilterComposer,
      $$WorkspacesTableTableOrderingComposer,
      $$WorkspacesTableTableAnnotationComposer,
      $$WorkspacesTableTableCreateCompanionBuilder,
      $$WorkspacesTableTableUpdateCompanionBuilder,
      (
        WorkspacesTableData,
        BaseReferences<
          _$AppDatabase,
          $WorkspacesTableTable,
          WorkspacesTableData
        >,
      ),
      WorkspacesTableData,
      PrefetchHooks Function()
    >;
typedef $$WorkspaceMembersTableTableCreateCompanionBuilder =
    WorkspaceMembersTableCompanion Function({
      required String id,
      required String workspaceId,
      required String userId,
      required String role,
      required DateTime joinedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$WorkspaceMembersTableTableUpdateCompanionBuilder =
    WorkspaceMembersTableCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> userId,
      Value<String> role,
      Value<DateTime> joinedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$WorkspaceMembersTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkspaceMembersTableTable> {
  $$WorkspaceMembersTableTableFilterComposer({
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

  ColumnFilters<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
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

class $$WorkspaceMembersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkspaceMembersTableTable> {
  $$WorkspaceMembersTableTableOrderingComposer({
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

  ColumnOrderings<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
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

class $$WorkspaceMembersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkspaceMembersTableTable> {
  $$WorkspaceMembersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$WorkspaceMembersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkspaceMembersTableTable,
          WorkspaceMembersTableData,
          $$WorkspaceMembersTableTableFilterComposer,
          $$WorkspaceMembersTableTableOrderingComposer,
          $$WorkspaceMembersTableTableAnnotationComposer,
          $$WorkspaceMembersTableTableCreateCompanionBuilder,
          $$WorkspaceMembersTableTableUpdateCompanionBuilder,
          (
            WorkspaceMembersTableData,
            BaseReferences<
              _$AppDatabase,
              $WorkspaceMembersTableTable,
              WorkspaceMembersTableData
            >,
          ),
          WorkspaceMembersTableData,
          PrefetchHooks Function()
        > {
  $$WorkspaceMembersTableTableTableManager(
    _$AppDatabase db,
    $WorkspaceMembersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkspaceMembersTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$WorkspaceMembersTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkspaceMembersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspaceMembersTableCompanion(
                id: id,
                workspaceId: workspaceId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String userId,
                required String role,
                required DateTime joinedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspaceMembersTableCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
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

typedef $$WorkspaceMembersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkspaceMembersTableTable,
      WorkspaceMembersTableData,
      $$WorkspaceMembersTableTableFilterComposer,
      $$WorkspaceMembersTableTableOrderingComposer,
      $$WorkspaceMembersTableTableAnnotationComposer,
      $$WorkspaceMembersTableTableCreateCompanionBuilder,
      $$WorkspaceMembersTableTableUpdateCompanionBuilder,
      (
        WorkspaceMembersTableData,
        BaseReferences<
          _$AppDatabase,
          $WorkspaceMembersTableTable,
          WorkspaceMembersTableData
        >,
      ),
      WorkspaceMembersTableData,
      PrefetchHooks Function()
    >;
typedef $$BoardMembersTableTableCreateCompanionBuilder =
    BoardMembersTableCompanion Function({
      required String id,
      required String boardId,
      required String userId,
      required String role,
      required DateTime joinedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$BoardMembersTableTableUpdateCompanionBuilder =
    BoardMembersTableCompanion Function({
      Value<String> id,
      Value<String> boardId,
      Value<String> userId,
      Value<String> role,
      Value<DateTime> joinedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$BoardMembersTableTableFilterComposer
    extends Composer<_$AppDatabase, $BoardMembersTableTable> {
  $$BoardMembersTableTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
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

class $$BoardMembersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BoardMembersTableTable> {
  $$BoardMembersTableTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
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

class $$BoardMembersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BoardMembersTableTable> {
  $$BoardMembersTableTableAnnotationComposer({
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

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$BoardMembersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BoardMembersTableTable,
          BoardMembersTableData,
          $$BoardMembersTableTableFilterComposer,
          $$BoardMembersTableTableOrderingComposer,
          $$BoardMembersTableTableAnnotationComposer,
          $$BoardMembersTableTableCreateCompanionBuilder,
          $$BoardMembersTableTableUpdateCompanionBuilder,
          (
            BoardMembersTableData,
            BaseReferences<
              _$AppDatabase,
              $BoardMembersTableTable,
              BoardMembersTableData
            >,
          ),
          BoardMembersTableData,
          PrefetchHooks Function()
        > {
  $$BoardMembersTableTableTableManager(
    _$AppDatabase db,
    $BoardMembersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BoardMembersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BoardMembersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BoardMembersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> boardId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BoardMembersTableCompanion(
                id: id,
                boardId: boardId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String boardId,
                required String userId,
                required String role,
                required DateTime joinedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BoardMembersTableCompanion.insert(
                id: id,
                boardId: boardId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
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

typedef $$BoardMembersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BoardMembersTableTable,
      BoardMembersTableData,
      $$BoardMembersTableTableFilterComposer,
      $$BoardMembersTableTableOrderingComposer,
      $$BoardMembersTableTableAnnotationComposer,
      $$BoardMembersTableTableCreateCompanionBuilder,
      $$BoardMembersTableTableUpdateCompanionBuilder,
      (
        BoardMembersTableData,
        BaseReferences<
          _$AppDatabase,
          $BoardMembersTableTable,
          BoardMembersTableData
        >,
      ),
      BoardMembersTableData,
      PrefetchHooks Function()
    >;
typedef $$TaskAssigneesTableTableCreateCompanionBuilder =
    TaskAssigneesTableCompanion Function({
      required String id,
      required String taskId,
      required String userId,
      required String assignedBy,
      required DateTime assignedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$TaskAssigneesTableTableUpdateCompanionBuilder =
    TaskAssigneesTableCompanion Function({
      Value<String> id,
      Value<String> taskId,
      Value<String> userId,
      Value<String> assignedBy,
      Value<DateTime> assignedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$TaskAssigneesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskAssigneesTableTable> {
  $$TaskAssigneesTableTableFilterComposer({
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

  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedBy => $composableBuilder(
    column: $table.assignedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
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

class $$TaskAssigneesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskAssigneesTableTable> {
  $$TaskAssigneesTableTableOrderingComposer({
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

  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedBy => $composableBuilder(
    column: $table.assignedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
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

class $$TaskAssigneesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskAssigneesTableTable> {
  $$TaskAssigneesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get assignedBy => $composableBuilder(
    column: $table.assignedBy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$TaskAssigneesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaskAssigneesTableTable,
          TaskAssigneesTableData,
          $$TaskAssigneesTableTableFilterComposer,
          $$TaskAssigneesTableTableOrderingComposer,
          $$TaskAssigneesTableTableAnnotationComposer,
          $$TaskAssigneesTableTableCreateCompanionBuilder,
          $$TaskAssigneesTableTableUpdateCompanionBuilder,
          (
            TaskAssigneesTableData,
            BaseReferences<
              _$AppDatabase,
              $TaskAssigneesTableTable,
              TaskAssigneesTableData
            >,
          ),
          TaskAssigneesTableData,
          PrefetchHooks Function()
        > {
  $$TaskAssigneesTableTableTableManager(
    _$AppDatabase db,
    $TaskAssigneesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskAssigneesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskAssigneesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskAssigneesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> assignedBy = const Value.absent(),
                Value<DateTime> assignedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaskAssigneesTableCompanion(
                id: id,
                taskId: taskId,
                userId: userId,
                assignedBy: assignedBy,
                assignedAt: assignedAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String taskId,
                required String userId,
                required String assignedBy,
                required DateTime assignedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaskAssigneesTableCompanion.insert(
                id: id,
                taskId: taskId,
                userId: userId,
                assignedBy: assignedBy,
                assignedAt: assignedAt,
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

typedef $$TaskAssigneesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaskAssigneesTableTable,
      TaskAssigneesTableData,
      $$TaskAssigneesTableTableFilterComposer,
      $$TaskAssigneesTableTableOrderingComposer,
      $$TaskAssigneesTableTableAnnotationComposer,
      $$TaskAssigneesTableTableCreateCompanionBuilder,
      $$TaskAssigneesTableTableUpdateCompanionBuilder,
      (
        TaskAssigneesTableData,
        BaseReferences<
          _$AppDatabase,
          $TaskAssigneesTableTable,
          TaskAssigneesTableData
        >,
      ),
      TaskAssigneesTableData,
      PrefetchHooks Function()
    >;
typedef $$TaskCommentsTableTableCreateCompanionBuilder =
    TaskCommentsTableCompanion Function({
      required String id,
      required String taskId,
      required String authorId,
      required String content,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$TaskCommentsTableTableUpdateCompanionBuilder =
    TaskCommentsTableCompanion Function({
      Value<String> id,
      Value<String> taskId,
      Value<String> authorId,
      Value<String> content,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$TaskCommentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskCommentsTableTable> {
  $$TaskCommentsTableTableFilterComposer({
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

  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
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

class $$TaskCommentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskCommentsTableTable> {
  $$TaskCommentsTableTableOrderingComposer({
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

  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
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

class $$TaskCommentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskCommentsTableTable> {
  $$TaskCommentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

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

class $$TaskCommentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaskCommentsTableTable,
          TaskCommentsTableData,
          $$TaskCommentsTableTableFilterComposer,
          $$TaskCommentsTableTableOrderingComposer,
          $$TaskCommentsTableTableAnnotationComposer,
          $$TaskCommentsTableTableCreateCompanionBuilder,
          $$TaskCommentsTableTableUpdateCompanionBuilder,
          (
            TaskCommentsTableData,
            BaseReferences<
              _$AppDatabase,
              $TaskCommentsTableTable,
              TaskCommentsTableData
            >,
          ),
          TaskCommentsTableData,
          PrefetchHooks Function()
        > {
  $$TaskCommentsTableTableTableManager(
    _$AppDatabase db,
    $TaskCommentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskCommentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskCommentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskCommentsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> authorId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaskCommentsTableCompanion(
                id: id,
                taskId: taskId,
                authorId: authorId,
                content: content,
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
                required String taskId,
                required String authorId,
                required String content,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaskCommentsTableCompanion.insert(
                id: id,
                taskId: taskId,
                authorId: authorId,
                content: content,
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

typedef $$TaskCommentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaskCommentsTableTable,
      TaskCommentsTableData,
      $$TaskCommentsTableTableFilterComposer,
      $$TaskCommentsTableTableOrderingComposer,
      $$TaskCommentsTableTableAnnotationComposer,
      $$TaskCommentsTableTableCreateCompanionBuilder,
      $$TaskCommentsTableTableUpdateCompanionBuilder,
      (
        TaskCommentsTableData,
        BaseReferences<
          _$AppDatabase,
          $TaskCommentsTableTable,
          TaskCommentsTableData
        >,
      ),
      TaskCommentsTableData,
      PrefetchHooks Function()
    >;
typedef $$TaskHistoryTableTableCreateCompanionBuilder =
    TaskHistoryTableCompanion Function({
      required String id,
      required String taskId,
      required String boardId,
      required String action,
      required String summary,
      Value<String?> detailsJson,
      Value<String?> actorUserId,
      required DateTime changedAt,
      Value<int> rowid,
    });
typedef $$TaskHistoryTableTableUpdateCompanionBuilder =
    TaskHistoryTableCompanion Function({
      Value<String> id,
      Value<String> taskId,
      Value<String> boardId,
      Value<String> action,
      Value<String> summary,
      Value<String?> detailsJson,
      Value<String?> actorUserId,
      Value<DateTime> changedAt,
      Value<int> rowid,
    });

class $$TaskHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskHistoryTableTable> {
  $$TaskHistoryTableTableFilterComposer({
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

  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorUserId => $composableBuilder(
    column: $table.actorUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaskHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskHistoryTableTable> {
  $$TaskHistoryTableTableOrderingComposer({
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

  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorUserId => $composableBuilder(
    column: $table.actorUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaskHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskHistoryTableTable> {
  $$TaskHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get boardId =>
      $composableBuilder(column: $table.boardId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actorUserId => $composableBuilder(
    column: $table.actorUserId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);
}

class $$TaskHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaskHistoryTableTable,
          TaskHistoryTableData,
          $$TaskHistoryTableTableFilterComposer,
          $$TaskHistoryTableTableOrderingComposer,
          $$TaskHistoryTableTableAnnotationComposer,
          $$TaskHistoryTableTableCreateCompanionBuilder,
          $$TaskHistoryTableTableUpdateCompanionBuilder,
          (
            TaskHistoryTableData,
            BaseReferences<
              _$AppDatabase,
              $TaskHistoryTableTable,
              TaskHistoryTableData
            >,
          ),
          TaskHistoryTableData,
          PrefetchHooks Function()
        > {
  $$TaskHistoryTableTableTableManager(
    _$AppDatabase db,
    $TaskHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskHistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskHistoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> boardId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String?> detailsJson = const Value.absent(),
                Value<String?> actorUserId = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaskHistoryTableCompanion(
                id: id,
                taskId: taskId,
                boardId: boardId,
                action: action,
                summary: summary,
                detailsJson: detailsJson,
                actorUserId: actorUserId,
                changedAt: changedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String taskId,
                required String boardId,
                required String action,
                required String summary,
                Value<String?> detailsJson = const Value.absent(),
                Value<String?> actorUserId = const Value.absent(),
                required DateTime changedAt,
                Value<int> rowid = const Value.absent(),
              }) => TaskHistoryTableCompanion.insert(
                id: id,
                taskId: taskId,
                boardId: boardId,
                action: action,
                summary: summary,
                detailsJson: detailsJson,
                actorUserId: actorUserId,
                changedAt: changedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaskHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaskHistoryTableTable,
      TaskHistoryTableData,
      $$TaskHistoryTableTableFilterComposer,
      $$TaskHistoryTableTableOrderingComposer,
      $$TaskHistoryTableTableAnnotationComposer,
      $$TaskHistoryTableTableCreateCompanionBuilder,
      $$TaskHistoryTableTableUpdateCompanionBuilder,
      (
        TaskHistoryTableData,
        BaseReferences<
          _$AppDatabase,
          $TaskHistoryTableTable,
          TaskHistoryTableData
        >,
      ),
      TaskHistoryTableData,
      PrefetchHooks Function()
    >;
typedef $$InvitationsTableTableCreateCompanionBuilder =
    InvitationsTableCompanion Function({
      required String id,
      required String email,
      Value<String?> workspaceId,
      Value<String?> boardId,
      required String role,
      required String token,
      required String invitedBy,
      required DateTime expiresAt,
      Value<DateTime?> acceptedAt,
      Value<DateTime?> declinedAt,
      required DateTime createdAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });
typedef $$InvitationsTableTableUpdateCompanionBuilder =
    InvitationsTableCompanion Function({
      Value<String> id,
      Value<String> email,
      Value<String?> workspaceId,
      Value<String?> boardId,
      Value<String> role,
      Value<String> token,
      Value<String> invitedBy,
      Value<DateTime> expiresAt,
      Value<DateTime?> acceptedAt,
      Value<DateTime?> declinedAt,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
      Value<String?> syncAction,
      Value<int> rowid,
    });

class $$InvitationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InvitationsTableTable> {
  $$InvitationsTableTableFilterComposer({
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

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invitedBy => $composableBuilder(
    column: $table.invitedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get declinedAt => $composableBuilder(
    column: $table.declinedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

class $$InvitationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InvitationsTableTable> {
  $$InvitationsTableTableOrderingComposer({
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

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardId => $composableBuilder(
    column: $table.boardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invitedBy => $composableBuilder(
    column: $table.invitedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get declinedAt => $composableBuilder(
    column: $table.declinedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

class $$InvitationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvitationsTableTable> {
  $$InvitationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get boardId =>
      $composableBuilder(column: $table.boardId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<String> get invitedBy =>
      $composableBuilder(column: $table.invitedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get declinedAt => $composableBuilder(
    column: $table.declinedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get syncAction => $composableBuilder(
    column: $table.syncAction,
    builder: (column) => column,
  );
}

class $$InvitationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvitationsTableTable,
          InvitationsTableData,
          $$InvitationsTableTableFilterComposer,
          $$InvitationsTableTableOrderingComposer,
          $$InvitationsTableTableAnnotationComposer,
          $$InvitationsTableTableCreateCompanionBuilder,
          $$InvitationsTableTableUpdateCompanionBuilder,
          (
            InvitationsTableData,
            BaseReferences<
              _$AppDatabase,
              $InvitationsTableTable,
              InvitationsTableData
            >,
          ),
          InvitationsTableData,
          PrefetchHooks Function()
        > {
  $$InvitationsTableTableTableManager(
    _$AppDatabase db,
    $InvitationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvitationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvitationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvitationsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> workspaceId = const Value.absent(),
                Value<String?> boardId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> token = const Value.absent(),
                Value<String> invitedBy = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<DateTime?> acceptedAt = const Value.absent(),
                Value<DateTime?> declinedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvitationsTableCompanion(
                id: id,
                email: email,
                workspaceId: workspaceId,
                boardId: boardId,
                role: role,
                token: token,
                invitedBy: invitedBy,
                expiresAt: expiresAt,
                acceptedAt: acceptedAt,
                declinedAt: declinedAt,
                createdAt: createdAt,
                isSynced: isSynced,
                syncAction: syncAction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                Value<String?> workspaceId = const Value.absent(),
                Value<String?> boardId = const Value.absent(),
                required String role,
                required String token,
                required String invitedBy,
                required DateTime expiresAt,
                Value<DateTime?> acceptedAt = const Value.absent(),
                Value<DateTime?> declinedAt = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
                Value<String?> syncAction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvitationsTableCompanion.insert(
                id: id,
                email: email,
                workspaceId: workspaceId,
                boardId: boardId,
                role: role,
                token: token,
                invitedBy: invitedBy,
                expiresAt: expiresAt,
                acceptedAt: acceptedAt,
                declinedAt: declinedAt,
                createdAt: createdAt,
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

typedef $$InvitationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvitationsTableTable,
      InvitationsTableData,
      $$InvitationsTableTableFilterComposer,
      $$InvitationsTableTableOrderingComposer,
      $$InvitationsTableTableAnnotationComposer,
      $$InvitationsTableTableCreateCompanionBuilder,
      $$InvitationsTableTableUpdateCompanionBuilder,
      (
        InvitationsTableData,
        BaseReferences<
          _$AppDatabase,
          $InvitationsTableTable,
          InvitationsTableData
        >,
      ),
      InvitationsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncActionsTableTableCreateCompanionBuilder =
    SyncActionsTableCompanion Function({
      required String id,
      required String entityType,
      required String action,
      required String entityId,
      required String payload,
      required DateTime createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime?> lastRetryAt,
      Value<int> rowid,
    });
typedef $$SyncActionsTableTableUpdateCompanionBuilder =
    SyncActionsTableCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> action,
      Value<String> entityId,
      Value<String> payload,
      Value<DateTime> createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime?> lastRetryAt,
      Value<int> rowid,
    });

class $$SyncActionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncActionsTableTable> {
  $$SyncActionsTableTableFilterComposer({
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

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncActionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncActionsTableTable> {
  $$SyncActionsTableTableOrderingComposer({
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

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncActionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncActionsTableTable> {
  $$SyncActionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => column,
  );
}

class $$SyncActionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncActionsTableTable,
          SyncActionsTableData,
          $$SyncActionsTableTableFilterComposer,
          $$SyncActionsTableTableOrderingComposer,
          $$SyncActionsTableTableAnnotationComposer,
          $$SyncActionsTableTableCreateCompanionBuilder,
          $$SyncActionsTableTableUpdateCompanionBuilder,
          (
            SyncActionsTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncActionsTableTable,
              SyncActionsTableData
            >,
          ),
          SyncActionsTableData,
          PrefetchHooks Function()
        > {
  $$SyncActionsTableTableTableManager(
    _$AppDatabase db,
    $SyncActionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncActionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncActionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncActionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastRetryAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncActionsTableCompanion(
                id: id,
                entityType: entityType,
                action: action,
                entityId: entityId,
                payload: payload,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
                lastRetryAt: lastRetryAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String action,
                required String entityId,
                required String payload,
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastRetryAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncActionsTableCompanion.insert(
                id: id,
                entityType: entityType,
                action: action,
                entityId: entityId,
                payload: payload,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
                lastRetryAt: lastRetryAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncActionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncActionsTableTable,
      SyncActionsTableData,
      $$SyncActionsTableTableFilterComposer,
      $$SyncActionsTableTableOrderingComposer,
      $$SyncActionsTableTableAnnotationComposer,
      $$SyncActionsTableTableCreateCompanionBuilder,
      $$SyncActionsTableTableUpdateCompanionBuilder,
      (
        SyncActionsTableData,
        BaseReferences<
          _$AppDatabase,
          $SyncActionsTableTable,
          SyncActionsTableData
        >,
      ),
      SyncActionsTableData,
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
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$WorkspacesTableTableTableManager get workspacesTable =>
      $$WorkspacesTableTableTableManager(_db, _db.workspacesTable);
  $$WorkspaceMembersTableTableTableManager get workspaceMembersTable =>
      $$WorkspaceMembersTableTableTableManager(_db, _db.workspaceMembersTable);
  $$BoardMembersTableTableTableManager get boardMembersTable =>
      $$BoardMembersTableTableTableManager(_db, _db.boardMembersTable);
  $$TaskAssigneesTableTableTableManager get taskAssigneesTable =>
      $$TaskAssigneesTableTableTableManager(_db, _db.taskAssigneesTable);
  $$TaskCommentsTableTableTableManager get taskCommentsTable =>
      $$TaskCommentsTableTableTableManager(_db, _db.taskCommentsTable);
  $$TaskHistoryTableTableTableManager get taskHistoryTable =>
      $$TaskHistoryTableTableTableManager(_db, _db.taskHistoryTable);
  $$InvitationsTableTableTableManager get invitationsTable =>
      $$InvitationsTableTableTableManager(_db, _db.invitationsTable);
  $$SyncActionsTableTableTableManager get syncActionsTable =>
      $$SyncActionsTableTableTableManager(_db, _db.syncActionsTable);
}
