import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  /*@override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ProfileController>(
        () => ProfileController(),
      )
    ];
  }*/

  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
