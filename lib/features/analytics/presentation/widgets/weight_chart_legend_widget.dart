import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightChartLegendWidget extends StatelessWidget {
  final double currentWeight;

  const WeightChartLegendWidget({super.key, required this.currentWeight});

  @override
  Widget build(BuildContext context) {
    final size8 = 8.w;
    return Row(
      children: [
        Container(
          width: size8,
          height: 8.h,
          decoration: const BoxDecoration(
            color: Color(0xFF6366F1),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: size8),
        Text(
          'Last 30 days',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
        const Spacer(),
        Text(
          '${currentWeight.toStringAsFixed(1)} kg',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
