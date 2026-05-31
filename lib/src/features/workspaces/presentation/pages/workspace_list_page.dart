import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/ui/app_back_button.dart';
import '../providers/workspace_providers.dart';

class WorkspaceListPage extends ConsumerWidget {
  const WorkspaceListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workspacesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Рабочие пространства'),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (workspaces) => ListView.builder(
          itemCount: workspaces.length,
          itemBuilder: (context, index) {
            final workspace = workspaces[index];
            return ListTile(
              title: Text(workspace.name),
              subtitle: Text(workspace.ownerId),
              onTap: () {
                ref.read(selectedWorkspaceProvider.notifier).selected =
                    workspace.id;
                Navigator.of(context).maybePop();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = TextEditingController();
          final create = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Создать workspace'),
              content: TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Отмена'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Создать'),
                ),
              ],
            ),
          );
          if (create ?? false) {
            await ref
                .read(workspaceControllerProvider.notifier)
                .create(controller.text);
          }
          controller.dispose();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
