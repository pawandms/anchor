import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loggy/loggy.dart';

import 'core/app_export.dart';
import 'core/authentication_manager.dart';

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
  /*
  SystemChrome.setPreferredOrientations([
    //DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    //DeviceOrientation.landscapeRight,
  ]).then((value) {

    runApp(MyApp());
  });

   */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
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
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
      );
    });
  }
}
