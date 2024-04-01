import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/models/message/ApiMessage.dart';
import 'package:anchor_getx/presentation/chat_screen/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../core/errors/ApiException.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/enums/MsgType.dart';
import '../../../data/models/channel/UserChannel.dart';
import '../../messages_page/service/message_service.dart';

/// A controller class for the ChatScreen.
///
/// This class manages the state of the ChatScreen, including the
/// current chatModelObj
class ChatController extends GetxController {

 // Rx<ChatModel> chatModelObj = ChatModel().obs;
  late String selectedChnlID;
  late Rx<UserChannel> chnl;
  late final ApiClient apiClient;
  late final MessageService messageService;
  int page = 0;
  int itemPerPage = 50;
  bool getFirstData = false;
  bool lastPage = false;
  Rx<bool> isLoading = false.obs;
  late String myId;
  TextEditingController msgInputController = TextEditingController();
  ScrollController msgController = ScrollController();
  final itemScrollController = GroupedItemScrollController();
  ScrollNotification? _lastNotification;

  @override
  onInit()  async {

    selectedChnlID = Get.parameters['chnlID']!;
    apiClient = Get.find<ApiClient>();
    messageService = Get.find<MessageService>();
    prepareData();
    addListnerToMsgController();
  }

  void prepareData()
  async {
      isLoading.value = true;
      myId = apiClient.getLoggedInUserID()!;
      if(null == myId)
      {
        throw new ApiException("Invalid logged in User");
      }

    UserChannel? resp  =  await messageService.getChannelMsgDetails(selectedChnlID, page, itemPerPage);
    if( null == resp)
    {
    throw new ApiException("Unable to fetch data for selected channel:$selectedChnlID");
    }
    chnl = Rx<UserChannel>(resp);
    isLoading.value = false;
  }

  void addListnerToMsgController()
  {
    msgController.addListener(_scrollListener);
  }

  @override
  Future<void> onEndScroll() async {
    print('onEndScroll');
    if (!lastPage) {
      page += 1;
      Get.dialog(Center(child: LinearProgressIndicator()));
       prepareData();
      Get.back();
    } else {
      Get.snackbar('Alert', 'End of Repositories');
    }
  }


  @override
  Future<void> onTopScroll() async {
    print('onTopScroll');
  }

  _scrollListener() {
    if (msgController.offset >= msgController.position.maxScrollExtent &&
        !msgController.position.outOfRange) {
        print("Msg Controller Reach Bottom");

    }
    else if (msgController.offset <= msgController.position.minScrollExtent &&
        !msgController.position.outOfRange) {
      print("Msg Controller Reach Top");
    }
    else {
      print("Msg Controller is somewhare  middle");
    }
  }

  void addNewMessageToChat(String msgText)
  {
    try{
      String msgID = "new_"+DateTime.now().millisecond.toString();
      ApiMessage msg = new ApiMessage(id: msgID, type: MsgType.Text, body: msgText, createdOn: DateTime.now(), createdBy: myId, modifiedBy: myId, modifiedOn: DateTime.now());
      chnl.value.messages.add(msg);
      print("Text Msg Added to MsgList");
      setSelectedMessage(msgID);
    }
    catch(e)
    {
      
    }
  }

  void setSelectedMessage(String msgID)
  {
    itemScrollController.scrollToElement(identifier: msgID, duration: Duration(seconds: 2));
   // itemScrollController.jumpToElement(identifier: msgID);
  }


}
