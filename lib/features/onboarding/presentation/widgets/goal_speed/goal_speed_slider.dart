import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class GoalSpeedSlider extends StatelessWidget {
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;

  const GoalSpeedSlider({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4.h,
        inactiveTrackColor: const Color(0xFFD1D1D6),
        activeTrackColor: AppColors.primaryBlack,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        thumbColor: Colors.white,
        overlayColor: Colors.transparent,
        tickMarkShape: SliderTickMarkShape.noTickMark,
      ),
      child: Slider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        onChanged: (v) {
          // Snap to 0.1 increments without showing tick marks
          final snapped = (v * 10).round() / 10.0;
          onChanged(snapped.clamp(min, max));
        },
      ),
    );
  }
}
