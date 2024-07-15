import 'package:get/get.dart';

import '../controller/home_screen_controller.dart';

/// A binding class for the StoriesContainerScreen.
///
/// This class ensures that the StoriesContainerController is created when the
/// StoriesContainerScreen is first loaded.
class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
