import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TimePeriodSelectorWidget extends StatefulWidget {
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const TimePeriodSelectorWidget({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  State<TimePeriodSelectorWidget> createState() =>
      _TimePeriodSelectorWidgetState();
}

class _TimePeriodSelectorWidgetState extends State<TimePeriodSelectorWidget> {
  static const List<String> _periods = [
    '90 Days',
    '6 Months',
    '1 Year',
    'All time',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _periods.map((period) {
        final isSelected = widget.selectedPeriod == period;

        return Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: GestureDetector(
            onTap: () => widget.onPeriodChanged(period),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlack : Colors.grey[200],
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                period,
                style: AppTextStyles.font14MediumConditional(
                  isSelected: isSelected,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
