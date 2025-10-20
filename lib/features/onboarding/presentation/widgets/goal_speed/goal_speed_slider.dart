import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        activeColor: AppColors.primaryBlack,
        thumbColor: Colors.white,
        onChanged: (v) {
          final snapped = (v * 10).round() / 10.0;
          onChanged(snapped.clamp(min, max));
        },
      ),
    );
  }
}
