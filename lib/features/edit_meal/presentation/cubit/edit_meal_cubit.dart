import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/networking/api_error_model.dart';
import '../../../home/data/models/meal_data.dart';
import '../../data/repo/edit_meal_repo.dart';

part 'edit_meal_state.dart';

class EditMealCubit extends Cubit<EditMealState> {
  final EditMealRepo editMealRepo;

  EditMealCubit({required this.editMealRepo}) : super(EditMealInitial());

  void editMeal({required String mealId, required String mealText}) async {
    emit(EditMealLoading());

    final result = await editMealRepo.editMeal(mealId, mealText);

    result.when(
      onSuccess: (data) {
        emit(EditMealSuccess(mealData: data));
      },
      onError: (error) {
        emit(EditMealError(apiErrorModel: error));
      },
    );
  }
}
