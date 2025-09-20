import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static bool _isInitialized = false;

  static Future<void> googleInit() async {
    if (_isInitialized) return;

    final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
    if (webClientId == null || webClientId.isEmpty) {
      throw Exception('GOOGLE_WEB_CLIENT_ID not found in .env file');
    }

    await _googleSignIn.initialize(serverClientId: webClientId);

    _isInitialized = true;
    log('GoogleSignIn initialized with serverClientId');
  }

  Future<AuthResponse> signInWithGoogle() async {
    await googleInit();

    log('Starting Google Sign-In v7 with Credential Manager');

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final AuthResponse response = await Supabase.instance.client.auth
        .signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: googleAuth.idToken!,
        );

    log('Supabase sign-in successful: ${response.user?.email}');

    return response;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await Supabase.instance.client.auth.signOut();
    log('Sign out successful');
  }

  User? getCurrentUser() {
    return Supabase.instance.client.auth.currentUser;
  }

  bool get isAuthenticated {
    return Supabase.instance.client.auth.currentUser != null;
  }

  /// Attempt silent sign-in (restore previous session)
  Future<GoogleSignInAccount?> attemptSilentSignIn() async {
    // Ensure GoogleSignIn is initialized
    await googleInit();

    return await _googleSignIn.attemptLightweightAuthentication();
  }
}
