// Guards the monorepo boundary: app and server share contracts, not internals.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app does not import kanban_server internals', () {
    final offenders = _dartFiles(Directory.current)
        .where((file) => file.path.endsWith('.dart'))
        .where((file) => _importsPackage(file, 'kanban_server'))
        .map((file) => file.path)
        .toList(growable: false);

    expect(offenders, isEmpty);
  });

  test('server does not import kanban_board internals', () {
    final serverDir = Directory('../kanban_server');
    final offenders = _dartFiles(serverDir)
        .where((file) => _importsPackage(file, 'kanban_board'))
        .map((file) => file.path)
        .toList(growable: false);

    expect(offenders, isEmpty);
  });

  test('app and server both depend on kanban_contracts', () {
    final appPubspec = File('pubspec.yaml').readAsStringSync();
    final serverPubspec = File(
      '../kanban_server/pubspec.yaml',
    ).readAsStringSync();

    expect(appPubspec, contains('kanban_contracts:'));
    expect(appPubspec, contains('../../packages/kanban_contracts'));
    expect(serverPubspec, contains('kanban_contracts:'));
    expect(serverPubspec, contains('../../packages/kanban_contracts'));
  });
}

bool _importsPackage(File file, String packageName) {
  final importPattern = RegExp(
    '^\\s*(import|export)\\s+[\\\'"]package:${RegExp.escape(packageName)}/',
    multiLine: true,
  );
  return importPattern.hasMatch(file.readAsStringSync());
}

Iterable<File> _dartFiles(Directory directory) {
  return directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where(
        (file) => !file.path.contains(
          '${Platform.pathSeparator}.dart_tool${Platform.pathSeparator}',
        ),
      )
      .where(
        (file) => !file.path.contains(
          '${Platform.pathSeparator}build${Platform.pathSeparator}',
        ),
      );
}
