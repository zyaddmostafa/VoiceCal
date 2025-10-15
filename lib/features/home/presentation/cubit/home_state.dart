part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final MealData mealData;

  HomeSuccess({required this.mealData});
}

final class HomeError extends HomeState {
  final ApiErrorModel apiErrorModel;

  HomeError({required this.apiErrorModel});
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
