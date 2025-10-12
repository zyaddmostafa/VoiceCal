import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ActivityLevelSelector extends StatelessWidget {
  final String? activityLevel;
  final String? currentActivityLevel;
  final ValueChanged<String?> onChanged;

  const ActivityLevelSelector({
    super.key,
    required this.activityLevel,
    this.currentActivityLevel,
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
              'Activity',
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
                value: activityLevel,
                hint: Text(
                  currentActivityLevel ?? 'Select activity',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                ),
                isExpanded: true,
                items:
                    [
                          'sedentary',
                          'lightly_active',
                          'moderately_active',
                          'very_active',
                          'extra_active',
                        ]
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
