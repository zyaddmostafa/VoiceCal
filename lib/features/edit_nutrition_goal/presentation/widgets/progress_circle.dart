import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'circular_progress_painter.dart';

/// Circular progress indicator with icon center
class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    super.key,
    required this.diameter,
    required this.icon,
    required this.color,
    required this.percentage,
  });

  final double diameter;
  final IconData icon;
  final Color color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: AppColors.borderLight, width: 4.w);

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(borderSide),
            ),
          ),
          CustomPaint(
            size: Size.square(diameter),
            painter: CircularProgressPainter(
              color,
              percentage,
              borderSide.width,
            ),
          ),
          Icon(icon, size: 20.sp, color: color),
        ],
      ),
    );
  }
}
