import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'number_formatter.dart';

class GoalInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback? onChanged;

  const GoalInputField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        ThousandsSeparatorFormatter(),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: '0',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r)),
      ),
      onChanged: (_) => onChanged?.call(),
    );
  }
}
