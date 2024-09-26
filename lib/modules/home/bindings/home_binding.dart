import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  /*@override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<HomeController>(
        () => HomeController(),
      )
    ];
  }*/

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
