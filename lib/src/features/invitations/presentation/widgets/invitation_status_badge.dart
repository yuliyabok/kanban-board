import 'package:flutter/material.dart';

import '../../domain/entities/invitation_entity.dart';

class InvitationStatusBadge extends StatelessWidget {
  const InvitationStatusBadge({required this.invitation, super.key});

  final InvitationEntity invitation;

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      label: Text(invitation.status.name),
    );
  }
}
