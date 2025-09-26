import '../models/weight_entry.dart';
import '../models/grouped_weight_data.dart';

class WeightDataProcessor {
  static List<GroupedWeightData> processWeightData(
    List<WeightEntry> weightData,
    String selectedPeriod,
  ) {
    if (weightData.isEmpty) return [];

    switch (selectedPeriod) {
      case '7 Days':
        return _groupByWeekNames(weightData);
      case '1 Month':
        return _groupByWeeks(weightData);
      case '3 Months':
        return _groupByMonthNames(weightData, 3);
      case '6 Months':
        return _groupByMonthNames(weightData, 6);
      case '1 Year':
        return _groupByQuarters(weightData);
      default:
        return _groupByWeekNames(weightData);
    }
  }

  /// Groups 7 days of data by individual day names (Mon, Tue, Wed, etc.)
  static List<GroupedWeightData> _groupByWeekNames(List<WeightEntry> data) {
    final now = DateTime.now();
    final List<GroupedWeightData> groupedData = [];
    final Set<String> processedDays = {};

    // Sort data by date to ensure we process them in order
    data.sort((a, b) => a.date.compareTo(b.date));

    // Get exactly the last 7 consecutive calendar days
    for (int i = 6; i >= 0; i--) {
      final targetDate = now.subtract(Duration(days: i));
      final dayName = _getDayName(targetDate.weekday);
      final dayLabel = '$dayName ${targetDate.day}';
      
      // Skip if we've already processed this day
      if (processedDays.contains(dayLabel)) continue;

      // Find weight entries for this specific calendar date
      final dayEntries = data
          .where(
            (weight) =>
                weight.date.year == targetDate.year &&
                weight.date.month == targetDate.month &&
                weight.date.day == targetDate.day,
          )
          .toList();

      if (dayEntries.isNotEmpty) {
        final avgWeight =
            dayEntries.map((w) => w.weight).reduce((a, b) => a + b) /
            dayEntries.length;

        groupedData.add(
          GroupedWeightData(
            label: dayLabel,
            weight: avgWeight,
            startDate: dayEntries.first.date,
            endDate: dayEntries.last.date,
          ),
        );
        
        // Mark this day as processed
        processedDays.add(dayLabel);
      } else if (i == 0) {
        // Only add empty entry for the current day if no data exists
        groupedData.add(
          GroupedWeightData(
            label: dayLabel,
            weight: 0,
            startDate: targetDate,
            endDate: targetDate,
          ),
        );
      }
    }

    // Ensure we have exactly 7 days of data
    while (groupedData.length < 7) {
      final daysToAdd = 7 - groupedData.length;
      for (int i = 0; i < daysToAdd; i++) {
        final date = now.subtract(Duration(days: 6 - i));
        final dayName = _getDayName(date.weekday);
        final dayLabel = '$dayName ${date.day}';
        
        if (!processedDays.contains(dayLabel)) {
          groupedData.add(
            GroupedWeightData(
              label: dayLabel,
              weight: 0,
              startDate: date,
              endDate: date,
            ),
          );
          processedDays.add(dayLabel);
        }
      }
    }

    // Sort by date to maintain chronological order
    groupedData.sort((a, b) => a.startDate.compareTo(b.startDate));
    
    return groupedData;
  }

  /// Groups data into exactly 4 weeks for 1 month period
  static List<GroupedWeightData> _groupByWeeks(List<WeightEntry> data) {
    final last28Days = data.length >= 28
        ? data.sublist(data.length - 28)
        : data;
    final List<GroupedWeightData> weeks = [];

    // Create exactly 4 weeks of data - ensure no duplicates
    for (int i = 0; i < 4; i++) {
      final weekStart = i * 7;
      final weekEnd = (i + 1) * 7;

      if (weekStart < last28Days.length) {
        final weekData = last28Days.sublist(
          weekStart,
          weekEnd > last28Days.length ? last28Days.length : weekEnd,
        );

        if (weekData.isNotEmpty) {
          final avgWeight =
              weekData.map((d) => d.weight).reduce((a, b) => a + b) /
              weekData.length;

          final weekLabel = 'Week ${i + 1}';
          // Check if this week label already exists to prevent duplicates
          if (!weeks.any((w) => w.label == weekLabel)) {
            weeks.add(
              GroupedWeightData(
                label: weekLabel,
                weight: avgWeight,
                startDate: weekData.first.date,
                endDate: weekData.last.date,
              ),
            );
          }
        }
      }
    }

    return weeks;
  }

  /// Groups data by month names for 3 or 6 month periods
  static List<GroupedWeightData> _groupByMonthNames(
    List<WeightEntry> data,
    int monthCount,
  ) {
    final now = DateTime.now();

    // Build months in chronological order from oldest to newest
    final List<GroupedWeightData> result = [];
    for (int i = monthCount - 1; i >= 0; i--) {
      // Calculate the proper month/year considering year rollover
      final targetYear = now.year + ((now.month - 1 - i) ~/ 12);
      final targetMonth = ((now.month - 1 - i) % 12) + 1;
      final monthDate = DateTime(targetYear, targetMonth, 1);

      // Filter data for this specific month and year
      final monthData = data
          .where(
            (weight) =>
                weight.date.year == monthDate.year &&
                weight.date.month == monthDate.month,
          )
          .toList();

      if (monthData.isNotEmpty) {
        final avgWeight =
            monthData.map((d) => d.weight).reduce((a, b) => a + b) /
            monthData.length;
        final monthName = _getMonthName(monthDate.month);
        final label = monthName; // exclude year for 3/6 months

        result.add(
          GroupedWeightData(
            label: label,
            weight: avgWeight,
            startDate: monthData.first.date,
            endDate: monthData.last.date,
          ),
        );
      }
    }

    return result;
  }

  /// Groups data by quarters for 1 year period
  static List<GroupedWeightData> _groupByQuarters(List<WeightEntry> data) {
    final now = DateTime.now();
    final List<GroupedWeightData> quarterGroups = [];

    // Determine current quarter (1-4)
    int currentQuarter = ((now.month - 1) ~/ 3) + 1;

    // Generate exactly 4 quarters from oldest to newest
    for (int i = 3; i >= 0; i--) {
      int qIndex = currentQuarter - i;
      int year = now.year;
      while (qIndex <= 0) {
        qIndex += 4;
        year -= 1;
      }
      while (qIndex > 4) {
        qIndex -= 4;
        year += 1;
      }

      final quarterStartMonth = (qIndex - 1) * 3 + 1;
      final quarterEndMonth = quarterStartMonth + 2;

      // Filter data for this quarter
      final quarterData = data.where((weight) {
        final m = weight.date.month;
        return weight.date.year == year && m >= quarterStartMonth && m <= quarterEndMonth;
      }).toList();

      if (quarterData.isNotEmpty) {
        final avgWeight =
            quarterData.map((d) => d.weight).reduce((a, b) => a + b) /
            quarterData.length;

        final quarterLabel = 'Q$qIndex $year';
        quarterGroups.add(
          GroupedWeightData(
            label: quarterLabel,
            weight: avgWeight,
            startDate: quarterData.first.date,
            endDate: quarterData.last.date,
          ),
        );
      }
    }

    return quarterGroups;
  }

  /// Gets day name for a given weekday number
  static String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  /// Gets month name for a given month number
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
}
