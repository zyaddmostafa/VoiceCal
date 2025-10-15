import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A utility class for showing custom Cupertino-style bottom sheets
class CustomBottomSheets {
  CustomBottomSheets._();

  /// Shows a Cupertino date picker bottom sheet
  ///
  /// Returns the selected date when user taps Done, null when cancelled
  static Future<DateTime?> showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) async {
    DateTime selectedDate = initialDate;

    return showCupertinoModalPopup<DateTime?>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300.h,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            _buildHeader(
              context: context,
              onCancel: () => Navigator.of(context).pop(null),
              onDone: () => Navigator.of(context).pop(selectedDate),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
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

  /// Shows a Cupertino picker bottom sheet with a list of options
  ///
  /// Returns the selected value when user taps Done, null when cancelled
  static Future<String?> showPicker({
    required BuildContext context,
    required List<String> items,
    required int initialIndex,
    String Function(String)? itemBuilder,
  }) async {
    int selectedIndex = initialIndex;

    return showCupertinoModalPopup<String?>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250.h,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            _buildHeader(
              context: context,
              onCancel: () => Navigator.of(context).pop(null),
              onDone: () => Navigator.of(context).pop(items[selectedIndex]),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 32.h,
                scrollController: FixedExtentScrollController(
                  initialItem: initialIndex,
                ),
                onSelectedItemChanged: (int index) {
                  selectedIndex = index;
                },
                children: items
                    .map(
                      (item) => Center(
                        child: Text(
                          itemBuilder != null ? itemBuilder(item) : item,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the header with Cancel and Done buttons
  static Widget _buildHeader({
    required BuildContext context,
    required VoidCallback onCancel,
    required VoidCallback onDone,
  }) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        border: Border(
          bottom: BorderSide(color: CupertinoColors.separator, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onCancel,
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primaryBlack,
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onDone,
            child: Text(
              'Done',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
