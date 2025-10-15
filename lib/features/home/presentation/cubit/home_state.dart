part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetMealLoading extends HomeState {}

final class GetMealSuccess extends HomeState {
  final MealData mealData;

  GetMealSuccess({required this.mealData});
}

final class GetMealError extends HomeState {
  final ApiErrorModel apiErrorModel;

  GetMealError({required this.apiErrorModel});
}

final class UserMealsLoading extends HomeState {}

final class UserMealsSuccess extends HomeState {
  final List<MealData> meals;

  UserMealsSuccess({required this.meals});
}

final class UserMealsError extends HomeState {
  final ApiErrorModel apiErrorModel;

  UserMealsError({required this.apiErrorModel});
}
