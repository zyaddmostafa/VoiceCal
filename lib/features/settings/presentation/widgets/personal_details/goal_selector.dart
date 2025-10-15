import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_icons.dart';
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
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showGoalPicker(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      goal?.replaceAll('_', ' ').toUpperCase() ??
                          currentGoal ??
                          'Select goal',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: goal != null
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

  void _showGoalPicker(BuildContext context) {
    final goals = ['lose_weight', 'maintain_weight', 'gain_weight'];

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
                  initialItem: goal != null ? goals.indexOf(goal!) : 0,
                ),
                onSelectedItemChanged: (int index) {
                  onChanged(goals[index]);
                },
                children: goals
                    .map(
                      (goalValue) => Center(
                        child: Text(
                          goalValue.replaceAll('_', ' ').toUpperCase(),
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
