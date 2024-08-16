import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  var selectedLanguage = Get.locale?.languageCode.obs;


  @override
  void onInit() {
    print('Selected Language Code:$Get.locale?.languageCode');
  } // function to switch between themes
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  set changeLanguage(String lang) {
    print('Changing Language to :$lang');
    Locale locale = Locale(lang);
    Get.updateLocale(locale);
    selectedLanguage?.value = lang;
  }
}
