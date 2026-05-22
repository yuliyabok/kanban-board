import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credentials.freezed.dart';

@freezed
abstract class AuthCredentials with _$AuthCredentials {
  const factory AuthCredentials({
    required String email,
    required String password,
  }) = _AuthCredentials;
}
