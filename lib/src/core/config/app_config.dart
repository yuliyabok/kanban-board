class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.webSocketUrl,
    required this.databaseName,
  });

  factory AppConfig.development() {
    return const AppConfig(
      apiBaseUrl: 'https://api.example.local',
      webSocketUrl: 'wss://api.example.local/realtime',
      databaseName: 'kanban_board',
    );
  }

  final String apiBaseUrl;
  final String webSocketUrl;
  final String databaseName;
}
