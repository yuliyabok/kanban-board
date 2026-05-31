import 'package:flutter/material.dart';

class MyTasksFilter extends StatelessWidget {
  const MyTasksFilter({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      onSelected: onSelected,
      label: const Text('Мои задачи'),
      avatar: const Icon(Icons.assignment_ind_outlined),
    );
  }
}
