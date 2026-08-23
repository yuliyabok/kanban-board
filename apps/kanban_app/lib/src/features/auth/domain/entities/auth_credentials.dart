import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credentials.freezed.dart';

@Freezed(toStringOverride: false)
abstract class AuthCredentials with _$AuthCredentials {
  const factory AuthCredentials({
    required String email,
    required String password,
  }) = _AuthCredentials;
}
