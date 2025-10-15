import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/networking/api_error_model.dart';
import '../../data/models/meal_data_request.dart';
import '../../data/models/meal_data.dart';
import '../../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  void getMealData({required MealDataRequest request}) async {
    emit(GetMealLoading());

    final result = await homeRepo.getMealData(request);

    result.when(
      onSuccess: (meal) {
        emit(GetMealSuccess(mealData: meal.data!));
        getUserMeals(userId: request.userId);
      },
      onError: (error) {
        emit(GetMealError(apiErrorModel: error));
      },
    );
  }

  void getUserMeals({required String userId}) async {
    emit(UserMealsLoading());

    final result = await homeRepo.getUserMeals(userId);

    result.when(
      onSuccess: (userMeals) {
        emit(UserMealsSuccess(meals: userMeals.data!));
      },
      onError: (error) {
        emit(UserMealsError(apiErrorModel: error));
      },
    );
  }
}
