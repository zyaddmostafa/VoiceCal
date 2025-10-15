import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLinearProgressIndicator extends StatelessWidget {
  final double value;

  final Color backgroundColor;

  final Color progressColor;

  final double? height;

  final BorderRadius? borderRadius;

  const AppLinearProgressIndicator({
    super.key,
    required this.value,
    required this.backgroundColor,
    required this.progressColor,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 6.h;
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(4.r);
    final clampedValue = value.clamp(0.0, 1.0);

    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: effectiveBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: LinearProgressIndicator(
          value: clampedValue,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      ),
    );
  }
}
