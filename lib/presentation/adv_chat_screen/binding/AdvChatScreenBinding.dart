
import 'package:anchor_getx/presentation/adv_chat_screen/controller/AdvChatController.dart';
import 'package:get/get.dart';

class AdvChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvChatController());
  }
}