import 'package:anchor_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/localization/app_localization.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(
    GetMaterialApp.router(
      title: "Application",
      binds: [
        Bind.put(AuthService()),
      ],
      translations: AppLocalization(),
      translationsKeys: AppLocalization.translationsKeys,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: AppPages.routes,
      // initialRoute: AppPages.initial,
      routerDelegate: _createDelegate(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // builder: (context, child) {
      //   return FutureBuilder<void>(
      //     key: ValueKey('initFuture'),
      //     future: Get.find<SplashService>().init(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         return child ?? SizedBox.shrink();
      //       }
      //       return SplashView();
      //     },
      //   );
      // },
      // routeInformationParser: GetInformationParser(
      //     // initialRoute: Routes.HOME,
      //     ),
      // routerDelegate: GetDelegate(
      //   backButtonPopMode: PopMode.History,
      //   preventDuplicateHandlingMode:
      //       PreventDuplicateHandlingMode.ReorderRoutes,
      // ),
    ),
  );
}

GetDelegate _createDelegate() {
  return GetDelegate(
    pages: AppPages.routes,
    navigatorObservers: <NavigatorObserver>[
      GetObserver(null, Routing()),
    ],
    pickPagesForRootNavigator: (currentNavStack) {
      final actives = Get.rootController.rootDelegate.activePages;
      final pages = <GetPage>[];
      for (var p in actives) {
        if (p != currentNavStack && p.route?.maintainState != true) {
          continue;
        }
        final q = p.currentTreeBranch.lastWhere(
            (e) => e.participatesInRootNavigator == true,
            orElse: () => p.route!);
        if (pages.contains(q)) {
          pages.remove(q);
        }
        pages.add(q);
      }
      Get.log('picked root pages: ${pages.map((e) => e.name)}');
      return pages;
    },
  );
}
