import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/invite_friends_screen/models/invite_friends_model.dart';

/// A controller class for the InviteFriendsScreen.
///
/// This class manages the state of the InviteFriendsScreen, including the
/// current inviteFriendsModelObj
class InviteFriendsController extends GetxController {
  Rx<InviteFriendsModel> inviteFriendsModelObj = InviteFriendsModel().obs;
}
