import 'package:get/get.dart';

import '../controller/message_controller.dart';

/// A binding class for the InviteFriendsScreen.
///
/// This class ensures that the InviteFriendsController is created when the
/// InviteFriendsScreen is first loaded.
class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageController());
  }
}
