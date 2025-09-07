import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable weight picker widget supporting both metric and imperial units
class WeightPicker extends StatelessWidget {
  final bool isMetric;
  final int selectedWeightKg;
  final int selectedWeightLb;
  final ValueChanged<int> onWeightKgChanged;
  final ValueChanged<int> onWeightLbChanged;

  const WeightPicker({
    super.key,
    required this.isMetric,
    required this.selectedWeightKg,
    required this.selectedWeightLb,
    required this.onWeightKgChanged,
    required this.onWeightLbChanged,
  });

  @override
  Widget build(BuildContext context) {
    const itemExtent = 40.0;

    if (isMetric) {
      return _MetricWeightPicker(
        selectedWeightKg: selectedWeightKg,
        onWeightChanged: onWeightKgChanged,
        itemExtent: itemExtent,
      );
    } else {
      return _ImperialWeightPicker(
        selectedWeightLb: selectedWeightLb,
        onWeightChanged: onWeightLbChanged,
        itemExtent: itemExtent,
      );
    }
  }
}

class _MetricWeightPicker extends StatelessWidget {
  final int selectedWeightKg;
  final ValueChanged<int> onWeightChanged;
  final double itemExtent;

  const _MetricWeightPicker({
    required this.selectedWeightKg,
    required this.onWeightChanged,
    required this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
        initialItem: selectedWeightKg - 30,
      ),
      itemExtent: itemExtent,
      onSelectedItemChanged: (index) {
        onWeightChanged(30 + index);
        HapticFeedback.selectionClick();
      },
      children: List.generate(171, (index) {
        final weight = 30 + index;
        return Center(
          child: Text(
            '$weight kg',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1D1D1F),
            ),
          ),
        );
      }),
    );
  }
}

class _ImperialWeightPicker extends StatelessWidget {
  final int selectedWeightLb;
  final ValueChanged<int> onWeightChanged;
  final double itemExtent;

  const _ImperialWeightPicker({
    required this.selectedWeightLb,
    required this.onWeightChanged,
    required this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
        initialItem: selectedWeightLb - 70,
      ),
      itemExtent: itemExtent,
      onSelectedItemChanged: (index) {
        onWeightChanged(70 + index);
        HapticFeedback.selectionClick();
      },
      children: List.generate(331, (index) {
        final weight = 70 + index;
        return Center(
          child: Text(
            '$weight lb',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1D1D1F),
            ),
          ),
        );
      }),
    );
  }
}
