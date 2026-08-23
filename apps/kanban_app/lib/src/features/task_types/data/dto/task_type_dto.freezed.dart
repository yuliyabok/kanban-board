// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_type_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskTypeDto {

 String get id; String get boardId; String get name; String get color; String get icon; DateTime get createdAt; DateTime get updatedAt; String? get description; DateTime? get deletedAt;
/// Create a copy of TaskTypeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskTypeDtoCopyWith<TaskTypeDto> get copyWith => _$TaskTypeDtoCopyWithImpl<TaskTypeDto>(this as TaskTypeDto, _$identity);

  /// Serializes this TaskTypeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskTypeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,boardId,name,color,icon,createdAt,updatedAt,description,deletedAt);

@override
String toString() {
  return 'TaskTypeDto(id: $id, boardId: $boardId, name: $name, color: $color, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $TaskTypeDtoCopyWith<$Res>  {
  factory $TaskTypeDtoCopyWith(TaskTypeDto value, $Res Function(TaskTypeDto) _then) = _$TaskTypeDtoCopyWithImpl;
@useResult
$Res call({
 String id, String boardId, String name, String color, String icon, DateTime createdAt, DateTime updatedAt, String? description, DateTime? deletedAt
});




}
/// @nodoc
class _$TaskTypeDtoCopyWithImpl<$Res>
    implements $TaskTypeDtoCopyWith<$Res> {
  _$TaskTypeDtoCopyWithImpl(this._self, this._then);

  final TaskTypeDto _self;
  final $Res Function(TaskTypeDto) _then;

/// Create a copy of TaskTypeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? boardId = null,Object? name = null,Object? color = null,Object? icon = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? deletedAt = freezed,}) {
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
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskTypeDto].
extension TaskTypeDtoPatterns on TaskTypeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskTypeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskTypeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskTypeDto value)  $default,){
final _that = this;
switch (_that) {
case _TaskTypeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskTypeDto value)?  $default,){
final _that = this;
switch (_that) {
case _TaskTypeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String boardId,  String name,  String color,  String icon,  DateTime createdAt,  DateTime updatedAt,  String? description,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskTypeDto() when $default != null:
return $default(_that.id,_that.boardId,_that.name,_that.color,_that.icon,_that.createdAt,_that.updatedAt,_that.description,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String boardId,  String name,  String color,  String icon,  DateTime createdAt,  DateTime updatedAt,  String? description,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _TaskTypeDto():
return $default(_that.id,_that.boardId,_that.name,_that.color,_that.icon,_that.createdAt,_that.updatedAt,_that.description,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String boardId,  String name,  String color,  String icon,  DateTime createdAt,  DateTime updatedAt,  String? description,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _TaskTypeDto() when $default != null:
return $default(_that.id,_that.boardId,_that.name,_that.color,_that.icon,_that.createdAt,_that.updatedAt,_that.description,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskTypeDto implements TaskTypeDto {
  const _TaskTypeDto({required this.id, required this.boardId, required this.name, required this.color, required this.icon, required this.createdAt, required this.updatedAt, this.description, this.deletedAt});
  factory _TaskTypeDto.fromJson(Map<String, dynamic> json) => _$TaskTypeDtoFromJson(json);

@override final  String id;
@override final  String boardId;
@override final  String name;
@override final  String color;
@override final  String icon;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? description;
@override final  DateTime? deletedAt;

/// Create a copy of TaskTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskTypeDtoCopyWith<_TaskTypeDto> get copyWith => __$TaskTypeDtoCopyWithImpl<_TaskTypeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskTypeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskTypeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,boardId,name,color,icon,createdAt,updatedAt,description,deletedAt);

@override
String toString() {
  return 'TaskTypeDto(id: $id, boardId: $boardId, name: $name, color: $color, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskTypeDtoCopyWith<$Res> implements $TaskTypeDtoCopyWith<$Res> {
  factory _$TaskTypeDtoCopyWith(_TaskTypeDto value, $Res Function(_TaskTypeDto) _then) = __$TaskTypeDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String boardId, String name, String color, String icon, DateTime createdAt, DateTime updatedAt, String? description, DateTime? deletedAt
});




}
/// @nodoc
class __$TaskTypeDtoCopyWithImpl<$Res>
    implements _$TaskTypeDtoCopyWith<$Res> {
  __$TaskTypeDtoCopyWithImpl(this._self, this._then);

  final _TaskTypeDto _self;
  final $Res Function(_TaskTypeDto) _then;

/// Create a copy of TaskTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? boardId = null,Object? name = null,Object? color = null,Object? icon = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? deletedAt = freezed,}) {
  return _then(_TaskTypeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
