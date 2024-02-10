import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/message_screen/models/message_model.dart';

/// A controller class for the InviteFriendsScreen.
///
/// This class manages the state of the InviteFriendsScreen, including the
/// current inviteFriendsModelObj
class MessageController extends GetxController {
  Rx<MessageModel> inviteFriendsModelObj = MessageModel().obs;
}
