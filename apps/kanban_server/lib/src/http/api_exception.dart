// Исключение для ожидаемых HTTP-ошибок API: status code + code/message в
// стандартном ApiErrorDto.
final class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.code,
    required this.message,
  });

  final int statusCode;
  final String code;
  final String message;
}
