import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/splash_screen/models/splash_model.dart';

import '../../../core/authentication_manager.dart';
import '../../../routes/app_pages.dart';
import '../../log_in_screen/service/login_service.dart';
import 'dart:async';
import 'package:async/async.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  final AuthenticationManager _authmanager = Get.find();
 // final LoginService  _loginService = Get.put(LoginService());

  final memo = AsyncMemoizer<void>();
  Future<void> init() {
    return memo.runOnce(_initFunction);
  }

  Future<void> _initFunction() async {
    print("Splash Controller on Ready called");
    Future.delayed(const Duration(milliseconds: 3000), () {
      // Check Logged in Status
      _authmanager.checkLoginStatus();
      if(_authmanager.isLogged.isTrue)
      {
        Get.toNamed(
            Routes.HOME
        );
      }
      else {
        Get.toNamed(
          Routes.LOGIN,
        );
      }

    });

  }

/*
  @override
  void onInit() {
    LoginService  _loginService = Get.put(LoginService());
  }
*/

  /*
  @override
  void onReady() {
    print("Splash Controller on Ready called");
    Future.delayed(const Duration(milliseconds: 3000), () {
      // Check Logged in Status
      _authmanager.checkLoginStatus();
      if(_authmanager.isLogged.isTrue)
      {
        Get.toNamed(
          AppRoutes.homeScreen,
        );
      }
      else {
        Get.toNamed(
          AppRoutes.authScreen,
        );
      }

    });
  }
  */
}
