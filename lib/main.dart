import 'package:anchor_getx/presentation/splash_screen/controller/splash_controller.dart';
import 'package:anchor_getx/presentation/splash_screen/splash_screen.dart';
import 'package:anchor_getx/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loggy/loggy.dart';

import 'core/app_export.dart';
import 'core/authentication_manager.dart';
import 'modules/splash/controllers/splash_service.dart';
import 'modules/splash/views/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Get.put<GetConnect>(GetConnect()); //initializing GetConnect
  await GetStorage.init();
  await Get.putAsync(() => AuthenticationManager().init());
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.off,
    ),
  );
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
       theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      ),
        translations: AppLocalization(),
        locale: Get.deviceLocale, //for setting localization strings
        fallbackLocale: Locale('en', 'US'),
        title: 'anchor_getx',
        initialBinding: InitialBindings(),
          getPages: AppPages.routes,
          /*
          builder: (context, child) {
            return FutureBuilder<void>(
             // key: ValueKey('initFuture'),
              future: Get.find<SplashService>().init(),
             // future: Get.find<SplashController>().init(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return child ?? SizedBox.shrink();
                }
                return SplashView();
               // return SplashScreen();
              },
            );
          }
          */
      );
    });
  }
}


