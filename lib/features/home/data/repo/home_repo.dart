import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/meal_data_request.dart';
import '../models/meal_data.dart';
import '../models/meal_data_response.dart';
import '../models/user_meals_response.dart';
import '../services/home_api_service.dart';

class HomeRepo {
  final HomeApiService homeApiService;

  HomeRepo({required this.homeApiService});

  Future<ApiResult<MealDataResponse>> getMealData(
    MealDataRequest request,
  ) async {
    try {
      final response = await homeApiService.getMealData(request);

      return ApiResult.success(response);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UserMealsResponse>> getUserMeals(String userId) async {
    try {
      final response = await homeApiService.getUserMeals(userId);

      return ApiResult.success(response);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
