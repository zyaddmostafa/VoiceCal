import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';

class EditGoalHeader extends StatelessWidget {
  final String label;

  const EditGoalHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text('Edit $label Goal', style: AppTextStyles.font32BoldPrimary);
  }
}
