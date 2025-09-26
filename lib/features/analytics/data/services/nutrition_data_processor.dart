import '../models/daily_nutrition.dart';
import '../models/grouped_nutrition_data.dart';

class NutritionDataProcessor {
  static List<GroupedNutritionData> processNutritionData(
    List<DailyNutrition> nutritionData,
    String selectedPeriod,
  ) {
    if (nutritionData.isEmpty) return [];

    // Sort data by date to ensure proper ordering
    final sortedData = List<DailyNutrition>.from(nutritionData)
      ..sort((a, b) => a.date.compareTo(b.date));

    switch (selectedPeriod) {
      case '7 Days':
        return _groupByDayNames(sortedData);
      case '1 Month':
        return _groupByWeeks(sortedData);
      case '3 Months':
        return _groupByMonthNames(sortedData, 3);
      case '6 Months':
        return _groupByMonthNames(sortedData, 6);
      case '1 Year':
        return _groupByQuarters(sortedData);
      default:
        return _groupByDayNames(sortedData);
    }
  }

  /// Groups exactly the last 7 calendar days by individual day names (e.g., Mon 23)
  static List<GroupedNutritionData> _groupByDayNames(
    List<DailyNutrition> data,
  ) {
    final now = DateTime.now();
    final List<GroupedNutritionData> grouped = [];

    for (int i = 6; i >= 0; i--) {
      final target = now.subtract(Duration(days: i));

      final dayEntries = data
          .where(
            (n) =>
                n.date.year == target.year &&
                n.date.month == target.month &&
                n.date.day == target.day,
          )
          .toList();

      if (dayEntries.isNotEmpty) {
        final avgProtein =
            dayEntries.map((d) => d.protein).reduce((a, b) => a + b) /
            dayEntries.length;
        final avgCarbs =
            dayEntries.map((d) => d.carbs).reduce((a, b) => a + b) /
            dayEntries.length;
        final avgFats =
            dayEntries.map((d) => d.fats).reduce((a, b) => a + b) /
            dayEntries.length;

        grouped.add(
          GroupedNutritionData(
            label: '${_getDayName(target.weekday)} ${target.day}',
            protein: avgProtein,
            carbs: avgCarbs,
            fats: avgFats,
            startDate: dayEntries.first.date,
            endDate: dayEntries.last.date,
          ),
        );
      } else {
        // keep slot with zeros for missing days to maintain 7 bars
        grouped.add(
          GroupedNutritionData(
            label: '${_getDayName(target.weekday)} ${target.day}',
            protein: 0,
            carbs: 0,
            fats: 0,
            startDate: target,
            endDate: target,
          ),
        );
      }
    }

    return grouped;
  }

  static List<GroupedNutritionData> _groupByWeeks(List<DailyNutrition> data) {
    final last28Days = data.length >= 28
        ? data.sublist(data.length - 28)
        : data;
    final List<GroupedNutritionData> weeks = [];

    // Group by actual calendar weeks instead of arbitrary 7-day chunks
    final Map<String, List<DailyNutrition>> weekGroups = {};

    for (final nutrition in last28Days) {
      final weekKey = _getCalendarWeekKey(nutrition.date);
      weekGroups[weekKey] ??= [];
      weekGroups[weekKey]!.add(nutrition);
    }

    int weekNumber = 1;
    for (final entry
        in weekGroups.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key))) {
      final weekData = entry.value;
      weekData.sort((a, b) => a.date.compareTo(b.date));

      final avgProtein =
          weekData.map((d) => d.protein).reduce((a, b) => a + b) /
          weekData.length;
      final avgCarbs =
          weekData.map((d) => d.carbs).reduce((a, b) => a + b) /
          weekData.length;
      final avgFats =
          weekData.map((d) => d.fats).reduce((a, b) => a + b) / weekData.length;

      weeks.add(
        GroupedNutritionData(
          label: 'Week $weekNumber',
          protein: avgProtein,
          carbs: avgCarbs,
          fats: avgFats,
          startDate: weekData.first.date,
          endDate: weekData.last.date,
        ),
      );
      weekNumber++;
    }

    return weeks;
  }

  /// Groups data by month names for 3 or 6 month periods
  static List<GroupedNutritionData> _groupByMonthNames(
    List<DailyNutrition> data,
    int monthCount,
  ) {
    final now = DateTime.now();
    final List<GroupedNutritionData> result = [];

    // Build exact calendar months from oldest to newest
    for (int i = monthCount - 1; i >= 0; i--) {
      final targetYear = now.year + ((now.month - 1 - i) ~/ 12);
      final targetMonth = ((now.month - 1 - i) % 12) + 1;
      final monthStart = DateTime(targetYear, targetMonth, 1);
      final monthEnd = DateTime(targetYear, targetMonth + 1, 0);

      // Entries in this month
      final monthData =
          data
              .where(
                (d) => d.date.year == targetYear && d.date.month == targetMonth,
              )
              .toList()
            ..sort((a, b) => a.date.compareTo(b.date));

      double protein = 0, carbs = 0, fats = 0;
      if (monthData.isNotEmpty) {
        protein =
            monthData.map((d) => d.protein).reduce((a, b) => a + b) /
            monthData.length;
        carbs =
            monthData.map((d) => d.carbs).reduce((a, b) => a + b) /
            monthData.length;
        fats =
            monthData.map((d) => d.fats).reduce((a, b) => a + b) /
            monthData.length;
      }

      result.add(
        GroupedNutritionData(
          label: _getMonthName(
            targetMonth,
          ), // exclude year for < 1 year periods
          protein: protein,
          carbs: carbs,
          fats: fats,
          startDate: monthData.isNotEmpty ? monthData.first.date : monthStart,
          endDate: monthData.isNotEmpty ? monthData.last.date : monthEnd,
        ),
      );
    }

    return result;
  }

  /// Gets a unique calendar week key for grouping
  static String _getCalendarWeekKey(DateTime date) {
    // Get the start of the week (Monday)
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    return '${startOfWeek.year}-W${_getWeekOfYear(startOfWeek)}';
  }

  /// Gets week of year
  static int _getWeekOfYear(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final daysDiff = date.difference(startOfYear).inDays;

    return (daysDiff / 7).floor() + 1;
  }

  /// Gets quarter label for a given date (Q1, Q2, Q3, Q4)
  static String _getQuarterLabel(DateTime date) {
    final month = date.month;
    if (month >= 1 && month <= 3) return 'Q1';
    if (month >= 4 && month <= 6) return 'Q2';
    if (month >= 7 && month <= 9) return 'Q3';

    return 'Q4';
  }

  static String _getMonthName(int month) {
    const months = [
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

    return months[month - 1];
  }

  /// Gets abbreviated day name for a given weekday (1=Monday, 7=Sunday)
  static String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return days[weekday - 1];
  }

  /// Groups data by quarters for the 1 Year period
  static List<GroupedNutritionData> _groupByQuarters(
    List<DailyNutrition> data,
  ) {
    final now = DateTime.now();
    final List<GroupedNutritionData> result = [];

    // Build quarters for the last year
    for (int i = 3; i >= 0; i--) {
      final quarterStart = DateTime(now.year, (i * 3) + 1, 1);
      final quarterEnd = DateTime(now.year, (i * 3) + 4, 0);

      final quarterData =
          data
              .where(
                (d) =>
                    d.date.isAfter(
                      quarterStart.subtract(const Duration(days: 1)),
                    ) &&
                    d.date.isBefore(quarterEnd.add(const Duration(days: 1))),
              )
              .toList()
            ..sort((a, b) => a.date.compareTo(b.date));

      double protein = 0, carbs = 0, fats = 0;
      if (quarterData.isNotEmpty) {
        protein =
            quarterData.map((d) => d.protein).reduce((a, b) => a + b) /
            quarterData.length;
        carbs =
            quarterData.map((d) => d.carbs).reduce((a, b) => a + b) /
            quarterData.length;
        fats =
            quarterData.map((d) => d.fats).reduce((a, b) => a + b) /
            quarterData.length;
      }

      result.add(
        GroupedNutritionData(
          label: _getQuarterLabel(quarterStart),
          protein: protein,
          carbs: carbs,
          fats: fats,
          startDate: quarterData.isNotEmpty
              ? quarterData.first.date
              : quarterStart,
          endDate: quarterData.isNotEmpty ? quarterData.last.date : quarterEnd,
        ),
      );
    }

    return result;
  }
}
