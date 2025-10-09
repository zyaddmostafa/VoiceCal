import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SubPeriodSelectorWidget extends StatelessWidget {
  final List<String> periods;
  final String selectedPeriod;
  final ValueChanged<String> onPeriodSelected;

  const SubPeriodSelectorWidget({
    super.key,
    required this.periods,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: periods.map((period) {
        final isSelected = selectedPeriod == period;

        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: GestureDetector(
            onTap: () => onPeriodSelected(period),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlack : Colors.grey[200],
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                period,
                style: AppTextStyles.font12MediumConditional(
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
