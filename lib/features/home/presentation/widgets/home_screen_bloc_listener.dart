import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../data/models/meal_data.dart';
import '../cubit/home_cubit.dart';
import 'home_body_content.dart';
import 'mic/voice_recording_fab.dart';

class HomeScreenBlocListener extends StatelessWidget {
  const HomeScreenBlocListener({
    super.key,
    required this.loggedMeals,
    required this.isLoadingMeal,
    required this.isRecording,
    required this.onMealLogged,
    required this.onLoadingChanged,
    required this.onToggleRecording,
  });

  final List<MealData> loggedMeals;
  final bool isLoadingMeal;
  final bool isRecording;
  final ValueChanged<MealData> onMealLogged;
  final ValueChanged<bool> onLoadingChanged;
  final VoidCallback onToggleRecording;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoading) {
          onLoadingChanged(true);
        } else if (state is HomeSuccess) {
          onLoadingChanged(false);
          onMealLogged(state.mealData);
        } else if (state is HomeError) {
          onLoadingChanged(false);
          CustomSnackbar.showError(
            context,
            state.apiErrorModel.message ?? 'Failed to log meal',
          );
        }
      },
      child: Scaffold(
        body: HomeBodyContent(
          loggedMeals: loggedMeals,
          isLoadingMeal: isLoadingMeal,
        ),
        floatingActionButton: VoiceRecordingFab(
          isRecording: isRecording,
          onPressed: onToggleRecording,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
