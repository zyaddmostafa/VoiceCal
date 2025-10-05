import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/service/supabase_constants.dart';
import '../model/user_profile.dart';

class SupabaseAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static bool _isInitialized = false;

  static Future<void> googleInit() async {
    if (_isInitialized) return;

    final webClientId =
        '979319094193-8jitdm1kdrrhfab2ohvvb5f57q06c0d2.apps.googleusercontent.com';
    if (webClientId.isEmpty) {
      throw Exception('webClientId not found in .env file');
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

  static bool get isAuthenticated {
    return Supabase.instance.client.auth.currentUser != null;
  }

  /// Attempt silent sign-in (restore previous session)
  Future<GoogleSignInAccount?> attemptSilentSignIn() async {
    // Ensure GoogleSignIn is initialized
    await googleInit();

    return await _googleSignIn.attemptLightweightAuthentication();
  }

  Future<void> createUserProfile(UserProfile userProfile) async {
    final user = getCurrentUser();

    await Supabase.instance.client
        .from(SupabaseConstants.supabaseProfileTable)
        .insert(userProfile.toJson());

    log(
      'User profile created successfully for userId: ${user?.id ?? "no id found"}',
    );
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    final user = getCurrentUser();

    await Supabase.instance.client
        .from(SupabaseConstants.supabaseProfileTable)
        .upsert(userProfile.toJson(), onConflict: 'id');

    log(
      'User profile updated successfully for userId: ${user?.id ?? "no id found"}',
    );
  }

  Future<UserProfile?> getUserProfile(String userId) async {
    final response = await Supabase.instance.client
        .from(SupabaseConstants.supabaseProfileTable)
        .select()
        .eq('id', userId)
        .maybeSingle();

    log('Profile fetched successfully for userId: $userId');

    return response == null ? null : UserProfile.fromJson(response);
  }
}
