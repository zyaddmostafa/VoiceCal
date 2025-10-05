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
