// Центральная сборка инфраструктурных зависимостей Riverpod: конфиг, база,
// HTTP-клиент, secure storage, realtime и sync manager.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../config/app_config.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';
import '../storage/secure_storage.dart';
import '../sync/realtime_connection.dart';
import '../sync/realtime_service.dart';
import '../sync/sync_manager.dart';
import '../sync/sync_outbox.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final config = ref.watch(appConfigProvider);
  final database = AppDatabase.open(config.databaseName);
  ref.onDispose(database.close);
  return database;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return DioApiClient(ref.watch(appConfigProvider));
});

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return FlutterSecureStorageAdapter();
});

final realtimeConnectionProvider = Provider<RealtimeConnection>((ref) {
  final connection = WebSocketRealtimeConnection(ref.watch(appConfigProvider));
  ref.onDispose(connection.close);
  return connection;
});

final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  final config = ref.watch(appConfigProvider);
  if (config.usesServerRemote) {
    final service = WebSocketRealtimeService(
      ref.watch(realtimeConnectionProvider),
    );
    ref.onDispose(service.dispose);
    return service;
  }

  final service = MockRealtimeService();
  ref.onDispose(service.dispose);
  return service;
});

final syncOutboxProvider = Provider<SyncOutbox>((ref) {
  return DriftSyncOutbox(ref.watch(appDatabaseProvider));
});

final syncManagerProvider = Provider<SyncManager>((ref) {
  final connection = ref.watch(realtimeConnectionProvider);
  final config = ref.watch(appConfigProvider);
  final manager = LocalFirstSyncManager(
    database: ref.watch(appDatabaseProvider),
    apiClient: ref.watch(apiClientProvider),
    realtimeConnection: connection,
    syncOutbox: ref.watch(syncOutboxProvider),
    usesServerRemote: config.usesServerRemote,
  );
  ref.onDispose(manager.stop);
  return manager;
});

final class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  static final _logger = Logger('riverpod');

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    _logger.warning(
      'Provider ${context.provider.name ?? context.provider.runtimeType} '
      'failed',
      error,
      stackTrace,
    );
  }
}
