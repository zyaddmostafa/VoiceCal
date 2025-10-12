import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class GoalSelector extends StatelessWidget {
  final String? goal;
  final String? currentGoal;
  final ValueChanged<String?> onChanged;

  const GoalSelector({
    super.key,
    required this.goal,
    this.currentGoal,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Goal',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          horizontalSpace(16),
          Expanded(
            flex: 3,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: goal,
                hint: Text(
                  currentGoal ?? 'Select goal',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                ),
                isExpanded: true,
                items: ['lose_weight', 'maintain_weight', 'gain_weight']
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          value.replaceAll('_', ' ').toUpperCase(),
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
                alignment: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
