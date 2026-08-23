// Общий формат ошибки API: сервер возвращает его, а приложение может одинаково
// показывать/логировать ошибки из разных endpoints.
final class ApiErrorDto {
  const ApiErrorDto({
    required this.code,
    required this.message,
    this.details,
  });

  factory ApiErrorDto.fromJson(Map<String, dynamic> json) {
    return ApiErrorDto(
      code: json['code'] as String? ?? 'unknown_error',
      message: json['message'] as String? ?? 'Unknown error',
      details: json['details'] as Map<String, Object?>?,
    );
  }

  final String code;
  final String message;
  final Map<String, Object?>? details;

  Map<String, Object?> toJson() {
    return {
      'code': code,
      'message': message,
      if (details != null) 'details': details,
    };
  }
}
