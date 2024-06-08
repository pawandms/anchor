import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/log_in_screen/models/log_in_model.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

import '../../../core/authentication_manager.dart';
import '../../../core/utils/my_dialog.dart';
import '../models/login_request_model.dart';
import '../service/login_service.dart';

/// A controller class for the LogInScreen.
///
/// This class manages the state of the LogInScreen, including the
/// current logInModelObj
class LogInController extends GetxController {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<LogInModel> logInModelObj = LogInModel().obs;

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loginService = Get.put(LoginService());
  //  _loginService = Get.find();
    emailController.text = 'user1@anchor.com';
    passwordController.text = 'Mumbai@123';
    _authManager = Get.find();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }


  Future<void> loginUser() async {
    try {
      isLoading(true);
      String email = emailController.text;
      String password = passwordController.text;

      final response = await _loginService
          .fetchLogin(LoginRequestModel(email: email, password: password));

      if ((response != null) & (response?.valid == true)) {
        /// Set isLogin to true
        _authManager.login(response!);
        Get.toNamed(
          AppRoutes.messageScreen,
        );

      } else {
        if( null != response)
         {
           MyDialog.showCustomSnackBar(response.error_description, isError: true, title: 'Exception');
         }
        else {
          MyDialog.showCustomSnackBar('err_msg_invalid_email_pass'.tr, isError: true, title: 'Exception');
        }

      }

    }
    catch(e)
    {
      logError("LoginController SignIn  Error:$e");
    }
    finally{
      isLoading(false);
  }

    }
  }
  /*
  @override
  void onReady() {
    Get.toNamed(
      AppRoutes.forgotPasswordScreen,
    );
  }

   */

