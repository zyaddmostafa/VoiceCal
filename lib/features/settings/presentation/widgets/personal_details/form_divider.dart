import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 0.5, color: AppColors.border);
  }
}
