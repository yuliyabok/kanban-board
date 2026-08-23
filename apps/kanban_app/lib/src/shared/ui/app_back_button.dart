import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routing/app_routes.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Назад',
      onPressed: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          return;
        }
        context.go(AppRoute.boards.path);
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }
}
