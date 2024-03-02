import 'package:anchor_getx/presentation/messages_page/service/message_service.dart';
import 'package:get/get.dart';

import '../controller/messageScreenController.dart';

/// A binding class for the InviteFriendsScreen.
///
/// This class ensures that the InviteFriendsController is created when the
/// InviteFriendsScreen is first loaded.
class MessageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageScreenController());

  }
}
