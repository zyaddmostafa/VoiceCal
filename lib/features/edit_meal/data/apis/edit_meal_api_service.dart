import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../home/data/models/meal_data_response.dart';

part 'edit_meal_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class EditMealApiService {
  factory EditMealApiService(Dio dio, {String baseUrl}) = _EditMealApiService;

  @POST(ApiConstants.editMeal)
  Future<MealDataResponse> editMeal(
    @Query('meal_id') String mealId,
    @Body() Map<String, dynamic> mealText,
  );
}
