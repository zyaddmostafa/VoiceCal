import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/networking/api_error_model.dart';
import '../../../auth/data/model/user_profile.dart';
import '../../../auth/data/repo/auth_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AuthRepo authRepo;

  SettingsCubit({required this.authRepo}) : super(SettingsInitial());

  Future<void> getUserProfile(String userId) async {
    emit(SettingsLoading());

    final result = await authRepo.getUserProfile(userId);

    result.when(
      onSuccess: (profile) {
        if (profile != null) {
          emit(SettingsProfileLoaded(profile: profile));
        } else {
          emit(
            SettingsError(
              apiErrorModel: ApiErrorModel(message: 'Profile not found'),
            ),
          );
        }
      },
      onError: (error) {
        emit(SettingsError(apiErrorModel: error));
      },
    );
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    emit(SettingsLoading());

    final result = await authRepo.updateUserProfile(profile);

    result.when(
      onSuccess: (_) {
        emit(SettingsProfileUpdated());
        getUserProfile(profile.userId!);
      },
      onError: (error) {
        emit(SettingsError(apiErrorModel: error));
      },
    );
  }

  /// Update specific profile fields (convenience method)
  Future<void> updateProfileFields({
    required String userId,
    String? fullName,
    String? email,
    double? height,
    double? weight,
    bool? isMale,
    String? bornDate,
    String? activityLevel,
    double? weeklyGoalInKg,
    bool? rolloverCalories,
    String? goal,
    double? desiredWeightInKg,
    int? dailyCalorieGoal,
    int? dailyProteinGoal,
    int? dailyCarbGoal,
    int? dailyFatGoal,
  }) async {
    // First get current profile
    final currentProfileResult = await authRepo.getUserProfile(userId);

    await currentProfileResult.when(
      onSuccess: (currentProfile) async {
        if (currentProfile == null) {
          emit(
            SettingsError(
              apiErrorModel: ApiErrorModel(message: 'Profile not found'),
            ),
          );

          return;
        }

        final updatedProfile = currentProfile.copyWith(
          userId: userId,
          fullName: fullName,
          email: email,
          height: height,
          weight: weight,
          isMale: isMale,
          bornDate: bornDate,
          activityLevel: activityLevel,
          weeklyGoalInKg: weeklyGoalInKg,
          rolloverCalories: rolloverCalories,
          goal: goal,
          desiredWeightInKg: desiredWeightInKg,
          dailyCalorieGoal: dailyCalorieGoal,
          dailyProteinGoal: dailyProteinGoal,
          dailyCarbGoal: dailyCarbGoal,
          dailyFatGoal: dailyFatGoal,
        );

        await updateUserProfile(updatedProfile);
      },
      onError: (error) {
        emit(SettingsError(apiErrorModel: error));
      },
    );
  }
}
