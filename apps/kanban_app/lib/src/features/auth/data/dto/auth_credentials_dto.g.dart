// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthCredentialsDto _$AuthCredentialsDtoFromJson(Map<String, dynamic> json) =>
    _AuthCredentialsDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthCredentialsDtoToJson(_AuthCredentialsDto instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
