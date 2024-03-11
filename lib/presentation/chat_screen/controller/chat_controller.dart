import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/chat_screen/models/chat_model.dart';
import 'package:flutter/material.dart';

import '../../../core/errors/ApiException.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/channel/UserChannel.dart';
import '../../messages_page/service/message_service.dart';

/// A controller class for the ChatScreen.
///
/// This class manages the state of the ChatScreen, including the
/// current chatModelObj
class ChatController extends GetxController {

  Rx<ChatModel> chatModelObj = ChatModel().obs;
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
  @override
  onInit()  async {

    selectedChnlID = Get.parameters['chnlID']!;
    apiClient = Get.find<ApiClient>();
    messageService = Get.find<MessageService>();
    prepareData();
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
}
