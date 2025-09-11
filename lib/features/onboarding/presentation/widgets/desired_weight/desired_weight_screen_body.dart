import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/unit_toggle.dart';
import '../weight_picker/goal_label.dart';
import '../weight_picker/weight_ruler.dart';
import 'weight_value_display.dart';

class DesiredWeightScreenBody extends StatefulWidget {
  const DesiredWeightScreenBody({super.key, required this.goal});

  final String goal;

  @override
  State<DesiredWeightScreenBody> createState() =>
      _DesiredWeightScreenBodyState();
}

class _DesiredWeightScreenBodyState extends State<DesiredWeightScreenBody> {
  bool isMetric = false;
  double selectedWeightLbs = 105.0;

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

        GoalLabel(text: widget.goal),
        verticalSpace(8),

        Center(
          child: WeightValueDisplay(
            value: isMetric ? _lbsToKg(selectedWeightLbs) : selectedWeightLbs,
            unit: isMetric ? 'kg' : 'lbs',
          ),
        ),

        verticalSpace(16),

        // Ruler
        WeightRuler(
          min: isMetric ? 30 : 60,
          max: isMetric ? 200 : 300,
          initial: isMetric ? _lbsToKg(selectedWeightLbs) : selectedWeightLbs,
          onChanged: (v) =>
              setState(() => selectedWeightLbs = isMetric ? _kgToLbs(v) : v),
        ),
      ],
    );
  }

  double _lbsToKg(double lbs) => lbs * 0.45359237;

  double _kgToLbs(double kg) => kg / 0.45359237;
}
