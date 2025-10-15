import 'package:flutter/cupertino.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class RemainingCalories extends StatelessWidget {
  const RemainingCalories({
    super.key,
    required this.remaining,
    required this.percentage,
    required this.isOverGoal,
  });

  final int remaining;
  final double percentage;
  final bool isOverGoal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${remaining > 0 ? remaining : 0} calories remaining',
          style: AppTextStyles.font12RegularSecondary,
        ),
        Text(
          '${(percentage * 100).toInt()}%',
          style: AppTextStyles.font12MediumPrimary.copyWith(
            color: isOverGoal ? AppColors.error : AppColors.primaryDark,
          ),
        ),
      ],
    );
  }
}
