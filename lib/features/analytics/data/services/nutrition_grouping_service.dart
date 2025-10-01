import '../models/daily_nutrition.dart';
import '../models/grouped_nutrition_data.dart';

/// Service responsible for grouping nutrition data by time periods
class NutritionGroupingService {
  /// Groups nutrition data based on selected time period
  static List<GroupedNutritionData> groupByPeriod(
    List<DailyNutrition> nutritionData,
    String selectedPeriod,
  ) {
    if (nutritionData.isEmpty) return [];

    final sortedData = List<DailyNutrition>.from(nutritionData)
      ..sort((a, b) => a.date.compareTo(b.date));

    switch (selectedPeriod) {
      case '90 Days':
        return _groupByMonthNames(sortedData, 3);
      case '6 Months':
        return _groupByMonthNames(sortedData, 6);
      case '1 Year':
        return _groupByQuarters(sortedData);
      case 'All time':
        return _groupByMonthNames(sortedData, 12);
      default:
        return _groupByMonthNames(sortedData, 3);
    }
  }

  /// Groups entries by month names for the specified number of months
  static List<GroupedNutritionData> _groupByMonthNames(
    List<DailyNutrition> data,
    int monthCount,
  ) {
    if (data.isEmpty) return [];

    final now = DateTime.now();
    final List<GroupedNutritionData> grouped = [];

    for (int i = monthCount - 1; i >= 0; i--) {
      final targetMonth = DateTime(now.year, now.month - i, 1);
      final nextMonth = DateTime(targetMonth.year, targetMonth.month + 1, 1);

      final monthEntries = data
          .where(
            (n) =>
                n.date.isAfter(targetMonth.subtract(const Duration(days: 1))) &&
                n.date.isBefore(nextMonth),
          )
          .toList();

      if (monthEntries.isNotEmpty) {
        final avgProtein = _calculateAverage(
          monthEntries.map((d) => d.protein).toList(),
        );
        final avgCarbs = _calculateAverage(
          monthEntries.map((d) => d.carbs).toList(),
        );
        final avgFats = _calculateAverage(
          monthEntries.map((d) => d.fats).toList(),
        );

        grouped.add(
          GroupedNutritionData(
            label: _getMonthName(targetMonth.month),
            protein: avgProtein,
            carbs: avgCarbs,
            fats: avgFats,
            startDate: monthEntries.first.date,
            endDate: monthEntries.last.date,
          ),
        );
      } else {
        grouped.add(
          GroupedNutritionData(
            label: _getMonthName(targetMonth.month),
            protein: 0,
            carbs: 0,
            fats: 0,
            startDate: targetMonth,
            endDate: targetMonth,
          ),
        );
      }
    }

    return grouped;
  }

  /// Groups entries by quarters for yearly view
  static List<GroupedNutritionData> _groupByQuarters(
    List<DailyNutrition> data,
  ) {
    if (data.isEmpty) return [];

    final now = DateTime.now();
    final List<GroupedNutritionData> grouped = [];
    final quarters = ['Q1', 'Q2', 'Q3', 'Q4'];

    for (int q = 0; q < 4; q++) {
      final startMonth = q * 3 + 1;
      final endMonth = startMonth + 2;

      final quarterEntries = data
          .where(
            (n) =>
                n.date.year == now.year &&
                n.date.month >= startMonth &&
                n.date.month <= endMonth,
          )
          .toList();

      if (quarterEntries.isNotEmpty) {
        final avgProtein = _calculateAverage(
          quarterEntries.map((d) => d.protein).toList(),
        );
        final avgCarbs = _calculateAverage(
          quarterEntries.map((d) => d.carbs).toList(),
        );
        final avgFats = _calculateAverage(
          quarterEntries.map((d) => d.fats).toList(),
        );

        grouped.add(
          GroupedNutritionData(
            label: quarters[q],
            protein: avgProtein,
            carbs: avgCarbs,
            fats: avgFats,
            startDate: quarterEntries.first.date,
            endDate: quarterEntries.last.date,
          ),
        );
      } else {
        final quarterStart = DateTime(now.year, startMonth, 1);
        grouped.add(
          GroupedNutritionData(
            label: quarters[q],
            protein: 0,
            carbs: 0,
            fats: 0,
            startDate: quarterStart,
            endDate: quarterStart,
          ),
        );
      }
    }

    return grouped;
  }

  static double _calculateAverage(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  static String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  /// Groups nutrition data by weeks for 3 Weeks and 1 Month periods
  static List<GroupedNutritionData> groupByWeeks(
    List<DailyNutrition> data,
    String period,
  ) {
    if (data.isEmpty) return [];

    final now = DateTime.now();
    final sortedData = List<DailyNutrition>.from(data)
      ..sort((a, b) => a.date.compareTo(b.date));

    final List<GroupedNutritionData> grouped = [];

    if (period == '3 Weeks') {
      // Group by 3 weeks (3 data points)
      for (int weekIndex = 2; weekIndex >= 0; weekIndex--) {
        final weekStart = now.subtract(Duration(days: (weekIndex + 1) * 7));
        final weekEnd = now.subtract(Duration(days: weekIndex * 7));

        final weekEntries = sortedData
            .where(
              (entry) =>
                  entry.date.isAfter(
                    weekStart.subtract(const Duration(days: 1)),
                  ) &&
                  entry.date.isBefore(weekEnd.add(const Duration(days: 1))),
            )
            .toList();

        final avgProtein = _calculateAverage(
          weekEntries.map((d) => d.protein).toList(),
        );
        final avgCarbs = _calculateAverage(
          weekEntries.map((d) => d.carbs).toList(),
        );
        final avgFats = _calculateAverage(
          weekEntries.map((d) => d.fats).toList(),
        );

        grouped.add(
          GroupedNutritionData(
            label: 'Week ${3 - weekIndex}',
            protein: avgProtein,
            carbs: avgCarbs,
            fats: avgFats,
            startDate: weekStart,
            endDate: weekEnd,
          ),
        );
      }
    } else if (period == '1 Month') {
      // Group by weeks in current month (4-5 data points depending on month)
      final firstDayOfMonth = DateTime(now.year, now.month, 1);
      final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

      // Calculate number of weeks in current month
      final daysInMonth = lastDayOfMonth.day;
      final weeksInMonth = (daysInMonth / 7).ceil();

      for (int weekIndex = 0; weekIndex < weeksInMonth; weekIndex++) {
        final weekStart = firstDayOfMonth.add(Duration(days: weekIndex * 7));
        final weekEnd = weekIndex == weeksInMonth - 1
            ? lastDayOfMonth
            : firstDayOfMonth.add(Duration(days: (weekIndex + 1) * 7 - 1));

        final weekEntries = sortedData
            .where(
              (entry) =>
                  entry.date.isAfter(
                    weekStart.subtract(const Duration(days: 1)),
                  ) &&
                  entry.date.isBefore(weekEnd.add(const Duration(days: 1))),
            )
            .toList();

        final avgProtein = _calculateAverage(
          weekEntries.map((d) => d.protein).toList(),
        );
        final avgCarbs = _calculateAverage(
          weekEntries.map((d) => d.carbs).toList(),
        );
        final avgFats = _calculateAverage(
          weekEntries.map((d) => d.fats).toList(),
        );

        grouped.add(
          GroupedNutritionData(
            label: 'W${weekIndex + 1}',
            protein: avgProtein,
            carbs: avgCarbs,
            fats: avgFats,
            startDate: weekStart,
            endDate: weekEnd,
          ),
        );
      }
    }

    return grouped;
  }
}
