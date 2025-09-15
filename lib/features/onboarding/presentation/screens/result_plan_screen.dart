import 'package:flutter/material.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/nutrition/models/nutrition_plan_model.dart';
import '../../../../core/nutrition/nutrition_calculator_service.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/calories_and_Macros_model.dart';
import '../widgets/daily_recommendation/goal_bubble.dart';
import '../widgets/daily_recommendation/recommended_daily_calories_screen_body.dart';
import '../widgets/onboarding_progress_header.dart';
import '../../data/models/user_informations_model.dart';

class ResultPlanScreen extends StatefulWidget {
  const ResultPlanScreen({super.key, this.userInfo});

  final UserInformationsModel? userInfo;

  @override
  State<ResultPlanScreen> createState() => _ResultPlanScreenState();
}

class _ResultPlanScreenState extends State<ResultPlanScreen> {
  late NutritionPlanModel _nutritionPlan;
  late CaloriesAndMacrosModel _caloriesAndMacros;
  @override
  void initState() {
    super.initState();

    _nutritionPlan = NutritionCalculatorService.calculateNutritionPlan(
      widget.userInfo!,
    );

    // Use provided calories/macros or calculate new ones
    _caloriesAndMacros = CaloriesAndMacrosModel(
      calories: _nutritionPlan.dailyCalories,
      protein: _nutritionPlan.macros.proteinGrams,
      carbs: _nutritionPlan.macros.carbsGrams,
      fats: _nutritionPlan.macros.fatGrams,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            children: [
              OnboardingProgressHeader(
                progress: 1,
                onBackPressed: () {
                  // Go back to previous screen (result loading screen is removed)
                  Navigator.pop(context);
                },
              ),
              verticalSpace(12),

              GoalBubble(
                goal:
                    'Your Goal: ${widget.userInfo?.goal}  ${widget.userInfo?.weeklyGoalInKg}  kg Per Week',
              ),

              verticalSpace(24),
              const OnboardingHeader(
                title: 'Your Daily Calories & Macros Plan',
                subtitle: 'You can edit this anytime',
              ),
              verticalSpace(40),
              // Macro cards grid
              RecommendedDailyCaloriesScreenBody(
                recommendedDailyCalories: _caloriesAndMacros,
                onUpdate: _onMacroUpdate,
              ),

              verticalSpace(40),

              CustomAppButton(
                onPressed: () => _handleGetStarted(context),
                text: 'Let\'s Get Started',
              ),
              verticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }

  void _onMacroUpdate(CaloriesAndMacrosModel updatedMacros) {
    setState(() {
      _caloriesAndMacros = updatedMacros;
    });
  }

  void _handleGetStarted(BuildContext context) {
    // TODO: Navigate to next screen (main app flow)
  }
}
