import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/layout/app_shell.dart';
import '../../../../../core/theme/theme_controller.dart';
import '../../../../app/routing/app_routes.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../users/presentation/providers/user_providers.dart';
import '../../../users/presentation/widgets/user_profile_form.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppShell(
      title: 'Настройки',
      subtitle: 'Профиль, аккаунт и рабочее пространство',
      actions: [
        AppShellAction(
          label: 'Назад',
          icon: Icons.arrow_back_rounded,
          pinOnMobile: true,
          onPressed: () => _goBack(context),
        ),
        AppShellAction(
          label: 'Выйти',
          icon: Icons.logout_rounded,
          onPressed: () {
            unawaited(ref.read(authControllerProvider.notifier).signOut());
          },
        ),
      ],
      content: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: ListView(
              padding: EdgeInsets.all(context.spacing.xl),
              children: const [
                _ProfileSettingsSection(),
                SizedBox(height: 18),
                _WorkspaceSettingsSection(),
                SizedBox(height: 18),
                _AppSettingsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSettingsSection extends ConsumerWidget {
  const _ProfileSettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(currentUserProvider);
    return _SettingsSection(
      icon: Icons.account_circle_outlined,
      title: 'Профиль',
      child: userState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Text(error.toString()),
        data: (user) {
          if (user == null) return const Text('Пользователь не найден');
          return UserProfileForm(user: user);
        },
      ),
    );
  }
}

class _WorkspaceSettingsSection extends StatelessWidget {
  const _WorkspaceSettingsSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsSection(
      icon: Icons.workspaces_outline,
      title: 'Команда',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          OutlinedButton.icon(
            onPressed: () => context.pushNamed(AppRoute.workspaces.name),
            icon: const Icon(Icons.business_outlined),
            label: const Text('Рабочие пространства'),
          ),
          OutlinedButton.icon(
            onPressed: () => context.pushNamed(AppRoute.invitations.name),
            icon: const Icon(Icons.mark_email_unread_outlined),
            label: const Text('Приглашения'),
          ),
        ],
      ),
    );
  }
}

void _goBack(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
    return;
  }
  context.go(AppRoute.boards.path);
}

class _AppSettingsSection extends ConsumerWidget {
  const _AppSettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    return _SettingsSection(
      icon: Icons.tune_outlined,
      title: 'Приложение',
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        value: themeMode == ThemeMode.dark,
        onChanged: (_) {
          ref.read(themeControllerProvider.notifier).toggleLightDark();
        },
        title: const Text('Темная тема'),
        secondary: const Icon(Icons.dark_mode_outlined),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.card,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary),
                SizedBox(width: context.spacing.sm),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            SizedBox(height: context.spacing.lg),
            child,
          ],
        ),
      ),
    );
  }
}
