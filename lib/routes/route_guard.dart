import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:loggy/loggy.dart';

import '../core/authentication_manager.dart';

/// User cannot go to the dashboard screen if he doesn’t have a login token.
class RouteGuard extends GetMiddleware {
  final AuthenticationManager _authmanager = Get.find();


  @override
  RouteSettings? redirect(String? route) {
    _authmanager.checkLoginStatus();
    return _authmanager.isLogged.isTrue  ? null :
        const RouteSettings(name: AppRoutes.authScreen);

  }
}