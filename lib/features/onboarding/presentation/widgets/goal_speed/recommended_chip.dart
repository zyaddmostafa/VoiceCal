import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedChip extends StatelessWidget {
  final double value; // current speed value in active unit
  final double min;
  final double max;

  const RecommendedChip({
    super.key,
    required this.value,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final String label = _computeLabel(value, min, max);
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Color(0xFFF2F2F7), Color(0xFFECECF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2C2C2E),
        ),
      ),
    );
  }

  String _computeLabel(double value, double min, double max) {
    final double span = max - min;
    if (span <= 0) return 'Recommended';
    final double lowThreshold = min + span * 0.25;
    final double highThreshold = max - span * 0.25;
    if (value <= lowThreshold) {
      return 'Slow and Steady';
    }
    if (value >= highThreshold) {
      return 'Not recommended for long term, may lead to loose skin';
    }
    return 'Recommended';
  }
}
