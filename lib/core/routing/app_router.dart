import 'package:flutter/cupertino.dart';
import '../../features/onboarding/presentation/screens/gender_selection_screen.dart';
import '../../features/onboarding/presentation/screens/goal_plan_screen.dart';
import '../../features/onboarding/presentation/screens/height_and_weight_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/workout_frequency_screen.dart';
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

      default:
        return null;
    }
  }
}
