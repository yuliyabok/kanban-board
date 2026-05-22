// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskDto {

 String get id; String get boardId; String get title; int get position; DateTime get createdAt; DateTime get updatedAt; String? get columnId; String? get parentTaskId; String? get taskTypeId; String? get description; String? get cardBackgroundColor; String? get cardTextColor; int get depth; String get status; String get priority; String? get assigneeName; List<String> get labels; DateTime? get startDate; DateTime? get dueDate; DateTime? get completedAt; int? get estimatedDurationMinutes; int? get actualDurationMinutes; String get periodType; bool get isCompleted; DateTime? get deletedAt;
/// Create a copy of TaskDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDtoCopyWith<TaskDto> get copyWith => _$TaskDtoCopyWithImpl<TaskDto>(this as TaskDto, _$identity);

  /// Serializes this TaskDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDto&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.title, title) || other.title == title)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.columnId, columnId) || other.columnId == columnId)&&(identical(other.parentTaskId, parentTaskId) || other.parentTaskId == parentTaskId)&&(identical(other.taskTypeId, taskTypeId) || other.taskTypeId == taskTypeId)&&(identical(other.description, description) || other.description == description)&&(identical(other.cardBackgroundColor, cardBackgroundColor) || other.cardBackgroundColor == cardBackgroundColor)&&(identical(other.cardTextColor, cardTextColor) || other.cardTextColor == cardTextColor)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.assigneeName, assigneeName) || other.assigneeName == assigneeName)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.estimatedDurationMinutes, estimatedDurationMinutes) || other.estimatedDurationMinutes == estimatedDurationMinutes)&&(identical(other.actualDurationMinutes, actualDurationMinutes) || other.actualDurationMinutes == actualDurationMinutes)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,boardId,title,position,createdAt,updatedAt,columnId,parentTaskId,taskTypeId,description,cardBackgroundColor,cardTextColor,depth,status,priority,assigneeName,const DeepCollectionEquality().hash(labels),startDate,dueDate,completedAt,estimatedDurationMinutes,actualDurationMinutes,periodType,isCompleted,deletedAt]);

@override
String toString() {
  return 'TaskDto(id: $id, boardId: $boardId, title: $title, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, columnId: $columnId, parentTaskId: $parentTaskId, taskTypeId: $taskTypeId, description: $description, cardBackgroundColor: $cardBackgroundColor, cardTextColor: $cardTextColor, depth: $depth, status: $status, priority: $priority, assigneeName: $assigneeName, labels: $labels, startDate: $startDate, dueDate: $dueDate, completedAt: $completedAt, estimatedDurationMinutes: $estimatedDurationMinutes, actualDurationMinutes: $actualDurationMinutes, periodType: $periodType, isCompleted: $isCompleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $TaskDtoCopyWith<$Res>  {
  factory $TaskDtoCopyWith(TaskDto value, $Res Function(TaskDto) _then) = _$TaskDtoCopyWithImpl;
@useResult
$Res call({
 String id, String boardId, String title, int position, DateTime createdAt, DateTime updatedAt, String? columnId, String? parentTaskId, String? taskTypeId, String? description, String? cardBackgroundColor, String? cardTextColor, int depth, String status, String priority, String? assigneeName, List<String> labels, DateTime? startDate, DateTime? dueDate, DateTime? completedAt, int? estimatedDurationMinutes, int? actualDurationMinutes, String periodType, bool isCompleted, DateTime? deletedAt
});




}
/// @nodoc
class _$TaskDtoCopyWithImpl<$Res>
    implements $TaskDtoCopyWith<$Res> {
  _$TaskDtoCopyWithImpl(this._self, this._then);

  final TaskDto _self;
  final $Res Function(TaskDto) _then;

/// Create a copy of TaskDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? boardId = null,Object? title = null,Object? position = null,Object? createdAt = null,Object? updatedAt = null,Object? columnId = freezed,Object? parentTaskId = freezed,Object? taskTypeId = freezed,Object? description = freezed,Object? cardBackgroundColor = freezed,Object? cardTextColor = freezed,Object? depth = null,Object? status = null,Object? priority = null,Object? assigneeName = freezed,Object? labels = null,Object? startDate = freezed,Object? dueDate = freezed,Object? completedAt = freezed,Object? estimatedDurationMinutes = freezed,Object? actualDurationMinutes = freezed,Object? periodType = null,Object? isCompleted = null,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,columnId: freezed == columnId ? _self.columnId : columnId // ignore: cast_nullable_to_non_nullable
as String?,parentTaskId: freezed == parentTaskId ? _self.parentTaskId : parentTaskId // ignore: cast_nullable_to_non_nullable
as String?,taskTypeId: freezed == taskTypeId ? _self.taskTypeId : taskTypeId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cardBackgroundColor: freezed == cardBackgroundColor ? _self.cardBackgroundColor : cardBackgroundColor // ignore: cast_nullable_to_non_nullable
as String?,cardTextColor: freezed == cardTextColor ? _self.cardTextColor : cardTextColor // ignore: cast_nullable_to_non_nullable
as String?,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,assigneeName: freezed == assigneeName ? _self.assigneeName : assigneeName // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,estimatedDurationMinutes: freezed == estimatedDurationMinutes ? _self.estimatedDurationMinutes : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,actualDurationMinutes: freezed == actualDurationMinutes ? _self.actualDurationMinutes : actualDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskDto].
extension TaskDtoPatterns on TaskDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskDto value)  $default,){
final _that = this;
switch (_that) {
case _TaskDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskDto value)?  $default,){
final _that = this;
switch (_that) {
case _TaskDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String boardId,  String title,  int position,  DateTime createdAt,  DateTime updatedAt,  String? columnId,  String? parentTaskId,  String? taskTypeId,  String? description,  String? cardBackgroundColor,  String? cardTextColor,  int depth,  String status,  String priority,  String? assigneeName,  List<String> labels,  DateTime? startDate,  DateTime? dueDate,  DateTime? completedAt,  int? estimatedDurationMinutes,  int? actualDurationMinutes,  String periodType,  bool isCompleted,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskDto() when $default != null:
return $default(_that.id,_that.boardId,_that.title,_that.position,_that.createdAt,_that.updatedAt,_that.columnId,_that.parentTaskId,_that.taskTypeId,_that.description,_that.cardBackgroundColor,_that.cardTextColor,_that.depth,_that.status,_that.priority,_that.assigneeName,_that.labels,_that.startDate,_that.dueDate,_that.completedAt,_that.estimatedDurationMinutes,_that.actualDurationMinutes,_that.periodType,_that.isCompleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String boardId,  String title,  int position,  DateTime createdAt,  DateTime updatedAt,  String? columnId,  String? parentTaskId,  String? taskTypeId,  String? description,  String? cardBackgroundColor,  String? cardTextColor,  int depth,  String status,  String priority,  String? assigneeName,  List<String> labels,  DateTime? startDate,  DateTime? dueDate,  DateTime? completedAt,  int? estimatedDurationMinutes,  int? actualDurationMinutes,  String periodType,  bool isCompleted,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _TaskDto():
return $default(_that.id,_that.boardId,_that.title,_that.position,_that.createdAt,_that.updatedAt,_that.columnId,_that.parentTaskId,_that.taskTypeId,_that.description,_that.cardBackgroundColor,_that.cardTextColor,_that.depth,_that.status,_that.priority,_that.assigneeName,_that.labels,_that.startDate,_that.dueDate,_that.completedAt,_that.estimatedDurationMinutes,_that.actualDurationMinutes,_that.periodType,_that.isCompleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String boardId,  String title,  int position,  DateTime createdAt,  DateTime updatedAt,  String? columnId,  String? parentTaskId,  String? taskTypeId,  String? description,  String? cardBackgroundColor,  String? cardTextColor,  int depth,  String status,  String priority,  String? assigneeName,  List<String> labels,  DateTime? startDate,  DateTime? dueDate,  DateTime? completedAt,  int? estimatedDurationMinutes,  int? actualDurationMinutes,  String periodType,  bool isCompleted,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _TaskDto() when $default != null:
return $default(_that.id,_that.boardId,_that.title,_that.position,_that.createdAt,_that.updatedAt,_that.columnId,_that.parentTaskId,_that.taskTypeId,_that.description,_that.cardBackgroundColor,_that.cardTextColor,_that.depth,_that.status,_that.priority,_that.assigneeName,_that.labels,_that.startDate,_that.dueDate,_that.completedAt,_that.estimatedDurationMinutes,_that.actualDurationMinutes,_that.periodType,_that.isCompleted,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskDto implements TaskDto {
  const _TaskDto({required this.id, required this.boardId, required this.title, required this.position, required this.createdAt, required this.updatedAt, this.columnId, this.parentTaskId, this.taskTypeId, this.description, this.cardBackgroundColor, this.cardTextColor, this.depth = 0, this.status = 'todo', this.priority = 'medium', this.assigneeName, final  List<String> labels = const [], this.startDate, this.dueDate, this.completedAt, this.estimatedDurationMinutes, this.actualDurationMinutes, this.periodType = 'custom', this.isCompleted = false, this.deletedAt}): _labels = labels;
  factory _TaskDto.fromJson(Map<String, dynamic> json) => _$TaskDtoFromJson(json);

@override final  String id;
@override final  String boardId;
@override final  String title;
@override final  int position;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? columnId;
@override final  String? parentTaskId;
@override final  String? taskTypeId;
@override final  String? description;
@override final  String? cardBackgroundColor;
@override final  String? cardTextColor;
@override@JsonKey() final  int depth;
@override@JsonKey() final  String status;
@override@JsonKey() final  String priority;
@override final  String? assigneeName;
 final  List<String> _labels;
@override@JsonKey() List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override final  DateTime? startDate;
@override final  DateTime? dueDate;
@override final  DateTime? completedAt;
@override final  int? estimatedDurationMinutes;
@override final  int? actualDurationMinutes;
@override@JsonKey() final  String periodType;
@override@JsonKey() final  bool isCompleted;
@override final  DateTime? deletedAt;

/// Create a copy of TaskDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskDtoCopyWith<_TaskDto> get copyWith => __$TaskDtoCopyWithImpl<_TaskDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskDto&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.title, title) || other.title == title)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.columnId, columnId) || other.columnId == columnId)&&(identical(other.parentTaskId, parentTaskId) || other.parentTaskId == parentTaskId)&&(identical(other.taskTypeId, taskTypeId) || other.taskTypeId == taskTypeId)&&(identical(other.description, description) || other.description == description)&&(identical(other.cardBackgroundColor, cardBackgroundColor) || other.cardBackgroundColor == cardBackgroundColor)&&(identical(other.cardTextColor, cardTextColor) || other.cardTextColor == cardTextColor)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.assigneeName, assigneeName) || other.assigneeName == assigneeName)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.estimatedDurationMinutes, estimatedDurationMinutes) || other.estimatedDurationMinutes == estimatedDurationMinutes)&&(identical(other.actualDurationMinutes, actualDurationMinutes) || other.actualDurationMinutes == actualDurationMinutes)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,boardId,title,position,createdAt,updatedAt,columnId,parentTaskId,taskTypeId,description,cardBackgroundColor,cardTextColor,depth,status,priority,assigneeName,const DeepCollectionEquality().hash(_labels),startDate,dueDate,completedAt,estimatedDurationMinutes,actualDurationMinutes,periodType,isCompleted,deletedAt]);

@override
String toString() {
  return 'TaskDto(id: $id, boardId: $boardId, title: $title, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, columnId: $columnId, parentTaskId: $parentTaskId, taskTypeId: $taskTypeId, description: $description, cardBackgroundColor: $cardBackgroundColor, cardTextColor: $cardTextColor, depth: $depth, status: $status, priority: $priority, assigneeName: $assigneeName, labels: $labels, startDate: $startDate, dueDate: $dueDate, completedAt: $completedAt, estimatedDurationMinutes: $estimatedDurationMinutes, actualDurationMinutes: $actualDurationMinutes, periodType: $periodType, isCompleted: $isCompleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskDtoCopyWith<$Res> implements $TaskDtoCopyWith<$Res> {
  factory _$TaskDtoCopyWith(_TaskDto value, $Res Function(_TaskDto) _then) = __$TaskDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String boardId, String title, int position, DateTime createdAt, DateTime updatedAt, String? columnId, String? parentTaskId, String? taskTypeId, String? description, String? cardBackgroundColor, String? cardTextColor, int depth, String status, String priority, String? assigneeName, List<String> labels, DateTime? startDate, DateTime? dueDate, DateTime? completedAt, int? estimatedDurationMinutes, int? actualDurationMinutes, String periodType, bool isCompleted, DateTime? deletedAt
});




}
/// @nodoc
class __$TaskDtoCopyWithImpl<$Res>
    implements _$TaskDtoCopyWith<$Res> {
  __$TaskDtoCopyWithImpl(this._self, this._then);

  final _TaskDto _self;
  final $Res Function(_TaskDto) _then;

/// Create a copy of TaskDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? boardId = null,Object? title = null,Object? position = null,Object? createdAt = null,Object? updatedAt = null,Object? columnId = freezed,Object? parentTaskId = freezed,Object? taskTypeId = freezed,Object? description = freezed,Object? cardBackgroundColor = freezed,Object? cardTextColor = freezed,Object? depth = null,Object? status = null,Object? priority = null,Object? assigneeName = freezed,Object? labels = null,Object? startDate = freezed,Object? dueDate = freezed,Object? completedAt = freezed,Object? estimatedDurationMinutes = freezed,Object? actualDurationMinutes = freezed,Object? periodType = null,Object? isCompleted = null,Object? deletedAt = freezed,}) {
  return _then(_TaskDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,columnId: freezed == columnId ? _self.columnId : columnId // ignore: cast_nullable_to_non_nullable
as String?,parentTaskId: freezed == parentTaskId ? _self.parentTaskId : parentTaskId // ignore: cast_nullable_to_non_nullable
as String?,taskTypeId: freezed == taskTypeId ? _self.taskTypeId : taskTypeId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cardBackgroundColor: freezed == cardBackgroundColor ? _self.cardBackgroundColor : cardBackgroundColor // ignore: cast_nullable_to_non_nullable
as String?,cardTextColor: freezed == cardTextColor ? _self.cardTextColor : cardTextColor // ignore: cast_nullable_to_non_nullable
as String?,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,assigneeName: freezed == assigneeName ? _self.assigneeName : assigneeName // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,estimatedDurationMinutes: freezed == estimatedDurationMinutes ? _self.estimatedDurationMinutes : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,actualDurationMinutes: freezed == actualDurationMinutes ? _self.actualDurationMinutes : actualDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
