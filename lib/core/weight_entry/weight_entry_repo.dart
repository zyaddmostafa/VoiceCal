import '../networking/api_error_handler.dart';
import '../networking/api_result.dart';
import 'weight_entry_api_service.dart';

/// Repository for managing weight entries
/// Shared across Auth, Settings, and Analytics features
class WeightEntryRepo {
  final WeightEntryApiService weightEntryApiService;

  WeightEntryRepo({required this.weightEntryApiService});

  /// Add weight entry with error handling
  Future<ApiResult<void>> addWeightEntry({
    required String userId,
    required double weight,
    required String entryDate,
  }) async {
    try {
      await weightEntryApiService.addWeightEntry(
        userId: userId,
        weight: weight,
        entryDate: entryDate,
      );

      return ApiResult.success(null);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Update weight entry with error handling
  Future<ApiResult<void>> updateWeightEntry({
    required String userId,
    required String entryDate,
    required double weight,
  }) async {
    try {
      await weightEntryApiService.updateWeightEntry(
        userId: userId,
        entryDate: entryDate,
        weight: weight,
      );

      return ApiResult.success(null);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Delete weight entry with error handling
  Future<ApiResult<void>> deleteWeightEntry({
    required String userId,
    required String entryDate,
  }) async {
    try {
      await weightEntryApiService.deleteWeightEntry(
        userId: userId,
        entryDate: entryDate,
      );

      return ApiResult.success(null);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
