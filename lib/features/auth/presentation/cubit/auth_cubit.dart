import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/networking/api_error_model.dart';
import '../../data/model/user_profile.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  googleSignIn({
    required int dailyCalorieGoal,
    required int dailyProteinGoal,
    required int dailyCarbGoal,
    required int dailyFatGoal,
  }) async {
    emit(AuthLoading());

    final result = await authRepo.googleSignIn();

    await result.when(
      onSuccess: (user) async {
        await _handleUserProfile(
          user: user,
          dailyCalorieGoal: dailyCalorieGoal,
          dailyProteinGoal: dailyProteinGoal,
          dailyCarbGoal: dailyCarbGoal,
          dailyFatGoal: dailyFatGoal,
        );
      },
      onError: (error) {
        emit(AuthError(error: error.message ?? 'Google sign-in failed'));
      },
    );
  }

  Future<void> _handleUserProfile({
    required User user,
    required int dailyCalorieGoal,
    required int dailyProteinGoal,
    required int dailyCarbGoal,
    required int dailyFatGoal,
  }) async {
    final existingProfileResult = await authRepo.getUserProfile(user.id);

    await existingProfileResult.when(
      onSuccess: (existingProfile) async {
        if (existingProfile != null) {
          emit(AuthSuccess(userProfile: existingProfile));
        } else {
          await _createUserProfile(
            user: user,
            dailyCalorieGoal: dailyCalorieGoal,
            dailyProteinGoal: dailyProteinGoal,
            dailyCarbGoal: dailyCarbGoal,
            dailyFatGoal: dailyFatGoal,
          );
        }
      },
      onError: (error) {
        emit(
          AuthError(
            error:
                'Sign-in successful but failed to fetch profile: ${error.message ?? "Unknown error"}',
          ),
        );
      },
    );
  }

  Future<void> _createUserProfile({
    required User user,
    required int dailyCalorieGoal,
    required int dailyProteinGoal,
    required int dailyCarbGoal,
    required int dailyFatGoal,
  }) async {
    final userProfile = UserProfile(
      userId: user.id,
      fullName: user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
      email: user.email,
      dailyCalorieGoal: dailyCalorieGoal,
      dailyProteinGoal: dailyProteinGoal,
      dailyCarbGoal: dailyCarbGoal,
      dailyFatGoal: dailyFatGoal,
    );

    final profileResult = await authRepo.createUserProfile(userProfile);

    profileResult.when(
      onSuccess: (_) {
        emit(AuthSuccess(userProfile: userProfile));
      },
      onError: (error) {
        emit(
          AuthError(
            error:
                'Sign-in successful but failed to create profile: ${error.message ?? "Unknown error"}',
          ),
        );
      },
    );
  }

  signOut() async {
    emit(AuthLoading());
    final result = await authRepo.signOut();
    result.when(
      onSuccess: (_) {
        emit(AuthSignOutSuccess());
      },
      onError: (error) {
        emit(AuthError(error: error.message!));
      },
    );
  }

  updateUserProfile({required userProfile}) async {
    emit(AuthProfileLoading());
    final result = await authRepo.updateUserProfile(userProfile);
    result.when(
      onSuccess: (_) {
        emit(AuthProfileSuccess());
      },
      onError: (error) {
        emit(AuthProfileError(error: error));
      },
    );
  }
}
