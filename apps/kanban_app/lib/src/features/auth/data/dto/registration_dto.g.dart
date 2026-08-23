// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegistrationDto _$RegistrationDtoFromJson(Map<String, dynamic> json) =>
    _RegistrationDto(
      email: json['email'] as String,
      password: json['password'] as String,
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$RegistrationDtoToJson(_RegistrationDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'displayName': instance.displayName,
    };
