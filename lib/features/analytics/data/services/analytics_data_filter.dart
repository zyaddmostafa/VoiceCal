import '../models/weight_entry.dart';
import '../models/daily_nutrition.dart';

class AnalyticsDataFilter {
  /// Filters weight entries based on selected time period
  static List<WeightEntry> filterWeightData(
    List<WeightEntry> allData,
    String selectedPeriod,
  ) {
    if (allData.isEmpty) return allData;

    final sortedData = List<WeightEntry>.from(allData)
      ..sort((a, b) => a.date.compareTo(b.date));

    switch (selectedPeriod) {
      case '90 Days':
        return _filterLastDays(sortedData, 90);
      case '6 Months':
        return _filterLastDays(sortedData, 180);
      case '1 Year':
        return _filterLastDays(sortedData, 365);
      case 'All time':
        return sortedData;
      default:
        return _filterLastDays(sortedData, 90);
    }
  }

  /// Filters nutrition data based on selected time period
  static List<DailyNutrition> filterNutritionData(
    List<DailyNutrition> allData,
    String selectedPeriod,
  ) {
    if (allData.isEmpty) return allData;

    final sortedData = List<DailyNutrition>.from(allData)
      ..sort((a, b) => a.date.compareTo(b.date));

    switch (selectedPeriod) {
      case '90 Days':
        return _filterNutritionLastDays(sortedData, 90);
      case '6 Months':
        return _filterNutritionLastDays(sortedData, 180);
      case '1 Year':
        return _filterNutritionLastDays(sortedData, 365);
      case 'All time':
        return sortedData;
      default:
        return _filterNutritionLastDays(sortedData, 90);
    }
  }

  /// Helper method to filter weight entries by days
  static List<WeightEntry> _filterLastDays(
    List<WeightEntry> sortedData,
    int days,
  ) {
    if (sortedData.isEmpty) return sortedData;

    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final filtered = sortedData
        .where((entry) => entry.date.isAfter(cutoffDate))
        .toList();

    // If we have less data than requested period, return all available data
    if (filtered.isEmpty) return sortedData;

    return filtered;
  }

  /// Helper method to filter nutrition entries by days
  static List<DailyNutrition> _filterNutritionLastDays(
    List<DailyNutrition> sortedData,
    int days,
  ) {
    if (sortedData.isEmpty) return sortedData;

    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final filtered = sortedData
        .where((entry) => entry.date.isAfter(cutoffDate))
        .toList();

    // If we have less data than requested period, return all available data
    if (filtered.isEmpty) return sortedData;

    return filtered;
  }

  /// Gets appropriate data density for chart display based on time period
  static int getDataDensity(String selectedPeriod) {
    switch (selectedPeriod) {
      case '7 Days':
        return 1; // Show every day
      case '1 Month':
        return 2; // Show every 2nd day
      case '3 Months':
        return 7; // Show weekly points
      case '6 Months':
        return 14; // Show bi-weekly points
      case '1 Year':
        return 30; // Show monthly points
      default:
        return 1;
    }
  }

  /// Reduces data density for better chart performance and readability
  static List<WeightEntry> reduceWeightDataDensity(
    List<WeightEntry> data,
    String selectedPeriod,
  ) {
    final density = getDataDensity(selectedPeriod);
    if (density == 1) return data;

    final reducedData = <WeightEntry>[];
    for (int i = 0; i < data.length; i += density) {
      reducedData.add(data[i]);
    }

    // Always include the last entry
    if (data.isNotEmpty && !reducedData.contains(data.last)) {
      reducedData.add(data.last);
    }

    return reducedData;
  }
}
