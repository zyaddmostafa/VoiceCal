import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  static const String webClientId =
      '979319094193-8jitdm1kdrrhfab2ohvvb5f57q06c0d2.apps.googleusercontent.com';

  // Simple GoogleSignIn instance for v7
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<AuthResponse> signInWithGoogle() async {
    try {
      log('Starting Google Sign-In v7 with Credential Manager');

      // Use authenticate() method for v7
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        throw GoogleSignInException('Sign-in was canceled by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw GoogleSignInException('Failed to get Google ID token');
      }

      // Sign in to Supabase with the Google ID token
      final AuthResponse response = await Supabase.instance.client.auth
          .signInWithIdToken(
            provider: OAuthProvider.google,
            idToken: googleAuth.idToken!,
          );

      log('Google Sign-In successful');
      return response;
    } catch (e) {
      log('Google Sign-In error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await Supabase.instance.client.auth.signOut();
      log('Sign out successful');
    } catch (e) {
      log('Sign out error: $e');
      rethrow;
    }
  }

  User? getCurrentUser() {
    return Supabase.instance.client.auth.currentUser;
  }

  bool get isAuthenticated {
    return Supabase.instance.client.auth.currentUser != null;
  }

  /// Attempt silent sign-in (restore previous session)
  Future<GoogleSignInAccount?> attemptSilentSignIn() async {
    try {
      return await _googleSignIn.attemptLightweightAuthentication();
    } catch (e) {
      log('Silent sign-in failed: $e');
      return null;
    }
  }
}

class GoogleSignInException implements Exception {
  final String message;
  GoogleSignInException(this.message);

  @override
  String toString() => 'GoogleSignInException: $message';
}
