import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/config/config_constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../auth/data/model/user_profile.dart';
import '../../data/models/meal_data.dart';
import '../../data/services/nutrition_progress_calculator.dart';
import 'calories_card.dart';
import 'empty_meals_state.dart';
import 'logged_meals_list.dart';
import 'macronutrients_card.dart';
import 'today_info_card.dart';

class HomeBodyContent extends StatelessWidget {
  final List<MealData> loggedMeals;
  final bool isLoadingMeal;

  const HomeBodyContent({
    super.key,
    required this.loggedMeals,
    this.isLoadingMeal = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ValueListenableBuilder(
          valueListenable: Hive.box(
            ConfigConstants.userProfileBox,
          ).listenable(),
          builder: (context, box, _) {
            final userProfile = box.get('userProfile') as UserProfile?;

            final consumedCalories =
                NutritionProgressCalculator.getTotalCalories(loggedMeals);
            final consumedProtein = NutritionProgressCalculator.getTotalProtein(
              loggedMeals,
            );
            final consumedCarbs = NutritionProgressCalculator.getTotalCarbs(
              loggedMeals,
            );
            final consumedFats = NutritionProgressCalculator.getTotalFats(
              loggedMeals,
            );

            final goalCalories =
                userProfile?.dailyCalorieGoal?.toDouble() ?? 2000.0;
            final goalProtein =
                userProfile?.dailyProteinGoal?.toDouble() ?? 130.0;
            final goalCarbs = userProfile?.dailyCarbGoal?.toDouble() ?? 260.0;
            final goalFats = userProfile?.dailyFatGoal?.toDouble() ?? 70.0;

            return Column(
              children: [
                verticalSpace(20),
                const TodayInfoCard(),
                verticalSpace(16),
                CaloriesCard(
                  consumed: consumedCalories.toInt(),
                  goal: goalCalories.toInt(),
                ),
                verticalSpace(16),
                MacronutrientsCard(
                  consumedProtein: consumedProtein,
                  goalProtein: goalProtein,
                  consumedCarbs: consumedCarbs,
                  goalCarbs: goalCarbs,
                  consumedFats: consumedFats,
                  goalFats: goalFats,
                ),
                verticalSpace(16),
                Expanded(
                  child: loggedMeals.isEmpty
                      ? const EmptyMealsState()
                      : LoggedMealsList(meals: loggedMeals),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
