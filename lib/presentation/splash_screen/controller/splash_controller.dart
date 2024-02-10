import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/splash_screen/models/splash_model.dart';

import '../../../core/authentication_manager.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  final AuthenticationManager _authmanager = Get.find();

/*

  @override
  void onInit() {
    _authmanager.checkLoginStatus();
  }
*/

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      // Check Logged in Status
      _authmanager.checkLoginStatus();
      if(_authmanager.isLogged.isTrue)
      {
        Get.toNamed(
          AppRoutes.messageScreen,
        );
      }
      else {
        Get.toNamed(
          AppRoutes.authScreen,
        );
      }

    });
  }
}
