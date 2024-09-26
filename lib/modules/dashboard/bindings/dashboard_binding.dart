import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  /*@override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<DashboardController>(
        () => DashboardController(),
      )
    ];
  }*/
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
