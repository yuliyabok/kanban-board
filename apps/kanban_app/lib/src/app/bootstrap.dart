import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../core/providers/core_providers.dart';
import 'app.dart';

Future<void> bootstrap() async {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      _configureLogging();

      runApp(
        const ProviderScope(
          observers: [AppProviderObserver()],
          child: KanbanApp(),
        ),
      );
    },
    (error, stackTrace) {
      Logger('bootstrap').severe('Uncaught app error', error, stackTrace);
    },
  );
}

void _configureLogging() {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '${record.level.name} ${record.loggerName}: ${record.message}',
    );
  });
}
