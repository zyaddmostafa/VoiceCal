import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'editable_value_field.dart';

/// Content section displaying the goal title and editable value
class GoalContent extends StatelessWidget {
  const GoalContent({
    super.key,
    required this.title,
    required this.value,
    required this.isEditing,
    required this.controller,
    required this.focusNode,
    required this.progressColor,
    required this.labelSpacing,
    required this.onSubmitted,
  });

  final String title;
  final String value;
  final bool isEditing;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color progressColor;
  final double labelSpacing;
  final VoidCallback onSubmitted;

  static final _valueStyle = AppTextStyles.headingLarge.copyWith(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: labelSpacing),
        isEditing
            ? EditableValueField(
                controller: controller,
                focusNode: focusNode,
                progressColor: progressColor,
                valueStyle: _valueStyle,
                onSubmitted: onSubmitted,
              )
            : Text(value, style: _valueStyle),
      ],
    );
  }
}
