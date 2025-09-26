import 'package:flutter_test/flutter_test.dart';
import 'package:voicecal/features/analytics/data/providers/analytics_data_provider.dart';

void main() {
  group('AnalyticsDataProvider Tests', () {
    test('should generate realistic weight entries', () {
      final data = AnalyticsDataProvider.getSampleData();

      expect(data.weightEntries.length, greaterThan(25));
      expect(data.weightEntries.length, lessThanOrEqualTo(35));

      // Check weight progression is realistic (gradual decline)
      final firstWeight = data.weightEntries.first.weight;
      final lastWeight = data.weightEntries.last.weight;

      expect(firstWeight, greaterThan(lastWeight));
      expect(
        firstWeight - lastWeight,
        greaterThan(2.0),
      ); // Realistic weight loss
      expect(firstWeight - lastWeight, lessThan(5.0)); // Not too dramatic

      // Latest entry should be selected
      expect(data.weightEntries.last.isSelected, true);
    });

    test('should generate realistic nutrition data', () {
      final data = AnalyticsDataProvider.getSampleData();

      expect(data.dailyNutrition.length, equals(30));

      // Check nutrition values are in realistic ranges
      for (final nutrition in data.dailyNutrition) {
        expect(nutrition.protein, greaterThanOrEqualTo(80.0));
        expect(nutrition.protein, lessThanOrEqualTo(180.0));

        expect(nutrition.carbs, greaterThanOrEqualTo(120.0));
        expect(nutrition.carbs, lessThanOrEqualTo(280.0));

        expect(nutrition.fats, greaterThanOrEqualTo(40.0));
        expect(nutrition.fats, lessThanOrEqualTo(110.0));
      }
    });

    test('should have proper date progression', () {
      final data = AnalyticsDataProvider.getSampleData();

      // Weight entries should be ordered by date (oldest first)
      for (int i = 1; i < data.weightEntries.length; i++) {
        expect(
          data.weightEntries[i].date.isAfter(data.weightEntries[i - 1].date),
          true,
        );
      }

      // Nutrition data should be ordered by date (oldest first)
      for (int i = 1; i < data.dailyNutrition.length; i++) {
        expect(
          data.dailyNutrition[i].date.isAfter(data.dailyNutrition[i - 1].date),
          true,
        );
      }
    });

    test('should generate varied but balanced nutrition', () {
      final data = AnalyticsDataProvider.getSampleData();

      // Calculate averages
      double avgProtein = 0;
      double avgCarbs = 0;
      double avgFats = 0;

      for (final nutrition in data.dailyNutrition) {
        avgProtein += nutrition.protein;
        avgCarbs += nutrition.carbs;
        avgFats += nutrition.fats;
      }

      avgProtein /= data.dailyNutrition.length;
      avgCarbs /= data.dailyNutrition.length;
      avgFats /= data.dailyNutrition.length;

      // Check averages are in healthy ranges
      expect(avgProtein, greaterThan(100.0));
      expect(avgProtein, lessThan(150.0));

      expect(avgCarbs, greaterThan(160.0));
      expect(avgCarbs, lessThan(220.0));

      expect(avgFats, greaterThan(55.0));
      expect(avgFats, lessThan(85.0));
    });
  });
}
