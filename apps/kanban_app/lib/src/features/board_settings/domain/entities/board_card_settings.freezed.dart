// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_card_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardCardSettings {

 String get boardId; DateTime get updatedAt; bool get showDescription; bool get showTaskType; bool get showPeriod; bool get showSubtaskProgress; bool get showPriority; bool get showAssignee; bool get showLabels; bool get showCreatedAt; bool get showQuickActions; TaskCardDensity get density; TaskCardStyle get style; TaskTypeBadgePlacement get typeBadgePlacement; TaskTypeColorMode get typeColorMode; String get cardBackgroundColor; String get columnBackgroundColor;
/// Create a copy of BoardCardSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardCardSettingsCopyWith<BoardCardSettings> get copyWith => _$BoardCardSettingsCopyWithImpl<BoardCardSettings>(this as BoardCardSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardCardSettings&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.showDescription, showDescription) || other.showDescription == showDescription)&&(identical(other.showTaskType, showTaskType) || other.showTaskType == showTaskType)&&(identical(other.showPeriod, showPeriod) || other.showPeriod == showPeriod)&&(identical(other.showSubtaskProgress, showSubtaskProgress) || other.showSubtaskProgress == showSubtaskProgress)&&(identical(other.showPriority, showPriority) || other.showPriority == showPriority)&&(identical(other.showAssignee, showAssignee) || other.showAssignee == showAssignee)&&(identical(other.showLabels, showLabels) || other.showLabels == showLabels)&&(identical(other.showCreatedAt, showCreatedAt) || other.showCreatedAt == showCreatedAt)&&(identical(other.showQuickActions, showQuickActions) || other.showQuickActions == showQuickActions)&&(identical(other.density, density) || other.density == density)&&(identical(other.style, style) || other.style == style)&&(identical(other.typeBadgePlacement, typeBadgePlacement) || other.typeBadgePlacement == typeBadgePlacement)&&(identical(other.typeColorMode, typeColorMode) || other.typeColorMode == typeColorMode)&&(identical(other.cardBackgroundColor, cardBackgroundColor) || other.cardBackgroundColor == cardBackgroundColor)&&(identical(other.columnBackgroundColor, columnBackgroundColor) || other.columnBackgroundColor == columnBackgroundColor));
}


@override
int get hashCode => Object.hash(runtimeType,boardId,updatedAt,showDescription,showTaskType,showPeriod,showSubtaskProgress,showPriority,showAssignee,showLabels,showCreatedAt,showQuickActions,density,style,typeBadgePlacement,typeColorMode,cardBackgroundColor,columnBackgroundColor);

@override
String toString() {
  return 'BoardCardSettings(boardId: $boardId, updatedAt: $updatedAt, showDescription: $showDescription, showTaskType: $showTaskType, showPeriod: $showPeriod, showSubtaskProgress: $showSubtaskProgress, showPriority: $showPriority, showAssignee: $showAssignee, showLabels: $showLabels, showCreatedAt: $showCreatedAt, showQuickActions: $showQuickActions, density: $density, style: $style, typeBadgePlacement: $typeBadgePlacement, typeColorMode: $typeColorMode, cardBackgroundColor: $cardBackgroundColor, columnBackgroundColor: $columnBackgroundColor)';
}


}

/// @nodoc
abstract mixin class $BoardCardSettingsCopyWith<$Res>  {
  factory $BoardCardSettingsCopyWith(BoardCardSettings value, $Res Function(BoardCardSettings) _then) = _$BoardCardSettingsCopyWithImpl;
@useResult
$Res call({
 String boardId, DateTime updatedAt, bool showDescription, bool showTaskType, bool showPeriod, bool showSubtaskProgress, bool showPriority, bool showAssignee, bool showLabels, bool showCreatedAt, bool showQuickActions, TaskCardDensity density, TaskCardStyle style, TaskTypeBadgePlacement typeBadgePlacement, TaskTypeColorMode typeColorMode, String cardBackgroundColor, String columnBackgroundColor
});




}
/// @nodoc
class _$BoardCardSettingsCopyWithImpl<$Res>
    implements $BoardCardSettingsCopyWith<$Res> {
  _$BoardCardSettingsCopyWithImpl(this._self, this._then);

  final BoardCardSettings _self;
  final $Res Function(BoardCardSettings) _then;

/// Create a copy of BoardCardSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? boardId = null,Object? updatedAt = null,Object? showDescription = null,Object? showTaskType = null,Object? showPeriod = null,Object? showSubtaskProgress = null,Object? showPriority = null,Object? showAssignee = null,Object? showLabels = null,Object? showCreatedAt = null,Object? showQuickActions = null,Object? density = null,Object? style = null,Object? typeBadgePlacement = null,Object? typeColorMode = null,Object? cardBackgroundColor = null,Object? columnBackgroundColor = null,}) {
  return _then(_self.copyWith(
boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,showDescription: null == showDescription ? _self.showDescription : showDescription // ignore: cast_nullable_to_non_nullable
as bool,showTaskType: null == showTaskType ? _self.showTaskType : showTaskType // ignore: cast_nullable_to_non_nullable
as bool,showPeriod: null == showPeriod ? _self.showPeriod : showPeriod // ignore: cast_nullable_to_non_nullable
as bool,showSubtaskProgress: null == showSubtaskProgress ? _self.showSubtaskProgress : showSubtaskProgress // ignore: cast_nullable_to_non_nullable
as bool,showPriority: null == showPriority ? _self.showPriority : showPriority // ignore: cast_nullable_to_non_nullable
as bool,showAssignee: null == showAssignee ? _self.showAssignee : showAssignee // ignore: cast_nullable_to_non_nullable
as bool,showLabels: null == showLabels ? _self.showLabels : showLabels // ignore: cast_nullable_to_non_nullable
as bool,showCreatedAt: null == showCreatedAt ? _self.showCreatedAt : showCreatedAt // ignore: cast_nullable_to_non_nullable
as bool,showQuickActions: null == showQuickActions ? _self.showQuickActions : showQuickActions // ignore: cast_nullable_to_non_nullable
as bool,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as TaskCardDensity,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as TaskCardStyle,typeBadgePlacement: null == typeBadgePlacement ? _self.typeBadgePlacement : typeBadgePlacement // ignore: cast_nullable_to_non_nullable
as TaskTypeBadgePlacement,typeColorMode: null == typeColorMode ? _self.typeColorMode : typeColorMode // ignore: cast_nullable_to_non_nullable
as TaskTypeColorMode,cardBackgroundColor: null == cardBackgroundColor ? _self.cardBackgroundColor : cardBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,columnBackgroundColor: null == columnBackgroundColor ? _self.columnBackgroundColor : columnBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardCardSettings].
extension BoardCardSettingsPatterns on BoardCardSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardCardSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardCardSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardCardSettings value)  $default,){
final _that = this;
switch (_that) {
case _BoardCardSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardCardSettings value)?  $default,){
final _that = this;
switch (_that) {
case _BoardCardSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String boardId,  DateTime updatedAt,  bool showDescription,  bool showTaskType,  bool showPeriod,  bool showSubtaskProgress,  bool showPriority,  bool showAssignee,  bool showLabels,  bool showCreatedAt,  bool showQuickActions,  TaskCardDensity density,  TaskCardStyle style,  TaskTypeBadgePlacement typeBadgePlacement,  TaskTypeColorMode typeColorMode,  String cardBackgroundColor,  String columnBackgroundColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardCardSettings() when $default != null:
return $default(_that.boardId,_that.updatedAt,_that.showDescription,_that.showTaskType,_that.showPeriod,_that.showSubtaskProgress,_that.showPriority,_that.showAssignee,_that.showLabels,_that.showCreatedAt,_that.showQuickActions,_that.density,_that.style,_that.typeBadgePlacement,_that.typeColorMode,_that.cardBackgroundColor,_that.columnBackgroundColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String boardId,  DateTime updatedAt,  bool showDescription,  bool showTaskType,  bool showPeriod,  bool showSubtaskProgress,  bool showPriority,  bool showAssignee,  bool showLabels,  bool showCreatedAt,  bool showQuickActions,  TaskCardDensity density,  TaskCardStyle style,  TaskTypeBadgePlacement typeBadgePlacement,  TaskTypeColorMode typeColorMode,  String cardBackgroundColor,  String columnBackgroundColor)  $default,) {final _that = this;
switch (_that) {
case _BoardCardSettings():
return $default(_that.boardId,_that.updatedAt,_that.showDescription,_that.showTaskType,_that.showPeriod,_that.showSubtaskProgress,_that.showPriority,_that.showAssignee,_that.showLabels,_that.showCreatedAt,_that.showQuickActions,_that.density,_that.style,_that.typeBadgePlacement,_that.typeColorMode,_that.cardBackgroundColor,_that.columnBackgroundColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String boardId,  DateTime updatedAt,  bool showDescription,  bool showTaskType,  bool showPeriod,  bool showSubtaskProgress,  bool showPriority,  bool showAssignee,  bool showLabels,  bool showCreatedAt,  bool showQuickActions,  TaskCardDensity density,  TaskCardStyle style,  TaskTypeBadgePlacement typeBadgePlacement,  TaskTypeColorMode typeColorMode,  String cardBackgroundColor,  String columnBackgroundColor)?  $default,) {final _that = this;
switch (_that) {
case _BoardCardSettings() when $default != null:
return $default(_that.boardId,_that.updatedAt,_that.showDescription,_that.showTaskType,_that.showPeriod,_that.showSubtaskProgress,_that.showPriority,_that.showAssignee,_that.showLabels,_that.showCreatedAt,_that.showQuickActions,_that.density,_that.style,_that.typeBadgePlacement,_that.typeColorMode,_that.cardBackgroundColor,_that.columnBackgroundColor);case _:
  return null;

}
}

}

/// @nodoc


class _BoardCardSettings implements BoardCardSettings {
  const _BoardCardSettings({required this.boardId, required this.updatedAt, this.showDescription = true, this.showTaskType = true, this.showPeriod = true, this.showSubtaskProgress = true, this.showPriority = true, this.showAssignee = true, this.showLabels = true, this.showCreatedAt = false, this.showQuickActions = true, this.density = TaskCardDensity.compact, this.style = TaskCardStyle.bordered, this.typeBadgePlacement = TaskTypeBadgePlacement.top, this.typeColorMode = TaskTypeColorMode.smallDot, this.cardBackgroundColor = 'default', this.columnBackgroundColor = 'default'});
  

@override final  String boardId;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool showDescription;
@override@JsonKey() final  bool showTaskType;
@override@JsonKey() final  bool showPeriod;
@override@JsonKey() final  bool showSubtaskProgress;
@override@JsonKey() final  bool showPriority;
@override@JsonKey() final  bool showAssignee;
@override@JsonKey() final  bool showLabels;
@override@JsonKey() final  bool showCreatedAt;
@override@JsonKey() final  bool showQuickActions;
@override@JsonKey() final  TaskCardDensity density;
@override@JsonKey() final  TaskCardStyle style;
@override@JsonKey() final  TaskTypeBadgePlacement typeBadgePlacement;
@override@JsonKey() final  TaskTypeColorMode typeColorMode;
@override@JsonKey() final  String cardBackgroundColor;
@override@JsonKey() final  String columnBackgroundColor;

/// Create a copy of BoardCardSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardCardSettingsCopyWith<_BoardCardSettings> get copyWith => __$BoardCardSettingsCopyWithImpl<_BoardCardSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardCardSettings&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.showDescription, showDescription) || other.showDescription == showDescription)&&(identical(other.showTaskType, showTaskType) || other.showTaskType == showTaskType)&&(identical(other.showPeriod, showPeriod) || other.showPeriod == showPeriod)&&(identical(other.showSubtaskProgress, showSubtaskProgress) || other.showSubtaskProgress == showSubtaskProgress)&&(identical(other.showPriority, showPriority) || other.showPriority == showPriority)&&(identical(other.showAssignee, showAssignee) || other.showAssignee == showAssignee)&&(identical(other.showLabels, showLabels) || other.showLabels == showLabels)&&(identical(other.showCreatedAt, showCreatedAt) || other.showCreatedAt == showCreatedAt)&&(identical(other.showQuickActions, showQuickActions) || other.showQuickActions == showQuickActions)&&(identical(other.density, density) || other.density == density)&&(identical(other.style, style) || other.style == style)&&(identical(other.typeBadgePlacement, typeBadgePlacement) || other.typeBadgePlacement == typeBadgePlacement)&&(identical(other.typeColorMode, typeColorMode) || other.typeColorMode == typeColorMode)&&(identical(other.cardBackgroundColor, cardBackgroundColor) || other.cardBackgroundColor == cardBackgroundColor)&&(identical(other.columnBackgroundColor, columnBackgroundColor) || other.columnBackgroundColor == columnBackgroundColor));
}


@override
int get hashCode => Object.hash(runtimeType,boardId,updatedAt,showDescription,showTaskType,showPeriod,showSubtaskProgress,showPriority,showAssignee,showLabels,showCreatedAt,showQuickActions,density,style,typeBadgePlacement,typeColorMode,cardBackgroundColor,columnBackgroundColor);

@override
String toString() {
  return 'BoardCardSettings(boardId: $boardId, updatedAt: $updatedAt, showDescription: $showDescription, showTaskType: $showTaskType, showPeriod: $showPeriod, showSubtaskProgress: $showSubtaskProgress, showPriority: $showPriority, showAssignee: $showAssignee, showLabels: $showLabels, showCreatedAt: $showCreatedAt, showQuickActions: $showQuickActions, density: $density, style: $style, typeBadgePlacement: $typeBadgePlacement, typeColorMode: $typeColorMode, cardBackgroundColor: $cardBackgroundColor, columnBackgroundColor: $columnBackgroundColor)';
}


}

/// @nodoc
abstract mixin class _$BoardCardSettingsCopyWith<$Res> implements $BoardCardSettingsCopyWith<$Res> {
  factory _$BoardCardSettingsCopyWith(_BoardCardSettings value, $Res Function(_BoardCardSettings) _then) = __$BoardCardSettingsCopyWithImpl;
@override @useResult
$Res call({
 String boardId, DateTime updatedAt, bool showDescription, bool showTaskType, bool showPeriod, bool showSubtaskProgress, bool showPriority, bool showAssignee, bool showLabels, bool showCreatedAt, bool showQuickActions, TaskCardDensity density, TaskCardStyle style, TaskTypeBadgePlacement typeBadgePlacement, TaskTypeColorMode typeColorMode, String cardBackgroundColor, String columnBackgroundColor
});




}
/// @nodoc
class __$BoardCardSettingsCopyWithImpl<$Res>
    implements _$BoardCardSettingsCopyWith<$Res> {
  __$BoardCardSettingsCopyWithImpl(this._self, this._then);

  final _BoardCardSettings _self;
  final $Res Function(_BoardCardSettings) _then;

/// Create a copy of BoardCardSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? boardId = null,Object? updatedAt = null,Object? showDescription = null,Object? showTaskType = null,Object? showPeriod = null,Object? showSubtaskProgress = null,Object? showPriority = null,Object? showAssignee = null,Object? showLabels = null,Object? showCreatedAt = null,Object? showQuickActions = null,Object? density = null,Object? style = null,Object? typeBadgePlacement = null,Object? typeColorMode = null,Object? cardBackgroundColor = null,Object? columnBackgroundColor = null,}) {
  return _then(_BoardCardSettings(
boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,showDescription: null == showDescription ? _self.showDescription : showDescription // ignore: cast_nullable_to_non_nullable
as bool,showTaskType: null == showTaskType ? _self.showTaskType : showTaskType // ignore: cast_nullable_to_non_nullable
as bool,showPeriod: null == showPeriod ? _self.showPeriod : showPeriod // ignore: cast_nullable_to_non_nullable
as bool,showSubtaskProgress: null == showSubtaskProgress ? _self.showSubtaskProgress : showSubtaskProgress // ignore: cast_nullable_to_non_nullable
as bool,showPriority: null == showPriority ? _self.showPriority : showPriority // ignore: cast_nullable_to_non_nullable
as bool,showAssignee: null == showAssignee ? _self.showAssignee : showAssignee // ignore: cast_nullable_to_non_nullable
as bool,showLabels: null == showLabels ? _self.showLabels : showLabels // ignore: cast_nullable_to_non_nullable
as bool,showCreatedAt: null == showCreatedAt ? _self.showCreatedAt : showCreatedAt // ignore: cast_nullable_to_non_nullable
as bool,showQuickActions: null == showQuickActions ? _self.showQuickActions : showQuickActions // ignore: cast_nullable_to_non_nullable
as bool,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as TaskCardDensity,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as TaskCardStyle,typeBadgePlacement: null == typeBadgePlacement ? _self.typeBadgePlacement : typeBadgePlacement // ignore: cast_nullable_to_non_nullable
as TaskTypeBadgePlacement,typeColorMode: null == typeColorMode ? _self.typeColorMode : typeColorMode // ignore: cast_nullable_to_non_nullable
as TaskTypeColorMode,cardBackgroundColor: null == cardBackgroundColor ? _self.cardBackgroundColor : cardBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,columnBackgroundColor: null == columnBackgroundColor ? _self.columnBackgroundColor : columnBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
