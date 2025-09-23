import '../config/config_constants.dart';
import '../config/hive_service.dart';
import '../../features/onboarding/data/models/user_informations_model.dart';

class UserLocalService extends HiveService {
  static const String _userInfoKey = 'user_info';

  static Future<void> addUserInfo(UserInformationsModel userInfo) async {
    await HiveService.addData(
      ConfigConstants.userInfoBox,
      _userInfoKey,
      userInfo,
    );
  }

  static Future<UserInformationsModel?> getUserInfo() async {
    final data = await HiveService.getData(
      ConfigConstants.userInfoBox,
      _userInfoKey,
    );

    return data as UserInformationsModel?;
  }

  static Future<void> deleteUserInfo() async {
    await HiveService.deleteData(ConfigConstants.userInfoBox, _userInfoKey);
  }
}
