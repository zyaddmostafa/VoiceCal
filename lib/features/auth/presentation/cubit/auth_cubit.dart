import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/networking/api_error_model.dart';
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
