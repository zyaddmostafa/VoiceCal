import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Slider labels with icons and values
class SliderLabels extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final String unit;

  const SliderLabels({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final middleValue = (minValue + maxValue) / 2;
    final iconTextStyle = TextStyle(fontSize: 20.sp);
    final valueTextStyle = TextStyle(
      fontSize: 12.sp,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          // Icons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('🦥', style: iconTextStyle),
              Text('🐇', style: iconTextStyle),
              Text('🏃', style: iconTextStyle),
            ],
          ),

          SizedBox(height: 8.h),

          // Values row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${minValue.toStringAsFixed(1)} $unit',
                style: valueTextStyle,
              ),
              Text(
                '${middleValue.toStringAsFixed(1)} $unit',
                style: valueTextStyle,
              ),
              Text(
                '${maxValue.toStringAsFixed(1)} $unit',
                style: valueTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
