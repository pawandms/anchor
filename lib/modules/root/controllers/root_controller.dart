import 'package:get/get.dart';

import '../../../core/authentication_manager.dart';
import '../../../routes/app_pages.dart';

class RootController extends GetxController {

  final AuthenticationManager _authmanager = Get.find();

  String initalRoute = Routes.HOME;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus()
  {
    bool loginStatus = _authmanager.isUserLoggedIn();
    if (!loginStatus) {
      initalRoute = Routes.AUTH_SCREEN;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
