import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Display widget for selected weight with unit
class WeightDisplay extends StatelessWidget {
  final int weight;
  final String unit;

  const WeightDisplay({super.key, required this.weight, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 32.w),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              '$weight',
              key: ValueKey(weight),
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF007AFF),
                letterSpacing: -1.0,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            unit,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF86868B),
            ),
          ),
        ],
      ),
    );
  }
}
