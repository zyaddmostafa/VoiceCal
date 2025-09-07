import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import 'rollover_header.dart';
import 'calorie_card.dart';
import 'rollover_action_buttons.dart';

class RolloverContent extends StatelessWidget {
  final VoidCallback onNoPressed;
  final VoidCallback onYesPressed;

  const RolloverContent({
    super.key,
    required this.onNoPressed,
    required this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    final spacing40 = SizedBox(height: 40.h);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacing40,
        RolloverHeader(),
        spacing40,
        Row(
          children: [
            Expanded(
              child: CalorieCard(
                title: 'Yesterday',
                titleColor: AppColors.error,
                currentCalories: 350,
                targetCalories: 500,
                badgeText: 'Cals left 150',
                progressColor: AppColors.error,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CalorieCard(
                title: 'Today',
                titleColor: AppColors.textSecondary,
                currentCalories: 350,
                targetCalories: 650,
                badgeText: 'Cals left 150 + 150',
                progressColor: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
        Spacer(),
        RolloverActionButtons(
          onNoPressed: onNoPressed,
          onYesPressed: onYesPressed,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
