import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_data.freezed.dart';

@freezed
abstract class RegistrationData with _$RegistrationData {
  const factory RegistrationData({
    required String email,
    required String password,
    String? displayName,
  }) = _RegistrationData;
}
