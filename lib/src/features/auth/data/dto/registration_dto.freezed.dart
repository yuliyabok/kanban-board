// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegistrationDto {

 String get email; String get password; String? get displayName;
/// Create a copy of RegistrationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationDtoCopyWith<RegistrationDto> get copyWith => _$RegistrationDtoCopyWithImpl<RegistrationDto>(this as RegistrationDto, _$identity);

  /// Serializes this RegistrationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,displayName);

@override
String toString() {
  return 'RegistrationDto(email: $email, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $RegistrationDtoCopyWith<$Res>  {
  factory $RegistrationDtoCopyWith(RegistrationDto value, $Res Function(RegistrationDto) _then) = _$RegistrationDtoCopyWithImpl;
@useResult
$Res call({
 String email, String password, String? displayName
});




}
/// @nodoc
class _$RegistrationDtoCopyWithImpl<$Res>
    implements $RegistrationDtoCopyWith<$Res> {
  _$RegistrationDtoCopyWithImpl(this._self, this._then);

  final RegistrationDto _self;
  final $Res Function(RegistrationDto) _then;

/// Create a copy of RegistrationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? displayName = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationDto].
extension RegistrationDtoPatterns on RegistrationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationDto value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationDto value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  String? displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationDto() when $default != null:
return $default(_that.email,_that.password,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  String? displayName)  $default,) {final _that = this;
switch (_that) {
case _RegistrationDto():
return $default(_that.email,_that.password,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  String? displayName)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationDto() when $default != null:
return $default(_that.email,_that.password,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegistrationDto implements RegistrationDto {
  const _RegistrationDto({required this.email, required this.password, this.displayName});
  factory _RegistrationDto.fromJson(Map<String, dynamic> json) => _$RegistrationDtoFromJson(json);

@override final  String email;
@override final  String password;
@override final  String? displayName;

/// Create a copy of RegistrationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationDtoCopyWith<_RegistrationDto> get copyWith => __$RegistrationDtoCopyWithImpl<_RegistrationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,displayName);

@override
String toString() {
  return 'RegistrationDto(email: $email, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$RegistrationDtoCopyWith<$Res> implements $RegistrationDtoCopyWith<$Res> {
  factory _$RegistrationDtoCopyWith(_RegistrationDto value, $Res Function(_RegistrationDto) _then) = __$RegistrationDtoCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String? displayName
});




}
/// @nodoc
class __$RegistrationDtoCopyWithImpl<$Res>
    implements _$RegistrationDtoCopyWith<$Res> {
  __$RegistrationDtoCopyWithImpl(this._self, this._then);

  final _RegistrationDto _self;
  final $Res Function(_RegistrationDto) _then;

/// Create a copy of RegistrationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? displayName = freezed,}) {
  return _then(_RegistrationDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
