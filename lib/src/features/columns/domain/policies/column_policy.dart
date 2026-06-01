import '../../../../core/error/failure.dart';

final class ColumnPolicy {
  const ColumnPolicy._();

  static Failure? validateTitle(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      return const ValidationFailure('Название не может быть пустым');
    }
    if (trimmed.length > 50) {
      return const ValidationFailure('Максимум 50 символов');
    }
    return null;
  }

  static List<T> normalizePositions<T>(
    List<T> columns,
    T Function(T column, int position) copyWithPosition,
  ) {
    return [
      for (var index = 0; index < columns.length; index++)
        copyWithPosition(columns[index], index),
    ];
  }
}
