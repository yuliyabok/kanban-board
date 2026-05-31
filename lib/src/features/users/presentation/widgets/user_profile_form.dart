import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import '../providers/user_providers.dart';

class UserProfileForm extends ConsumerStatefulWidget {
  const UserProfileForm({
    required this.user,
    this.compact = false,
    super.key,
  });

  final UserEntity user;
  final bool compact;

  @override
  ConsumerState<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends ConsumerState<UserProfileForm> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _positionController;
  late final TextEditingController _avatarUrlController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user.fullName);
    _positionController = TextEditingController(text: widget.user.position);
    _avatarUrlController = TextEditingController(text: widget.user.avatarUrl);
  }

  @override
  void didUpdateWidget(UserProfileForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user.id != widget.user.id ||
        oldWidget.user.updatedAt != widget.user.updatedAt) {
      _fullNameController.text = widget.user.fullName;
      _positionController.text = widget.user.position ?? '';
      _avatarUrlController.text = widget.user.avatarUrl ?? '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _positionController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProfileControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final initials = widget.user.fullName.trim().isEmpty
        ? '?'
        : widget.user.fullName.trim().characters.first.toUpperCase();

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.compact ? 520 : 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  initials,
                  style: TextStyle(color: colorScheme.onPrimaryContainer),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.email,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.user.position?.trim().isNotEmpty ?? false
                          ? widget.user.position!
                          : 'Должность не указана',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _fullNameController,
            autofillHints: const [AutofillHints.name],
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Имя',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _positionController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Должность',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.badge_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _avatarUrlController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Avatar URL',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.image_outlined),
            ),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: state.isLoading ? null : _save,
              icon: state.isLoading
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: const Text('Сохранить профиль'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    await ref
        .read(userProfileControllerProvider.notifier)
        .saveProfile(
          widget.user.copyWith(
            fullName: _fullNameController.text,
            position: _positionController.text,
            avatarUrl: _avatarUrlController.text,
          ),
        );
    if (!mounted) return;

    final state = ref.read(userProfileControllerProvider);
    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error.toString())),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Профиль сохранен')),
    );
  }
}
