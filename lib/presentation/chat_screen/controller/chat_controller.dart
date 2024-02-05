import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/chat_screen/models/chat_model.dart';

/// A controller class for the ChatScreen.
///
/// This class manages the state of the ChatScreen, including the
/// current chatModelObj
class ChatController extends GetxController {
  Rx<ChatModel> chatModelObj = ChatModel().obs;
}
