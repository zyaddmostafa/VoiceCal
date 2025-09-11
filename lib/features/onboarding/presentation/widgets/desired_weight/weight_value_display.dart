import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';

class WeightValueDisplay extends StatelessWidget {
  final double value;
  final String unit; // 'lbs' or 'kg'
  const WeightValueDisplay({
    super.key,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value.toStringAsFixed(1)} $unit',
      style: AppTextStyles.font32ExtraBold,
    );
  }
}
