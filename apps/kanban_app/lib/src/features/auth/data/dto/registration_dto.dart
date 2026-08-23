import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_dto.freezed.dart';
part 'registration_dto.g.dart';

@Freezed(toStringOverride: false)
abstract class RegistrationDto with _$RegistrationDto {
  const factory RegistrationDto({
    required String email,
    required String password,
    String? displayName,
  }) = _RegistrationDto;

  factory RegistrationDto.fromJson(Map<String, dynamic> json) =>
      _$RegistrationDtoFromJson(json);
}
