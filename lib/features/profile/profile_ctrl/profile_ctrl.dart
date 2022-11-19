import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/app_pages.dart';

class ProfileCtrl extends GetxController {
  final SharedPreferences sharedPreferences;
  ProfileCtrl({
    required this.sharedPreferences,
  });
  
  void logOut() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Get.offNamedUntil(Routes.SIGN_IN, (route) => false);
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }
}
