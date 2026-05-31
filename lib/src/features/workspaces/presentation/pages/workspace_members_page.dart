import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/ui/app_back_button.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../providers/workspace_providers.dart';
import '../widgets/invite_workspace_member_dialog.dart';

class WorkspaceMembersPage extends ConsumerWidget {
  const WorkspaceMembersPage({required this.workspaceId, super.key});

  final String workspaceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workspaceMembersProvider(workspaceId));
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Участники workspace'),
        actions: [
          IconButton(
            tooltip: 'Пригласить',
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) =>
                  InviteWorkspaceMemberDialog(workspaceId: workspaceId),
            ),
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (members) => ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_outline)),
              title: Text(member.userId),
              trailing: DropdownButton<WorkspaceRole>(
                value: member.role,
                items: [
                  for (final role in WorkspaceRole.values)
                    DropdownMenuItem(value: role, child: Text(role.name)),
                ],
                onChanged: (_) {},
              ),
            );
          },
        ),
      ),
    );
  }
}
