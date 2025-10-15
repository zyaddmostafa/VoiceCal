import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/config/config_constants.dart';
import '../model/user_profile.dart';

class AuthLocalService {
  late final Box _userProfileBox;

  AuthLocalService() {
    _userProfileBox = Hive.box(ConfigConstants.userProfileBox);
  }

  /// Save user profile to Hive
  Future<void> saveUserProfile(UserProfile profile) async {
    await _userProfileBox.put('userProfile', profile);
  }

  /// Get user profile from Hive
  UserProfile? getUserProfile() {
    return _userProfileBox.get('userProfile') as UserProfile?;
  }

  /// Check if user profile exists in Hive
  bool hasUserProfile() {
    return _userProfileBox.containsKey('userProfile');
  }

  /// Delete user profile from Hive
  Future<void> deleteUserProfile() async {
    await _userProfileBox.delete('userProfile');
  }

  /// Clear all data from Hive
  Future<void> clearAll() async {
    await _userProfileBox.clear();
  }
}
