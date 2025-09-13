import 'package:flutter/cupertino.dart';
import '../../features/onboarding/data/models/user_informations_model.dart';
import '../../features/onboarding/presentation/screens/born_date_screen.dart';
import '../../features/onboarding/presentation/screens/gender_selection_screen.dart';
import '../../features/onboarding/presentation/screens/goal_plan_screen.dart';
import '../../features/onboarding/presentation/screens/goal_speed_screen.dart';
import '../../features/onboarding/presentation/screens/height_and_weight_screen.dart';
import '../../features/onboarding/presentation/screens/result_plan_screen.dart';
import '../../features/onboarding/presentation/screens/edit_goal_screen.dart';
import '../../features/onboarding/presentation/screens/result_loading_screen.dart';
import '../../features/onboarding/presentation/screens/rollover_extra_cal_screen.dart';
import '../../features/onboarding/presentation/screens/desired_weight_screen.dart';
import '../../features/onboarding/presentation/screens/thank_you_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/workout_frequency_screen.dart';
import '../../features/onboarding/presentation/widgets/edit_goal/edit_goal_args.dart';
import 'routes.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.welcomeScreen:
        return CupertinoPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.genderSelectionScreen:
        return CupertinoPageRoute(
          builder: (_) => const GenderSelectionScreen(),
        );

      case Routes.heightAndWeightScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => HeightAndWeightScreen(userInfo: userInfo),
        );

      case Routes.workoutFrequencyScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => WorkoutFrequencyScreen(userInfo: userInfo),
        );

      case Routes.goalPlanScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => GoalPlanScreen(userInfo: userInfo),
        );

      case Routes.desiredWeightScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => DesiredWeightScreen(userInfo: userInfo),
        );
      case Routes.ageSelectionScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => BornDateScreen(userInfo: userInfo),
        );

      case Routes.goalSpeedScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => GoalSpeedScreen(userInfo: userInfo),
        );

      case Routes.rolloverExtraCalScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => RolloverExtraCalScreen(userInfo: userInfo),
        );

      case Routes.thankYouScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => ThankYouScreen(userInfo: userInfo),
        );
      case Routes.resultLoadingScreen:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => ResultLoadingScreen(userInfo: userInfo),
        );
      case Routes.resultPlan:
        final userInfo = arguments as UserInformationsModel?;

        return CupertinoPageRoute(
          builder: (_) => ResultPlanScreen(userInfo: userInfo),
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
