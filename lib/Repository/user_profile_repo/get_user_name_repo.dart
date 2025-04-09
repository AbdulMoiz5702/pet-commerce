

import '../../core/constants/app_constant/app_constant.dart';

class GetUserName {

  static Future<void> getUserName() async {
    final response = await AppConstants.supaBase.from(AppConstants.userProfileTable).select('name').eq('user_id', AppConstants.currentUser!.id).single();
    userName = response['name'] ?? '';
    print('User name: $userName');
  }
}