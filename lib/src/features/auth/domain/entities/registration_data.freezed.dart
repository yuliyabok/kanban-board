// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationData {

 String get email; String get password; String? get displayName;
/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationDataCopyWith<RegistrationData> get copyWith => _$RegistrationDataCopyWithImpl<RegistrationData>(this as RegistrationData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationData&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,displayName);

@override
String toString() {
  return 'RegistrationData(email: $email, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $RegistrationDataCopyWith<$Res>  {
  factory $RegistrationDataCopyWith(RegistrationData value, $Res Function(RegistrationData) _then) = _$RegistrationDataCopyWithImpl;
@useResult
$Res call({
 String email, String password, String? displayName
});




}
/// @nodoc
class _$RegistrationDataCopyWithImpl<$Res>
    implements $RegistrationDataCopyWith<$Res> {
  _$RegistrationDataCopyWithImpl(this._self, this._then);

  final RegistrationData _self;
  final $Res Function(RegistrationData) _then;

/// Create a copy of RegistrationData
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


/// Adds pattern-matching-related methods to [RegistrationData].
extension RegistrationDataPatterns on RegistrationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationData value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationData value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationData() when $default != null:
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
case _RegistrationData() when $default != null:
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
case _RegistrationData():
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
case _RegistrationData() when $default != null:
return $default(_that.email,_that.password,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc


class _RegistrationData implements RegistrationData {
  const _RegistrationData({required this.email, required this.password, this.displayName});
  

@override final  String email;
@override final  String password;
@override final  String? displayName;

/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationDataCopyWith<_RegistrationData> get copyWith => __$RegistrationDataCopyWithImpl<_RegistrationData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationData&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,displayName);

@override
String toString() {
  return 'RegistrationData(email: $email, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$RegistrationDataCopyWith<$Res> implements $RegistrationDataCopyWith<$Res> {
  factory _$RegistrationDataCopyWith(_RegistrationData value, $Res Function(_RegistrationData) _then) = __$RegistrationDataCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String? displayName
});




}
/// @nodoc
class __$RegistrationDataCopyWithImpl<$Res>
    implements _$RegistrationDataCopyWith<$Res> {
  __$RegistrationDataCopyWithImpl(this._self, this._then);

  final _RegistrationData _self;
  final $Res Function(_RegistrationData) _then;

/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? displayName = freezed,}) {
  return _then(_RegistrationData(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
