import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';

class HeightPicker extends StatelessWidget {
  final bool isMetric;
  final int selectedHeightCm;
  final int selectedHeightFt;
  final int selectedHeightIn;
  final ValueChanged<int> onHeightCmChanged;
  final ValueChanged<int> onHeightFtChanged;
  final ValueChanged<int> onHeightInChanged;

  const HeightPicker({
    super.key,
    required this.isMetric,
    required this.selectedHeightCm,
    required this.selectedHeightFt,
    required this.selectedHeightIn,
    required this.onHeightCmChanged,
    required this.onHeightFtChanged,
    required this.onHeightInChanged,
  });

  @override
  Widget build(BuildContext context) {
    const itemExtent = 40.0;

    return isMetric
        ? _MetricHeightPicker(
            selectedHeightCm: selectedHeightCm,
            onHeightChanged: onHeightCmChanged,
            itemExtent: itemExtent,
          )
        : _ImperialHeightPicker(
            selectedHeightFt: selectedHeightFt,
            selectedHeightIn: selectedHeightIn,
            onHeightFtChanged: onHeightFtChanged,
            onHeightInChanged: onHeightInChanged,
            itemExtent: itemExtent,
          );
  }
}

class _MetricHeightPicker extends StatelessWidget {
  final int selectedHeightCm;
  final ValueChanged<int> onHeightChanged;
  final double itemExtent;

  const _MetricHeightPicker({
    required this.selectedHeightCm,
    required this.onHeightChanged,
    required this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
        initialItem: selectedHeightCm - 100,
      ),
      itemExtent: itemExtent,
      onSelectedItemChanged: (index) {
        onHeightChanged(100 + index);
        HapticFeedback.selectionClick();
      },
      children: List.generate(151, (index) {
        final height = 100 + index;

        return Center(
          child: Text('$height cm', style: AppTextStyles.font18MediumBlack),
        );
      }),
    );
  }
}

class _ImperialHeightPicker extends StatelessWidget {
  final int selectedHeightFt;
  final int selectedHeightIn;
  final ValueChanged<int> onHeightFtChanged;
  final ValueChanged<int> onHeightInChanged;
  final double itemExtent;

  const _ImperialHeightPicker({
    required this.selectedHeightFt,
    required this.selectedHeightIn,
    required this.onHeightFtChanged,
    required this.onHeightInChanged,
    required this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: selectedHeightFt - 3,
            ),
            itemExtent: itemExtent,
            onSelectedItemChanged: (index) {
              onHeightFtChanged(3 + index);
              HapticFeedback.selectionClick();
            },
            children: List.generate(6, (index) {
              final feet = 3 + index;

              return Center(
                child: Text('$feet ft', style: AppTextStyles.font18MediumBlack),
              );
            }),
          ),
        ),
        // Inches picker
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: selectedHeightIn,
            ),
            itemExtent: itemExtent,
            onSelectedItemChanged: (index) {
              onHeightInChanged(index);
              HapticFeedback.selectionClick();
            },
            children: List.generate(12, (index) {
              return Center(
                child: Text(
                  '$index in',
                  style: AppTextStyles.font18MediumBlack,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
