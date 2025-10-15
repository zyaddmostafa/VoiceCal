import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/networking/api_error_model.dart';
import '../../../../core/weight_entry/weight_entry_repo.dart';
import '../../data/model/user_profile.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  googleSignIn({required UserProfile userProfile}) async {
    emit(AuthLoading());

    final result = await authRepo.googleSignIn();

    await result.when(
      onSuccess: (user) async {
        await _handleUserProfile(
          userProfile: userProfile.copyWith(
            userId: user.id,
            email: user.email,
            fullName:
                user.userMetadata?['full_name'] ??
                user.userMetadata?['name'] ??
                'none',
          ),
        );
      },
      onError: (error) {
        emit(AuthError(error: error.message ?? 'Google sign-in failed'));
      },
    );
  }

  Future<void> _handleUserProfile({required UserProfile userProfile}) async {
    final existingProfileResult = await authRepo.getUserProfile(
      userProfile.userId!,
    );

    await existingProfileResult.when(
      onSuccess: (existingProfile) async {
        if (existingProfile != null) {
          emit(AuthSuccess(userProfile: existingProfile));
        } else {
          await _createUserProfile(userProfile: userProfile);
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

  Future<void> _createUserProfile({required UserProfile userProfile}) async {
    final profileResult = await authRepo.createUserProfile(userProfile);

    await profileResult.when(
      onSuccess: (_) async {
        // Add initial weight entry after successful profile creation
        await _addInitialWeightEntry(userProfile);
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

  Future<void> _addInitialWeightEntry(UserProfile userProfile) async {
    try {
      final weightEntryRepo = getIt<WeightEntryRepo>();
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      await weightEntryRepo.addWeightEntry(
        userId: userProfile.userId!,
        weight: userProfile.weight ?? 0,
        entryDate: today,
      );
      log(
        'Initial weight entry added for user ${userProfile.userId} on $today , ${userProfile.weight}kg',
      );
    } catch (e) {
      // Silent fail - don't block user sign-in if weight entry fails
      // User can add weight manually later
    }
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

  getUserProfile({required String userId}) async {
    emit(UserProfileLoading());
    final result = await authRepo.getUserProfile(userId);
    result.when(
      onSuccess: (profile) {
        if (profile != null) {
          emit(UserProfileLoaded(userProfile: profile));
        } else {
          emit(
            UserProfileError(
              error: ApiErrorModel(message: 'User profile not found'),
            ),
          );
        }
      },
      onError: (error) {
        emit(UserProfileError(error: error));
      },
    );
  }
}
