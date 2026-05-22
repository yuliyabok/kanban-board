// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_column_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardColumnEntity {

 String get id; String get boardId; String get title; int get position; DateTime get createdAt; DateTime get updatedAt; DateTime? get deletedAt; bool get isSynced;
/// Create a copy of BoardColumnEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardColumnEntityCopyWith<BoardColumnEntity> get copyWith => _$BoardColumnEntityCopyWithImpl<BoardColumnEntity>(this as BoardColumnEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardColumnEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.title, title) || other.title == title)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}


@override
int get hashCode => Object.hash(runtimeType,id,boardId,title,position,createdAt,updatedAt,deletedAt,isSynced);

@override
String toString() {
  return 'BoardColumnEntity(id: $id, boardId: $boardId, title: $title, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class $BoardColumnEntityCopyWith<$Res>  {
  factory $BoardColumnEntityCopyWith(BoardColumnEntity value, $Res Function(BoardColumnEntity) _then) = _$BoardColumnEntityCopyWithImpl;
@useResult
$Res call({
 String id, String boardId, String title, int position, DateTime createdAt, DateTime updatedAt, DateTime? deletedAt, bool isSynced
});




}
/// @nodoc
class _$BoardColumnEntityCopyWithImpl<$Res>
    implements $BoardColumnEntityCopyWith<$Res> {
  _$BoardColumnEntityCopyWithImpl(this._self, this._then);

  final BoardColumnEntity _self;
  final $Res Function(BoardColumnEntity) _then;

/// Create a copy of BoardColumnEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? boardId = null,Object? title = null,Object? position = null,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,Object? isSynced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardColumnEntity].
extension BoardColumnEntityPatterns on BoardColumnEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardColumnEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardColumnEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardColumnEntity value)  $default,){
final _that = this;
switch (_that) {
case _BoardColumnEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardColumnEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BoardColumnEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String boardId,  String title,  int position,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt,  bool isSynced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardColumnEntity() when $default != null:
return $default(_that.id,_that.boardId,_that.title,_that.position,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String boardId,  String title,  int position,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt,  bool isSynced)  $default,) {final _that = this;
switch (_that) {
case _BoardColumnEntity():
return $default(_that.id,_that.boardId,_that.title,_that.position,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String boardId,  String title,  int position,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt,  bool isSynced)?  $default,) {final _that = this;
switch (_that) {
case _BoardColumnEntity() when $default != null:
return $default(_that.id,_that.boardId,_that.title,_that.position,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isSynced);case _:
  return null;

}
}

}

/// @nodoc


class _BoardColumnEntity implements BoardColumnEntity {
  const _BoardColumnEntity({required this.id, required this.boardId, required this.title, required this.position, required this.createdAt, required this.updatedAt, this.deletedAt, this.isSynced = false});
  

@override final  String id;
@override final  String boardId;
@override final  String title;
@override final  int position;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? deletedAt;
@override@JsonKey() final  bool isSynced;

/// Create a copy of BoardColumnEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardColumnEntityCopyWith<_BoardColumnEntity> get copyWith => __$BoardColumnEntityCopyWithImpl<_BoardColumnEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardColumnEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.title, title) || other.title == title)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}


@override
int get hashCode => Object.hash(runtimeType,id,boardId,title,position,createdAt,updatedAt,deletedAt,isSynced);

@override
String toString() {
  return 'BoardColumnEntity(id: $id, boardId: $boardId, title: $title, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class _$BoardColumnEntityCopyWith<$Res> implements $BoardColumnEntityCopyWith<$Res> {
  factory _$BoardColumnEntityCopyWith(_BoardColumnEntity value, $Res Function(_BoardColumnEntity) _then) = __$BoardColumnEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String boardId, String title, int position, DateTime createdAt, DateTime updatedAt, DateTime? deletedAt, bool isSynced
});




}
/// @nodoc
class __$BoardColumnEntityCopyWithImpl<$Res>
    implements _$BoardColumnEntityCopyWith<$Res> {
  __$BoardColumnEntityCopyWithImpl(this._self, this._then);

  final _BoardColumnEntity _self;
  final $Res Function(_BoardColumnEntity) _then;

/// Create a copy of BoardColumnEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? boardId = null,Object? title = null,Object? position = null,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,Object? isSynced = null,}) {
  return _then(_BoardColumnEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
