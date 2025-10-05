import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/meal_data_request.dart';
import '../models/meal_data.dart';
import '../services/home_api_service.dart';

class HomeRepo {
  final HomeApiService homeApiService;

  HomeRepo({required this.homeApiService});

  Future<ApiResult<MealData>> getMealData(MealDataRequest request) async {
    try {
      final response = await homeApiService.getMealData(request);

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
