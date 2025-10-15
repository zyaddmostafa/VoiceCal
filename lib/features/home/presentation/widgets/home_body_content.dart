import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../auth/data/model/user_profile.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../data/models/meal_data.dart';
import '../../data/services/nutrition_progress_calculator.dart';
import 'calories/calories_card.dart';
import 'logged_meals/empty_meals_state.dart';
import 'logged_meals/logged_meals_list.dart';
import 'macros/macronutrients_card.dart';
import 'today_info_card.dart';

class HomeBodyContent extends StatelessWidget {
  final List<MealData> loggedMeals;
  final bool isLoadingMeal;
  final bool isLoadingUserMeals;

  const HomeBodyContent({
    super.key,
    required this.loggedMeals,
    this.isLoadingMeal = false,
    this.isLoadingUserMeals = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        UserProfile? userProfile;

        if (authState is UserProfileLoaded) {
          userProfile = authState.userProfile;
        }

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(20),
                const TodayInfoCard(),
                verticalSpace(16),
                CaloriesCard(
                  consumed: NutritionProgressCalculator.getTotalCalories(
                    loggedMeals,
                  ).toInt(),
                  goal: userProfile?.dailyCalorieGoal ?? 2000,
                ),
                verticalSpace(16),
                MacronutrientsCard(
                  consumedProtein: NutritionProgressCalculator.getTotalProtein(
                    loggedMeals,
                  ),
                  goalProtein:
                      userProfile?.dailyProteinGoal?.toDouble() ?? 130.0,
                  consumedCarbs: NutritionProgressCalculator.getTotalCarbs(
                    loggedMeals,
                  ),
                  goalCarbs: userProfile?.dailyCarbGoal?.toDouble() ?? 260.0,
                  consumedFats: NutritionProgressCalculator.getTotalFats(
                    loggedMeals,
                  ),
                  goalFats: userProfile?.dailyFatGoal?.toDouble() ?? 70.0,
                ),
                verticalSpace(16),
                Expanded(child: _buildMealsSection(authState)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMealsSection(AuthState authState) {
    // Show loading indicator while user profile is loading
    if (authState is UserProfileLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    // Show loading indicator while meals are loading
    if (isLoadingUserMeals) {
      return const Center(child: CupertinoActivityIndicator());
    }

    // Show empty state if no meals
    if (loggedMeals.isEmpty) {
      return const EmptyMealsState();
    }

    // Show meals list
    return LoggedMealsList(meals: loggedMeals);
  }
}
