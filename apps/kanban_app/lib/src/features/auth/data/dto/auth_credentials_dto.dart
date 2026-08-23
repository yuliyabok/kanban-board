import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credentials_dto.freezed.dart';
part 'auth_credentials_dto.g.dart';

@Freezed(toStringOverride: false)
abstract class AuthCredentialsDto with _$AuthCredentialsDto {
  const factory AuthCredentialsDto({
    required String email,
    required String password,
  }) = _AuthCredentialsDto;

  factory AuthCredentialsDto.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsDtoFromJson(json);
}
