import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_icons.dart';
import '../../../../../core/helpers/custom_bottom_sheets.dart';
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
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showActivityPicker(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      activityLevel?.replaceAll('_', ' ').toUpperCase() ??
                          currentActivityLevel ??
                          'Select activity',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: activityLevel != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    AppIcons.chevronDown,
                    size: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showActivityPicker(BuildContext context) async {
    final activities = [
      'sedentary',
      'lightly_active',
      'moderately_active',
      'very_active',
      'extra_active',
    ];

    final initialIndex = activityLevel != null
        ? activities.indexOf(activityLevel!)
        : 0;

    final selectedActivity = await CustomBottomSheets.showPicker(
      context: context,
      items: activities,
      initialIndex: initialIndex,
      itemBuilder: (value) => value.replaceAll('_', ' ').toUpperCase(),
    );

    if (selectedActivity != null) {
      onChanged(selectedActivity);
    }
  }
}
