import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  final count = 0.obs;
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  @override
  void onInit() {
    super.onInit();
  }

  // function to switch between themes
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
