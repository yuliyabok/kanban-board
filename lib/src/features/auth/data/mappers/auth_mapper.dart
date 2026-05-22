import '../../domain/entities/auth_credentials.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/registration_data.dart';
import '../dto/auth_credentials_dto.dart';
import '../dto/registration_dto.dart';
import '../dto/auth_session_dto.dart';

extension AuthSessionDtoMapper on AuthSessionDto {
  AuthSession toEntity() {
    return AuthSession(
      userId: userId,
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
    );
  }
}

extension AuthSessionEntityMapper on AuthSession {
  AuthSessionDto toDto() {
    return AuthSessionDto(
      userId: userId,
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
    );
  }
}

extension AuthCredentialsMapper on AuthCredentials {
  AuthCredentialsDto toDto() {
    return AuthCredentialsDto(
      email: email,
      password: password,
    );
  }
}

extension RegistrationDataMapper on RegistrationData {
  RegistrationDto toDto() {
    return RegistrationDto(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
