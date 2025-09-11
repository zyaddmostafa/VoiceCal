import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'number_formatter.dart';

class ValueDisplay extends StatelessWidget {
  final String inputValue;
  final String unit;

  const ValueDisplay({super.key, required this.inputValue, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          NumberFormatter.format(NumberFormatter.parse(inputValue)),
          style: AppTextStyles.font20RegularPrimary,
        ),
        if (unit.isNotEmpty) ...[
          horizontalSpace(4),
          Text(unit, style: AppTextStyles.font16RegularSecondary),
        ],
      ],
    );
  }
}
