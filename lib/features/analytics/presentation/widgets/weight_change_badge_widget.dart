import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightChangeBadgeWidget extends StatelessWidget {
  final double weightChange;

  const WeightChangeBadgeWidget({super.key, required this.weightChange});

  @override
  Widget build(BuildContext context) {
    final isDecrease = weightChange < 0;
    final badgeColor = isDecrease
        ? const Color(0xFF4CAF50)
        : const Color(0xFFFF9800);
    final backgroundColor = isDecrease
        ? const Color(0xFFE8F5E8)
        : const Color(0xFFFFF3E0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isDecrease ? Icons.trending_down : Icons.trending_up,
            size: 16.sp,
            color: badgeColor,
          ),
          SizedBox(width: 4.w),
          Text(
            '${weightChange.abs().toStringAsFixed(1)} kg',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }
}
