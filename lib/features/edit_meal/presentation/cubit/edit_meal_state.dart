part of 'edit_meal_cubit.dart';

@immutable
sealed class EditMealState {}

final class EditMealInitial extends EditMealState {}

final class EditMealLoading extends EditMealState {}

final class EditMealSuccess extends EditMealState {
  final MealData mealData;

  EditMealSuccess({required this.mealData});
}

final class EditMealError extends EditMealState {
  final ApiErrorModel apiErrorModel;

  EditMealError({required this.apiErrorModel});
}
