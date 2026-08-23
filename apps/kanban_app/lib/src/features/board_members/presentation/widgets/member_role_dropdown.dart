import 'package:flutter/material.dart';

import '../../../permissions/domain/entities/permission.dart';

class MemberRoleDropdown extends StatelessWidget {
  const MemberRoleDropdown({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final BoardRole value;
  final ValueChanged<BoardRole?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<BoardRole>(
      value: value,
      items: [
        for (final role in BoardRole.values)
          DropdownMenuItem(value: role, child: Text(role.name)),
      ],
      onChanged: onChanged,
    );
  }
}
