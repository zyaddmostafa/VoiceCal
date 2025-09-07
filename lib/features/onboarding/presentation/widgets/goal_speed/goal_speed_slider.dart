import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Custom Cupertino-style slider for goal speed selection
class GoalSpeedSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final bool showRecommendedBadge;

  const GoalSpeedSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.showRecommendedBadge = false,
  });

  @override
  State<GoalSpeedSlider> createState() => _GoalSpeedSliderState();
}

class _GoalSpeedSliderState extends State<GoalSpeedSlider> {
  double? _lastValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Recommended badge
        if (widget.showRecommendedBadge) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF8F8F8), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.divider.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              'Recommended',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],

        // Custom slider
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4.h,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 14.r,
              elevation: 4,
            ),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 24.r),
            activeTrackColor: AppColors.primaryBlue,
            inactiveTrackColor: AppColors.divider,
            thumbColor: Colors.white,
            overlayColor: AppColors.primaryBlue.withValues(alpha: 0.1),
          ),
          child: Slider(
            value: widget.value,
            min: widget.min,
            max: widget.max,
            divisions: ((widget.max - widget.min) / 0.1).round(),
            onChanged: (value) {
              final roundedValue = (value * 10).round() / 10;
              if (_lastValue != roundedValue) {
                HapticFeedback.selectionClick();
                _lastValue = roundedValue;
              }
              widget.onChanged(roundedValue);
            },
          ),
        ),
      ],
    );
  }
}
