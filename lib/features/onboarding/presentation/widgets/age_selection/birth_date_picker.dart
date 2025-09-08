import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Cupertino-style date picker for age selection
class BirthDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const BirthDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<BirthDatePicker> createState() => _BirthDatePickerState();
}

class _BirthDatePickerState extends State<BirthDatePicker> {
  late DateTime _selectedDate;
  DateTime? _lastNotifiedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _onDateTimeChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });

    // Only trigger haptic feedback if the date actually changed
    if (_lastNotifiedDate != newDate) {
      HapticFeedback.selectionClick();
      _lastNotifiedDate = newDate;
      widget.onDateChanged(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final minimumYear = currentYear - 100; // Max age 100
    final maximumYear = currentYear - 13; // Min age 13

    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(
            fontSize: 20.sp,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: _selectedDate,
        minimumYear: minimumYear,
        maximumYear: maximumYear,
        onDateTimeChanged: _onDateTimeChanged,
        backgroundColor: AppColors.backgroundPrimary,
      ),
    );
  }
}
