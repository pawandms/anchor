
part of 'app_pages.dart';

abstract class Routes {
  static const HOME = _Paths.HOME;

  static const PROFILE = _Paths.HOME + _Paths.PROFILE;
  static const SETTINGS = _Paths.SETTINGS;

  static const PRODUCTS = _Paths.HOME + _Paths.PRODUCTS;

  static const LOGIN = _Paths.LOGIN;
  static const AUTH_SCREEN = _Paths.AUTH_SCREEN;
  static const DASHBOARD = _Paths.HOME + _Paths.DASHBOARD;
  Routes._();

  static String LOGIN_THEN(Uri afterSuccessfulLogin) =>
      '$LOGIN?then=${afterSuccessfulLogin}';

  static String AUTH_THEN(Uri afterSuccessfulLogin) =>
      '$AUTH_SCREEN?then=${afterSuccessfulLogin}';


  static String PRODUCT_DETAILS(String productId) => '$PRODUCTS/$productId';
  static const NOTIFICATION = _Paths.HOME + _Paths.NOTIFICATION;
  static const SIGNUP_SCREEN = _Paths.SIGNUP_SCREEN;
  static const MESSAGES = _Paths.HOME + _Paths.MESSAGES;
  static String CHAT_DETAILS(String channelId) => '$MESSAGES/$channelId';
  static const SEARCH = _Paths.HOME + _Paths.SEARCH;

}

abstract class _Paths {
  static const HOME = '/home';
  static const PRODUCTS = '/products';
  static const PROFILE = '/profile';
  static const SETTINGS = '/settings';
  static const PRODUCT_DETAILS = '/:productId';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
  static const NOTIFICATION = '/notification';
  static const AUTH_SCREEN = '/auth_screen';
  static const SIGNUP_SCREEN = '/signup';
  static const MESSAGES = '/message';
  static const CHAT_DETAILS = '/:channelId';
  static const SEARCH = '/search';

}