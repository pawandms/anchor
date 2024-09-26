import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:loggy/loggy.dart';

import '../core/authentication_manager.dart';
import 'app_pages.dart';

/// User cannot go to the dashboard screen if he doesn’t have a login token.
class RouteGuard extends GetMiddleware {
  final AuthenticationManager _authmanager = Get.find();


  /*
  @override
  RouteSettings? redirect(String? route) {
    _authmanager.checkLoginStatus();
    return _authmanager.isLogged.isTrue  ? null :
        const RouteSettings(name: AppRoutes.authScreen);

  }


   */

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {

    if(route.uri.toString().compareTo(Routes.LOGIN) == 0 )
    {
      return await super.redirectDelegate(route);
    }
    else if(route.uri.toString().compareTo(Routes.AUTH_SCREEN) == 0 )
    {
      return await super.redirectDelegate(route);
    }
    else {
      _authmanager.checkLoginStatus();
      bool loginStatus = _authmanager.isLoggedInValue;
      if (!loginStatus) {
        final newRoute = Routes.LOGIN_THEN(route.uri);
        print('Route Guard Change Route From :$route.uri new Route :$newRoute');
        return GetNavConfig.fromRoute(newRoute);
      }
      return await super.redirectDelegate(route);
    }


  }
}