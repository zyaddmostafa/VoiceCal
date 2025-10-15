import 'package:flutter/cupertino.dart';
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
                    CupertinoIcons.chevron_down,
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

  void _showActivityPicker(BuildContext context) {
    final activities = [
      'sedentary',
      'lightly_active',
      'moderately_active',
      'very_active',
      'extra_active',
    ];

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250.h,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            Container(
              height: 44.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Done',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: CupertinoColors.systemBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 32.h,
                scrollController: FixedExtentScrollController(
                  initialItem: activityLevel != null
                      ? activities.indexOf(activityLevel!)
                      : 0,
                ),
                onSelectedItemChanged: (int index) {
                  onChanged(activities[index]);
                },
                children: activities
                    .map(
                      (activity) => Center(
                        child: Text(
                          activity.replaceAll('_', ' ').toUpperCase(),
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
