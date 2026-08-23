import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.onSubmitted,
    this.onChanged,
    this.autofocus = false,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: maxLines == 1 ? TextInputAction.done : null,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
        counterText: maxLength == null ? null : '',
      ),
      onSubmitted: onSubmitted,
      onChanged: onChanged,
    );
  }
}
