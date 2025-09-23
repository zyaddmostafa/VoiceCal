import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/unit_toggle.dart';
import 'goal_speed_value.dart';
import 'goal_speed_slider.dart';
import 'recommended_chip.dart';
import 'speed_markers_row.dart';
import 'speed_icons_row.dart';

class GoalSpeedScreenBody extends StatefulWidget {
  final void Function(double) onWeightChanged;
  final String userGoal;
  const GoalSpeedScreenBody({
    super.key,
    required this.onWeightChanged,
    required this.userGoal,
  });

  @override
  State<GoalSpeedScreenBody> createState() => _GoalSpeedScreenBodyState();
}

class _GoalSpeedScreenBodyState extends State<GoalSpeedScreenBody> {
  double speedLbsPerWeek = 1.0;
  bool isMetric = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: UnitToggle(
            isMetric: isMetric,
            onToggle: (v) => setState(() => isMetric = v),
          ),
        ),
        verticalSpace(40),

        Center(
          child: Text(
            ' ${widget.userGoal} speed per week',
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF2C2C2E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        verticalSpace(8),

        Center(
          child: GoalSpeedValue(
            value: isMetric ? _lbsToKg(speedLbsPerWeek) : speedLbsPerWeek,
            unit: isMetric ? 'kg' : 'lbs',
          ),
        ),
        verticalSpace(8),

        const SpeedIconsRow(),
        verticalSpace(8),

        GoalSpeedSlider(
          min: isMetric ? 0.1 : 0.2, // roughly converted bounds
          max: isMetric ? 1.4 : 3.0,
          value: isMetric ? _lbsToKg(speedLbsPerWeek) : speedLbsPerWeek,
          onChanged: (v) {
            setState(() => speedLbsPerWeek = isMetric ? _kgToLbs(v) : v);
            widget.onWeightChanged(_lbsToKg(speedLbsPerWeek));
          },
        ),

        verticalSpace(4),
        SpeedMarkersRow(
          left: isMetric ? '0.1 kg' : '0.2 lbs',
          middle: isMetric ? '0.7 kg' : '1.5 lbs',
          right: isMetric ? '1.4 kg' : '3.0 lbs',
        ),

        verticalSpace(24),
        RecommendedChip(
          value: isMetric ? _lbsToKg(speedLbsPerWeek) : speedLbsPerWeek,
          min: isMetric ? 0.1 : 0.2,
          max: isMetric ? 1.4 : 3.0,
        ),
      ],
    );
  }

  double _lbsToKg(double lbs) => lbs * 0.45359237;
  double _kgToLbs(double kg) => kg / 0.45359237;
}
