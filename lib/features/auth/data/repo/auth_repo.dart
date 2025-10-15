import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../model/user_profile.dart';
import '../services/auth_local_service.dart';
import '../services/supabase_auth_service.dart';

class AuthRepo {
  final SupabaseAuthService supabaseAuthService;
  final AuthLocalService authLocalService;

  AuthRepo({required this.supabaseAuthService, required this.authLocalService});

  Future<ApiResult<User>> googleSignIn() async {
    try {
      final authResponse = await supabaseAuthService.signInWithGoogle();

      if (authResponse.user == null) {
        throw Exception('Sign-in succeeded but user data is missing');
      }

      return ApiResult.success(authResponse.user!);
    } catch (error) {
      log('Authentication error: $error');

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> signOut() async {
    try {
      await supabaseAuthService.signOut();
      await authLocalService.clearAll();

      return ApiResult.success(null);
    } catch (error) {
      log('Sign-out error: $error');

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> createUserProfile(UserProfile userProfile) async {
    try {
      await supabaseAuthService.createUserProfile(userProfile);
      await authLocalService.saveUserProfile(userProfile);

      return ApiResult.success(null);
    } catch (error) {
      log('Create user profile error: $error');

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> updateUserProfile(UserProfile userProfile) async {
    try {
      await supabaseAuthService.updateUserProfile(userProfile);
      await authLocalService.saveUserProfile(userProfile);

      return ApiResult.success(null);
    } catch (error) {
      log('Update user profile error: $error');

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UserProfile?>> getUserProfile(String userId) async {
    try {
      // First, check if profile exists in Hive
      if (authLocalService.hasUserProfile()) {
        final localProfile = authLocalService.getUserProfile();
        log('User profile loaded from Hive cache');
        return ApiResult.success(localProfile);
      }

      // If not in Hive, fetch from Supabase
      log('User profile not in cache, fetching from Supabase');
      final profile = await supabaseAuthService.getUserProfile(userId);

      // Save to Hive for future use
      if (profile != null) {
        await authLocalService.saveUserProfile(profile);
        log('User profile saved to Hive cache');
      }

      return ApiResult.success(profile);
    } catch (error) {
      log('Get user profile error: $error');

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
