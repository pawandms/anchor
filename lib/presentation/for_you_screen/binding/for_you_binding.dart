import '../controller/for_you_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ForYouScreen.
///
/// This class ensures that the ForYouController is created when the
/// ForYouScreen is first loaded.
class ForYouBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForYouController());
  }
}
