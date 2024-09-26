import 'package:get/get.dart';

import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  /*@override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<RootController>(
        () => RootController(),
      )
    ];
  }*/

  @override
  void dependencies() {
    Get.lazyPut(() => RootController());
  }
}
