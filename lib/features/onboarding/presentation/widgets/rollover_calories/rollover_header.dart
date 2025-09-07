import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class RolloverHeader extends StatelessWidget {
  const RolloverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '👉 Rollover extra calories to the next day?',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        SizedBox(height: 12.h),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              height: 1.3,
            ),
            children: [
              const TextSpan(text: '👉 Rollover up to '),
              TextSpan(
                text: '200 cals',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
