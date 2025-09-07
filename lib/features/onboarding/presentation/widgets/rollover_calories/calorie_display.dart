import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class CalorieDisplay extends StatelessWidget {
  final int currentCalories;
  final int targetCalories;

  const CalorieDisplay({
    super.key,
    required this.currentCalories,
    required this.targetCalories,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        children: [
          TextSpan(text: '$currentCalories'),
          TextSpan(
            text: ' / $targetCalories',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
