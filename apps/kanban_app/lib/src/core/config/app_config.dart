// Глобальная конфигурация приложения: адрес API, WebSocket, имя локальной базы
// и режим работы remote-слоя (`local` для разработки или `server` для backend).
enum RemoteMode { local, server }

class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.webSocketUrl,
    required this.databaseName,
    required this.remoteMode,
  });

  factory AppConfig.development() {
    return const AppConfig(
      apiBaseUrl: 'https://api.example.local',
      webSocketUrl: 'wss://api.example.local/realtime',
      databaseName: 'kanban_board',
      remoteMode: RemoteMode.local,
    );
  }

  factory AppConfig.fromEnvironment() {
    const remoteModeValue = String.fromEnvironment(
      'KANBAN_REMOTE_MODE',
      defaultValue: 'local',
    );
    const apiBaseUrl = String.fromEnvironment(
      'KANBAN_API_BASE_URL',
      defaultValue: 'https://api.example.local',
    );
    const webSocketUrl = String.fromEnvironment(
      'KANBAN_WS_URL',
      defaultValue: 'wss://api.example.local/realtime',
    );
    const databaseName = String.fromEnvironment(
      'KANBAN_DATABASE_NAME',
      defaultValue: 'kanban_board',
    );

    return AppConfig(
      apiBaseUrl: apiBaseUrl,
      webSocketUrl: webSocketUrl,
      databaseName: databaseName,
      remoteMode: _parseRemoteMode(remoteModeValue),
    );
  }

  factory AppConfig.serverDevelopment() {
    return const AppConfig(
      apiBaseUrl: 'http://localhost:8080',
      webSocketUrl: 'ws://localhost:8080/realtime',
      databaseName: 'kanban_board',
      remoteMode: RemoteMode.server,
    );
  }

  final String apiBaseUrl;
  final String webSocketUrl;
  final String databaseName;
  final RemoteMode remoteMode;

  bool get usesServerRemote => remoteMode == RemoteMode.server;

  static RemoteMode _parseRemoteMode(String value) {
    return switch (value.trim().toLowerCase()) {
      'server' => RemoteMode.server,
      _ => RemoteMode.local,
    };
  }
}
