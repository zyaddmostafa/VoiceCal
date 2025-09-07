import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1D1D1F),
          ),
        ),
        if (unit.isNotEmpty) ...[
          SizedBox(width: 4.w),
          Text(
            unit,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF86868B),
            ),
          ),
        ],
      ],
    );
  }
}
