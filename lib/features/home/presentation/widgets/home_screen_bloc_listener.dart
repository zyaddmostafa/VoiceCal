import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../data/models/meal_data.dart';
import '../cubit/home_cubit.dart';
import 'home_body_bloc_builder.dart';
import 'mic/voice_recording_fab.dart';

class HomeScreenBlocListener extends StatelessWidget {
  const HomeScreenBlocListener({
    super.key,
    required this.loggedMeals,
    required this.isLoadingMeal,
    required this.isLoadingUserMeals,
    required this.isRecording,
    required this.onMealLogged,
    required this.onUserMealsLoaded,
    required this.onLoadingChanged,
    required this.onToggleRecording,
  });

  final List<MealData> loggedMeals;
  final bool isLoadingMeal;
  final bool isLoadingUserMeals;
  final bool isRecording;
  final ValueChanged<MealData> onMealLogged;
  final ValueChanged<List<MealData>> onUserMealsLoaded;
  final ValueChanged<bool> onLoadingChanged;
  final VoidCallback onToggleRecording;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetMealLoading) {
          onLoadingChanged(true);
        } else if (state is GetMealSuccess) {
          onLoadingChanged(false);
          onMealLogged(state.mealData);
        } else if (state is GetMealError) {
          onLoadingChanged(false);
          CustomSnackbar.showError(
            context,
            state.apiErrorModel.message ?? 'Failed to log meal',
          );
        } else if (state is UserMealsSuccess) {
          onUserMealsLoaded(state.meals);
        } else if (state is UserMealsError) {
          CustomSnackbar.showError(
            context,
            state.apiErrorModel.message ?? 'Failed to load meals',
          );
        }
      },
      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            HomeBodyBlocBuilder(
              loggedMeals: loggedMeals,
              isLoadingMeal: isLoadingMeal,
              isLoadingUserMeals: isLoadingUserMeals,
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: VoiceRecordingFab(
                isRecording: isRecording,
                onPressed: onToggleRecording,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
