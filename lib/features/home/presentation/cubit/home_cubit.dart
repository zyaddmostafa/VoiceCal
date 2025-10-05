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
    emit(HomeLoading());

    final result = await homeRepo.getMealData(request);

    result.when(
      onSuccess: (data) {
        emit(HomeSuccess(mealData: data));
      },
      onError: (error) {
        emit(HomeError(apiErrorModel: error));
      },
    );
  }
}
