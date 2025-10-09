import '../models/daily_nutrition.dart';
import '../models/grouped_nutrition_data.dart';

class NutritionDailyService {
  static List<GroupedNutritionData> groupByAnchoredDaysInMonth(
    List<DailyNutrition> data,
    DateTime referenceDate,
    List<int> anchors,
  ) {
    if (anchors.isEmpty) return [];
    final year = referenceDate.year;
    final month = referenceDate.month;

    final List<GroupedNutritionData> result = [];
    for (final day in anchors) {
      final entries =
          data
              .where(
                (d) =>
                    d.date.year == year &&
                    d.date.month == month &&
                    d.date.day == day,
              )
              .toList()
            ..sort((a, b) => a.date.compareTo(b.date));

      if (entries.isEmpty) {
        final date = DateTime(year, month, day);
        result.add(
          GroupedNutritionData(
            label: '$day',
            protein: 0,
            carbs: 0,
            fats: 0,
            startDate: date,
            endDate: date,
          ),
        );
        continue;
      }

      result.add(
        GroupedNutritionData(
          label: '$day',
          protein: _calculateAverage(entries.map((e) => e.protein).toList()),
          carbs: _calculateAverage(entries.map((e) => e.carbs).toList()),
          fats: _calculateAverage(entries.map((e) => e.fats).toList()),
          startDate: entries.first.date,
          endDate: entries.last.date,
        ),
      );
    }

    return result;
  }

  /// Groups exactly the last N calendar days by individual day labels
  static List<GroupedNutritionData> groupByLastNDays(
    List<DailyNutrition> data,
    int days,
  ) {
    if (days <= 0) return [];

    final now = DateTime.now();
    final List<GroupedNutritionData> grouped = [];

    for (int i = days - 1; i >= 0; i--) {
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
        final avgProtein = _calculateAverage(
          dayEntries.map((d) => d.protein).toList(),
        );
        final avgCarbs = _calculateAverage(
          dayEntries.map((d) => d.carbs).toList(),
        );
        final avgFats = _calculateAverage(
          dayEntries.map((d) => d.fats).toList(),
        );

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

  /// Computes week-over-week percentage change in calories
  static double computeWeekOverWeekCaloriesPct(List<DailyNutrition> data) {
    if (data.isEmpty) return 0;

    final now = DateTime.now();
    final thisWeekStart = now.subtract(const Duration(days: 6));
    final lastWeekStart = thisWeekStart.subtract(const Duration(days: 7));
    final lastWeekEnd = thisWeekStart.subtract(const Duration(days: 1));

    final thisWeekEntries = data
        .where(
          (d) =>
              d.date.isAfter(thisWeekStart.subtract(const Duration(days: 1))),
        )
        .toList();

    final lastWeekEntries = data
        .where(
          (d) =>
              d.date.isAfter(lastWeekStart.subtract(const Duration(days: 1))) &&
              d.date.isBefore(lastWeekEnd.add(const Duration(days: 1))),
        )
        .toList();

    if (thisWeekEntries.isEmpty || lastWeekEntries.isEmpty) return 0;

    final thisWeekCalories = _calculateTotalCalories(thisWeekEntries);
    final lastWeekCalories = _calculateTotalCalories(lastWeekEntries);

    if (lastWeekCalories == 0) return 0;

    return ((thisWeekCalories - lastWeekCalories) / lastWeekCalories) * 100;
  }

  static double _calculateAverage(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  static double _calculateTotalCalories(List<DailyNutrition> entries) {
    return entries.fold(
      0.0,
      (sum, entry) =>
          sum + (entry.protein * 4) + (entry.carbs * 4) + (entry.fats * 9),
    );
  }

  static String _getDayName(int weekday) {
    const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday];
  }
}
