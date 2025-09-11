import 'package:flutter/cupertino.dart';
import '../../features/onboarding/presentation/screens/born_date_screen.dart';
import '../../features/onboarding/presentation/screens/gender_selection_screen.dart';
import '../../features/onboarding/presentation/screens/goal_plan_screen.dart';
import '../../features/onboarding/presentation/screens/goal_speed_screen.dart';
import '../../features/onboarding/presentation/screens/height_and_weight_screen.dart';
import '../../features/onboarding/presentation/screens/recommended_daily_cal_and_macros_screen.dart';
import '../../features/onboarding/presentation/screens/edit_goal_screen.dart';
import '../../features/onboarding/presentation/screens/rollover_extra_cal_screen.dart';
import '../../features/onboarding/presentation/screens/desired_weight_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/workout_frequency_screen.dart';
import '../../features/onboarding/presentation/widgets/edit_goal/edit_goal_args.dart';
import 'routes.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.welcomeScreen:
        return CupertinoPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.genderSelectionScreen:
        return CupertinoPageRoute(
          builder: (_) => const GenderSelectionScreen(),
        );

      case Routes.heightAndWeightScreen:
        return CupertinoPageRoute(
          builder: (_) => const HeightAndWeightScreen(),
        );

      case Routes.workoutFrequencyScreen:
        return CupertinoPageRoute(
          builder: (_) => const WorkoutFrequencyScreen(),
        );

      case Routes.goalPlanScreen:
        return CupertinoPageRoute(builder: (_) => const GoalPlanScreen());

      case Routes.desiredWeightScreen:
        final goal = arguments as String?;

        return CupertinoPageRoute(
          builder: (_) => DesiredWeightScreen(goal: goal!),
        );
      case Routes.ageSelectionScreen:
        return CupertinoPageRoute(builder: (_) => const BornDateScreen());
      case Routes.goalSpeedScreen:
        return CupertinoPageRoute(builder: (_) => const GoalSpeedScreen());
      case Routes.rolloverExtraCalScreen:
        return CupertinoPageRoute(
          builder: (_) => const RolloverExtraCalScreen(),
        );
      case Routes.recommendedDailyCalAndMacrosScreen:
        return CupertinoPageRoute(
          builder: (_) => const RecommendedDailyCalAndMacrosScreen(),
        );
      case Routes.editGoalScreen:
        final editRecommendedPlan = arguments as EditGoalArgs?;

        return CupertinoPageRoute(
          builder: (_) =>
              EditGoalScreen(editRecommendedPlan: editRecommendedPlan),
        );
      default:
        return null;
    }
  }
}
