import 'package:flutter/material.dart';

import '../../domain/entities/board_member_entity.dart';

class MemberAvatarStack extends StatelessWidget {
  const MemberAvatarStack({required this.members, super.key});

  final List<BoardMemberEntity> members;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (members.take(4).length * 22 + 8).toDouble(),
      height: 32,
      child: Stack(
        children: [
          for (final indexed in members.take(4).indexed)
            Positioned(
              left: indexed.$1 * 22,
              child: Tooltip(
                message: indexed.$2.userId,
                child: CircleAvatar(
                  radius: 14,
                  child: Text(indexed.$2.userId.characters.first.toUpperCase()),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
