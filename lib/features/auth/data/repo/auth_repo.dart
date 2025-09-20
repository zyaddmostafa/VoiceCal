import 'dart:developer';

import '../services/supabase_auth_service.dart';

class AuthRepo {
  final SupabaseAuthService supabaseAuthService;
  AuthRepo({required this.supabaseAuthService});

  Future<void> googleSignIn() async {
    try {
      log('Starting Google sign-in process with v7');
      await supabaseAuthService.signInWithGoogle();
      log('Google sign-in completed successfully');
    } on GoogleSignInException catch (e) {
      log('GoogleSignInException: ${e.message}');

      // Handle specific GoogleSignInException cases
      if (e.message.contains('canceled')) {
        throw Exception('Sign-in canceled by user');
      } else if (e.message.contains('token')) {
        throw Exception('Failed to authenticate with Google');
      } else {
        throw Exception('Google Sign-In error: ${e.message}');
      }
    } catch (e) {
      log('General Google Sign-In error: $e');

      // Handle other types of exceptions (network, platform, etc.)
      final errorString = e.toString().toLowerCase();

      if (errorString.contains('network') ||
          errorString.contains('connection')) {
        throw Exception(
          'Network error. Please check your connection and try again.',
        );
      } else if (errorString.contains('developer_error') ||
          errorString.contains('configuration')) {
        throw Exception('Google Sign-In configuration error');
      } else {
        throw Exception('Sign-in failed. Please try again.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await supabaseAuthService.signOut();
    } on Exception catch (e) {
      log('Error during sign-out: $e');
    }
  }
}
