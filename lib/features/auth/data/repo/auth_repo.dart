import 'dart:developer';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../services/supabase_auth_service.dart';

class AuthRepo {
  final SupabaseAuthService supabaseAuthService;
  AuthRepo({required this.supabaseAuthService});

  Future<ApiResult<void>> googleSignIn() async {
    try {
      await supabaseAuthService.signInWithGoogle();

      return ApiResult.success(null);
    } catch (error) {
      log('Authentication error: $error');

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> signOut() async {
    try {
      await supabaseAuthService.signOut();

      return ApiResult.success(null);
    } catch (error) {
      log('Sign-out error: $error');

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
