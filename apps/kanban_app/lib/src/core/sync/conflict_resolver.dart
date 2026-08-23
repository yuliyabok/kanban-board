// Политика разрешения конфликтов синхронизации. Здесь решается, чья версия
// данных победит, если локальные и серверные изменения столкнулись.
enum ConflictResolution {
  keepLocal,
  keepRemote,
  merge,
}

abstract interface class ConflictResolver<T> {
  ConflictResolution resolve({
    required T local,
    required T remote,
  });
}

final class LastWriteWinsConflictResolver<T extends Object>
    implements ConflictResolver<T> {
  const LastWriteWinsConflictResolver();

  @override
  ConflictResolution resolve({
    required T local,
    required T remote,
  }) {
    return ConflictResolution.keepRemote;
  }
}
