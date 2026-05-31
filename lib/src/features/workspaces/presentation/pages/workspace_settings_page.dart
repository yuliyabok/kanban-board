import 'package:flutter/material.dart';

import '../../../../shared/ui/app_back_button.dart';
import 'workspace_members_page.dart';

class WorkspaceSettingsPage extends StatelessWidget {
  const WorkspaceSettingsPage({required this.workspaceId, super.key});

  final String workspaceId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Настройки workspace'),
      ),
      body: WorkspaceMembersPage(workspaceId: workspaceId),
    );
  }
}
