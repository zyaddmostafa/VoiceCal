import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_icons.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class BirthDatePicker extends StatelessWidget {
  final DateTime? birthDate;
  final String? currentBornDate;
  final ValueChanged<DateTime?> onDateSelected;

  const BirthDatePicker({
    super.key,
    required this.birthDate,
    this.currentBornDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final dateText = birthDate != null
        ? '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}'
        : currentBornDate != null
        ? DateTime.parse(currentBornDate!).toString().split(' ')[0]
        : 'Select date';

    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Birth Date',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            horizontalSpace(16),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    dateText,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: birthDate != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary.withValues(alpha: 0.5),
                      fontWeight: birthDate != null
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                  horizontalSpace(8),
                  Icon(
                    AppIcons.calendar,
                    size: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    DateTime selectedDate = birthDate ?? DateTime(2000);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300.h,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            Container(
              height: 44.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      onDateSelected(selectedDate);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Done',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: CupertinoColors.systemBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: birthDate ?? DateTime(2000),
                minimumDate: DateTime(1900),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
