import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class TodayInfoCard extends StatelessWidget {
  const TodayInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dayName = _getDayName(today.weekday);
    final monthName = _getMonthName(today.month);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today', style: AppTextStyles.font32BoldPrimary),
            Text(
              '$dayName, ${monthName} ${today.day}',
              style: AppTextStyles.font14RegularSecondary,
            ),
          ],
        ),
      ],
    );
  }

  String _getDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}
