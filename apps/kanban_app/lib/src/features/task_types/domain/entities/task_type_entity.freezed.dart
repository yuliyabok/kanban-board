// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_type_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskTypeEntity {

 String get id; String get boardId; String get name; String get color; String get icon; DateTime get createdAt; DateTime get updatedAt; String? get description; DateTime? get deletedAt; bool get isSynced;
/// Create a copy of TaskTypeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskTypeEntityCopyWith<TaskTypeEntity> get copyWith => _$TaskTypeEntityCopyWithImpl<TaskTypeEntity>(this as TaskTypeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskTypeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}


@override
int get hashCode => Object.hash(runtimeType,id,boardId,name,color,icon,createdAt,updatedAt,description,deletedAt,isSynced);

@override
String toString() {
  return 'TaskTypeEntity(id: $id, boardId: $boardId, name: $name, color: $color, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, deletedAt: $deletedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class $TaskTypeEntityCopyWith<$Res>  {
  factory $TaskTypeEntityCopyWith(TaskTypeEntity value, $Res Function(TaskTypeEntity) _then) = _$TaskTypeEntityCopyWithImpl;
@useResult
$Res call({
 String id, String boardId, String name, String color, String icon, DateTime createdAt, DateTime updatedAt, String? description, DateTime? deletedAt, bool isSynced
});




}
/// @nodoc
class _$TaskTypeEntityCopyWithImpl<$Res>
    implements $TaskTypeEntityCopyWith<$Res> {
  _$TaskTypeEntityCopyWithImpl(this._self, this._then);

  final TaskTypeEntity _self;
  final $Res Function(TaskTypeEntity) _then;

/// Create a copy of TaskTypeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? boardId = null,Object? name = null,Object? color = null,Object? icon = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? deletedAt = freezed,Object? isSynced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskTypeEntity].
extension TaskTypeEntityPatterns on TaskTypeEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskTypeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskTypeEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskTypeEntity value)  $default,){
final _that = this;
switch (_that) {
case _TaskTypeEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskTypeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TaskTypeEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String boardId,  String name,  String color,  String icon,  DateTime createdAt,  DateTime updatedAt,  String? description,  DateTime? deletedAt,  bool isSynced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskTypeEntity() when $default != null:
return $default(_that.id,_that.boardId,_that.name,_that.color,_that.icon,_that.createdAt,_that.updatedAt,_that.description,_that.deletedAt,_that.isSynced);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String boardId,  String name,  String color,  String icon,  DateTime createdAt,  DateTime updatedAt,  String? description,  DateTime? deletedAt,  bool isSynced)  $default,) {final _that = this;
switch (_that) {
case _TaskTypeEntity():
return $default(_that.id,_that.boardId,_that.name,_that.color,_that.icon,_that.createdAt,_that.updatedAt,_that.description,_that.deletedAt,_that.isSynced);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String boardId,  String name,  String color,  String icon,  DateTime createdAt,  DateTime updatedAt,  String? description,  DateTime? deletedAt,  bool isSynced)?  $default,) {final _that = this;
switch (_that) {
case _TaskTypeEntity() when $default != null:
return $default(_that.id,_that.boardId,_that.name,_that.color,_that.icon,_that.createdAt,_that.updatedAt,_that.description,_that.deletedAt,_that.isSynced);case _:
  return null;

}
}

}

/// @nodoc


class _TaskTypeEntity implements TaskTypeEntity {
  const _TaskTypeEntity({required this.id, required this.boardId, required this.name, required this.color, required this.icon, required this.createdAt, required this.updatedAt, this.description, this.deletedAt, this.isSynced = false});
  

@override final  String id;
@override final  String boardId;
@override final  String name;
@override final  String color;
@override final  String icon;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? description;
@override final  DateTime? deletedAt;
@override@JsonKey() final  bool isSynced;

/// Create a copy of TaskTypeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskTypeEntityCopyWith<_TaskTypeEntity> get copyWith => __$TaskTypeEntityCopyWithImpl<_TaskTypeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskTypeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}


@override
int get hashCode => Object.hash(runtimeType,id,boardId,name,color,icon,createdAt,updatedAt,description,deletedAt,isSynced);

@override
String toString() {
  return 'TaskTypeEntity(id: $id, boardId: $boardId, name: $name, color: $color, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, deletedAt: $deletedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class _$TaskTypeEntityCopyWith<$Res> implements $TaskTypeEntityCopyWith<$Res> {
  factory _$TaskTypeEntityCopyWith(_TaskTypeEntity value, $Res Function(_TaskTypeEntity) _then) = __$TaskTypeEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String boardId, String name, String color, String icon, DateTime createdAt, DateTime updatedAt, String? description, DateTime? deletedAt, bool isSynced
});




}
/// @nodoc
class __$TaskTypeEntityCopyWithImpl<$Res>
    implements _$TaskTypeEntityCopyWith<$Res> {
  __$TaskTypeEntityCopyWithImpl(this._self, this._then);

  final _TaskTypeEntity _self;
  final $Res Function(_TaskTypeEntity) _then;

/// Create a copy of TaskTypeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? boardId = null,Object? name = null,Object? color = null,Object? icon = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? deletedAt = freezed,Object? isSynced = null,}) {
  return _then(_TaskTypeEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
