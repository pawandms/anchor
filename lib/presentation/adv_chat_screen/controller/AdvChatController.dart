
import 'package:anchor_getx/core/app_export.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../chat_screen/models/chat_model.dart';
import '../../messages_page/service/message_service.dart';
import '../data.dart';

class AdvChatController extends GetxController {
  late final MessageService messageService;

  Rx<ChatModel> chatModelObj = ChatModel().obs;
  late String chnlID;
  late ChatController chatController;
  int page = 0;
  int itemPerPage = 10;
  bool getFirstData = false;
  bool lastPage = false;


  final currentUser = ChatUser(
    id: '1',
    name: 'Flutter',
    profilePhoto: Data.profileImage,
  );

  final chatUsers =  [
  ChatUser(
  id: '2',
  name: 'Simform',
  profilePhoto: Data.profileImage,
  ),
  ChatUser(
  id: '3',
  name: 'Jhon',
  profilePhoto: Data.profileImage,
  ),
  ChatUser(
  id: '4',
  name: 'Mike',
  profilePhoto: Data.profileImage,
  ),
  ChatUser(
  id: '5',
  name: 'Rich',
  profilePhoto: Data.profileImage,
  ),
  ];

  @override
  void onInit() {
    chnlID =  Get.arguments['chnlID'] ?? 0;
    messageService = Get.find<MessageService>();
    prepareData(chnlID);
  }

  void prepareData(String chnlID)
   {
    chatController = ChatController(initialMessageList: Data.messageList,
    chatUsers: chatUsers,
      scrollController: ScrollController(),);
     messageService.getChannelMsgDetails(chnlID, page, itemPerPage);
  }


}