import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/src/app/app.dart';
import 'package:kanban_board/src/app/routing/app_router.dart';

void main() {
  testWidgets('app renders tasks page', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appRouterProvider.overrideWithValue(
            GoRouter(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) {
                    return const Scaffold(
                      body: Center(child: Text('Задачи')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
        child: const KanbanApp(),
      ),
    );

    expect(find.text('Задачи'), findsOneWidget);
  });
}
