import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/board_member_providers.dart';
import 'invite_board_member_dialog.dart';
import 'member_role_dropdown.dart';

class BoardMembersPanel extends ConsumerWidget {
  const BoardMembersPanel({required this.boardId, super.key});

  final String boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boardMembersProvider(boardId));
    return SizedBox(
      width: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Участники доски',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                tooltip: 'Пригласить',
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (context) =>
                      InviteBoardMemberDialog(boardId: boardId),
                ),
                icon: const Icon(Icons.person_add_alt),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text(error.toString()),
              data: (members) => ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(member.userId),
                    trailing: MemberRoleDropdown(
                      value: member.role,
                      onChanged: null,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
