sealed class AppException implements Exception {
  const AppException(this.message, {this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => message;
}

final class NetworkException extends AppException {
  const NetworkException(super.message, {super.cause, super.stackTrace});
}

final class LocalStorageException extends AppException {
  const LocalStorageException(super.message, {super.cause, super.stackTrace});
}

final class ValidationException extends AppException {
  const ValidationException(super.message, {super.cause, super.stackTrace});
}

final class UnexpectedException extends AppException {
  const UnexpectedException(super.message, {super.cause, super.stackTrace});
}
