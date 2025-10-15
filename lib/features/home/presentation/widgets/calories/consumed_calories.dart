import 'package:flutter/cupertino.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ConsumedCalories extends StatelessWidget {
  const ConsumedCalories({
    super.key,
    required this.consumed,
    required this.isOverGoal,
  });

  final int consumed;
  final bool isOverGoal;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          consumed.toStringAsFixed(0),
          style: AppTextStyles.font32BoldPrimary.copyWith(
            color: isOverGoal ? AppColors.error : AppColors.textPrimary,
          ),
        ),
        horizontalSpace(8),
        Text('calories consumed', style: AppTextStyles.font12RegularSecondary),
      ],
    );
  }
}
