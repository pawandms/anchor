import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  /*@override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<SettingsController>(
        () => SettingsController(),
      )
    ];
  }*/
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
