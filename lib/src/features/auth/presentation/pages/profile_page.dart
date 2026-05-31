import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/ui/app_back_button.dart';
import '../../../users/presentation/providers/user_providers.dart';
import '../../../users/presentation/widgets/user_profile_form.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Профиль'),
      ),
      body: Center(
        child: userState.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text(error.toString()),
          data: (user) {
            if (user == null) return const Text('Пользователь не найден');
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: UserProfileForm(user: user, compact: true),
            );
          },
        ),
      ),
    );
  }
}
