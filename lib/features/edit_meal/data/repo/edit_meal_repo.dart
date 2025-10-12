import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../home/data/models/meal_data.dart';
import '../apis/edit_meal_api_service.dart';

class EditMealRepo {
  final EditMealApiService editMealApiService;

  EditMealRepo({required this.editMealApiService});

  Future<ApiResult<MealData>> editMeal(String mealId, String mealText) async {
    try {
      final body = {'meal_text': mealText};
      final response = await editMealApiService.editMeal(mealId, body);

      final meal = response.data;

      if (response.success && meal != null) {
        return ApiResult.success(meal);
      }

      return ApiResult.failure(
        ApiErrorHandler.handle(Exception(response.message)),
      );
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
