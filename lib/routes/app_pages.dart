
import 'package:anchor_getx/presentation/message_screen/binding/messageScreenBinding.dart';
import 'package:anchor_getx/presentation/message_screen/message_screen.dart';
import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/product_details/bindings/product_details_binding.dart';
import '../modules/product_details/views/product_details_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/auth_screen/auth_screen.dart';
import '../presentation/auth_screen/binding/auth_binding.dart';
import '../presentation/chat_screen/binding/chat_binding.dart';
import '../presentation/chat_screen/chat_screen.dart';
import '../presentation/log_in_screen/binding/log_in_binding.dart';
import '../presentation/log_in_screen/log_in_screen.dart';
import '../presentation/notification_screen/binding/notification_binding.dart';
import '../presentation/notification_screen/notification_screen.dart';
import '../presentation/search_screen/binding/search_binding.dart';
import '../presentation/search_screen/search_screen.dart';
import '../presentation/sign_up_screen/binding/sign_up_binding.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';
import 'route_guard.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: '/',
      page: () => RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
  /*    middlewares: [
        RouteGuard(),
      ],
*/
      children: [
        GetPage(
          name: _Paths.LOGIN,
          page: () => LogInScreen(),
          binding: LogInBinding(),
        ),
        GetPage(
          name: _Paths.AUTH_SCREEN,
          page: () => AuthScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: _Paths.AUTH_SCREEN,
          page: () => AuthScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: _Paths.SIGNUP_SCREEN,
          page: () => SignUpScreen(),
          binding: SignUpBinding(),
        ),
        GetPage(
          preventDuplicates: true,
          name: _Paths.HOME,
          page: () => HomeView(),
          binding: HomeBinding(),
          title: null,
          middlewares: [
            RouteGuard(),
          ],
          children: [
            GetPage(
              name: _Paths.DASHBOARD,
              page: () => DashboardView(),
              binding: DashboardBinding(),
              middlewares: [
                RouteGuard(),
              ],
            ),
            GetPage(
              name: _Paths.PROFILE,
              page: () => ProfileView(),
              title: 'Profile',
              //titleBuilder: () => 'Profile Builder',
              transition: Transition.size,
              binding: ProfileBinding(),
              middlewares: [
                RouteGuard(),
              ],

            ),
            GetPage(
              name: _Paths.MESSAGES,
              page: () => MessageScreen(),
              title: 'Messages',
              //titleBuilder: () => 'Profile Builder',
              transition: Transition.size,
              binding: MessageScreenBinding(),
              middlewares: [
                RouteGuard(),
              ],
              children: [
                GetPage(
                  name: _Paths.CHAT_DETAILS,
                  page: () => ChatScreen(),
                  binding: ChatBinding(),
                  middlewares: [
                    RouteGuard(),
                  ],
                )
              ]

            ),
            GetPage(
              name: _Paths.PRODUCTS,
              page: () => ProductsView(),
              title: 'Products',
              transition: Transition.zoom,
              binding: ProductsBinding(),
              children: [
                GetPage(
                  name: _Paths.PRODUCT_DETAILS,
                  page: () => ProductDetailsView(),
                  binding: ProductDetailsBinding(),
                  middlewares: [
                    RouteGuard(),
                  ],
                ),
              ],
            ),
            GetPage(
              name: _Paths.NOTIFICATION,
              page: () => NotificationScreen(),
              binding: NotificationBinding(),
            ),
            GetPage(
              name: _Paths.SEARCH,
              page: () => SearchScreen(),
              binding: SearchBinding(),
            )
          ],
        ),
        GetPage(
          name: _Paths.SETTINGS,
          page: () => SettingsView(),
          binding: SettingsBinding(),
        ),
      ],
    ),

  ];
}
