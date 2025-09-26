import '../../data/models/analytics_data.dart';
import '../../data/models/weight_entry.dart';
import '../../data/models/daily_nutrition.dart';

class AnalyticsDataProvider {
  static AnalyticsData getSampleData() {
    return AnalyticsData(
      weightEntries: _generateRealisticWeightEntries(),
      dailyNutrition: _generateRealisticNutritionData(),
    );
  }

  /// Generates realistic weight progression data for a full year
  /// Simulates a gradual weight loss journey with natural fluctuations
  static List<WeightEntry> _generateRealisticWeightEntries() {
    final now = DateTime.now();
    final List<WeightEntry> entries = [];

    // Starting weight: 85.0 kg, target: gradual loss to 75.0 kg over 365 days
    const double startWeight = 85.0;
    const double endWeight = 75.0;
    const int totalDays = 365;
    for (int i = 0; i <= totalDays; i++) {
      final date = now.subtract(Duration(days: totalDays - i));

      // Calculate base weight with gradual decline
      final progress = i / totalDays;
      final baseWeight = startWeight - ((startWeight - endWeight) * progress);

      // Add realistic daily fluctuations (-0.3 to +0.4 kg)
      final fluctuation = _getWeightFluctuation(i);
      final actualWeight = double.parse(
        (baseWeight + fluctuation).toStringAsFixed(1),
      );

      entries.add(
        WeightEntry(
          weight: actualWeight,
          date: date,
          isSelected: i == totalDays, // Latest entry is selected
        ),
      );
    }

    return entries;
  }

  /// Generates realistic daily nutrition data for the past year
  /// Simulates varied but balanced nutrition intake with realistic patterns
  static List<DailyNutrition> _generateRealisticNutritionData() {
    final now = DateTime.now();
    final List<DailyNutrition> nutritionData = [];

    for (int i = 0; i < 365; i++) {
      final date = now.subtract(Duration(days: 364 - i));
      final isWeekend = date.weekday >= 6;

      // Generate realistic nutrition values based on day type
      final nutrition = _generateDayNutrition(i, isWeekend);
      nutritionData.add(
        DailyNutrition(
          date: date,
          protein: nutrition['protein']!.toDouble(),
          carbs: nutrition['carbs']!.toDouble(),
          fats: nutrition['fats']!.toDouble(),
        ),
      );
    }

    return nutritionData;
  }

  /// Calculates realistic weight fluctuation based on day pattern
  static double _getWeightFluctuation(int day) {
    // Simulate weekly patterns and random fluctuations
    final weekDay = day % 7;
    double baseFluct = 0.0;

    // Weekend weight gains (days 5-6 in week)
    if (weekDay >= 5) {
      baseFluct += 0.2;
    }

    // Monday drops (day 1)
    if (weekDay == 1) {
      baseFluct -= 0.3;
    }

    // Add random daily variation (-0.2 to +0.3 kg)
    final random = (day * 17 + 31) % 100; // Pseudo-random based on day
    final randomFluct = (random / 100.0 - 0.3) * 0.5;

    return baseFluct + randomFluct;
  }

  /// Generates nutrition values for a specific day
  static Map<String, int> _generateDayNutrition(int dayIndex, bool isWeekend) {
    // Base values for balanced nutrition
    int protein = 120; // grams - good protein intake
    int carbs = 180; // grams - moderate carb intake
    int fats = 65; // grams - healthy fat intake

    // Weekend variations (higher calories, more indulgent)
    if (isWeekend) {
      protein += 15; // Weekend protein boost
      carbs += 40; // More carbs on weekends
      fats += 20; // Higher fat intake
    }

    // Weekly patterns and individual day variations
    final weekDay = dayIndex % 7;

    // Monday - lighter day after weekend
    if (weekDay == 1) {
      protein -= 10;
      carbs -= 25;
      fats -= 10;
    }

    // Wednesday - mid-week balance
    if (weekDay == 3) {
      protein += 5;
      carbs -= 10;
    }

    // Friday - pre-weekend increase
    if (weekDay == 5) {
      carbs += 15;
      fats += 8;
    }

    // Add daily variation (±10-15% realistic fluctuation)
    final variation = (dayIndex * 13 + 47) % 20 - 10; // -10 to +10
    final factor = 1.0 + (variation / 100.0);

    protein = (protein * factor).round();
    carbs = (carbs * factor).round();
    fats = (fats * factor).round();

    // Ensure realistic ranges
    protein = protein.clamp(80, 180); // 80-180g protein
    carbs = carbs.clamp(120, 280); // 120-280g carbs
    fats = fats.clamp(40, 110); // 40-110g fats

    return {'protein': protein, 'carbs': carbs, 'fats': fats};
  }
}
