import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  final bool isAnimated;

  const ProgressBar({
    super.key,
    required this.progress,
    required this.color,
    this.isAnimated = true,
  });

  @override
  Widget build(BuildContext context) {
    final progressHeight = 6.h;
    final progressRadius = BorderRadius.circular(3.r);

    return Container(
      height: progressHeight,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: progressRadius,
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: isAnimated ? Duration(milliseconds: 800) : Duration.zero,
            curve: Curves.easeInOut,
            width: (progress.clamp(0.0, 1.0) * 280.w),
            height: progressHeight,
            decoration: BoxDecoration(
              color: color,
              borderRadius: progressRadius,
            ),
          ),
        ],
      ),
    );
  }
}
