import 'package:flutter/material.dart';

import '../../../domain/value_objects/task_enums.dart';

class TaskPeriodPicker extends StatelessWidget {
  const TaskPeriodPicker({
    required this.periodType,
    required this.onChanged,
    super.key,
  });

  final TaskPeriodType periodType;
  final ValueChanged<TaskPeriodType> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TaskPeriodType>(
      initialValue: periodType,
      decoration: const InputDecoration(labelText: 'Период'),
      items: TaskPeriodType.values
          .map(
            (value) => DropdownMenuItem(value: value, child: Text(value.name)),
          )
          .toList(growable: false),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
