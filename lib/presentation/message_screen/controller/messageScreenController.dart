import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/models/channel/UserChannel.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

import '../../../core/constants/AppConfig.dart';
import '../../../core/service/AudioService.dart';
import '../../../data/models/message/ApiMessage.dart';
import '../../../routes/app_pages.dart';
import '../../messages_page/service/message_service.dart';

/// A controller class for the InviteFriendsScreen.
///
/// This class manages the state of the InviteFriendsScreen, including the
/// current inviteFriendsModelObj
class MessageScreenController extends  GetxController  {
  late final MessageService messageService;
  //late final EventService eventService;
  late RxMap<String,UserChannel> userChnlMap =  RxMap<String,UserChannel>();
  late Map<String,UserChannel> searchChnlMap = Map();
  TextEditingController searchController = TextEditingController();


  //RxList<UserChannel> channel = <UserChannel>[].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    //  isLoading(true);
    messageService = Get.find<MessageService>();
   // eventService = Get.put(EventService());
    getUserChannel();

  }
  Future<void> getUserChannel()
  async {
    try{
      userChnlMap.value = await messageService.getUserChannels();
      searchChnlMap = Map.fromEntries(userChnlMap.entries);
      print("User Channel Map Size:"+userChnlMap.length.toString()+" , Search Size:"+searchChnlMap.length.toString());

      /*userChnlMap.value.forEach((key, value) {
        String unreadDate = null != value.unReadDate ? value.unReadDate.toString() : 'Null';
        String unreadMsgID = null != value.unReadMsgID ? value.unReadMsgID.toString() : 'Null';
        print("Name:"+value.name+", UnReadCount:"+value.unreadCount.toString()+", UnReadDate:$unreadDate , UnreadMsgID:$unreadMsgID");
      });*/

      //userChnlMap.refresh();
    }
    catch(e, stacktrace )
    {
      logError(e, stacktrace);
    }

  }

  void setSelectedChannel(String chnlID)
  {
    // selectedChnl = Rx(userChnlMap[chnlID]!);
    //Get.toNamed(AppRoutes.chatScreen, parameters: {"chnlID" : chnlID});
    Get.rootDelegate.toNamed(Routes.CHAT_DETAILS(chnlID), parameters: {"chnlID" : chnlID});
  }


  void incrementUnreadCount(String channelId)
  {
    UserChannel? chnl = userChnlMap[channelId];
    if( null != chnl)
    {
      chnl.unreadCount.value=  chnl.unreadCount.value+1;
      //userChnlMap.refresh();
    }
    //messageService.printCurrentChannel(channelId);
  }

  void addNewMsgToChnl(String channelId, ApiMessage? msg)
  {
    if( null != msg)
    {
      UserChannel? chnl = userChnlMap[channelId];
      if( null != chnl)
      {
        chnl.unreadCount.value=  chnl.unreadCount.value+1;
        chnl.msg?.value = msg;
        //userChnlMap.refresh();
        if(AppConfig.instance.enableMsgSound)
        {
          AudioService().playNotificationSound();
        }

      }
    }
  }

  void messageScreenSearch(String searchString)
  {
    if(searchString.isEmpty)
    {
      userChnlMap.value = searchChnlMap;
    }
    else if((searchString.isNotEmpty) && (searchString.length >= 2))
    {
      userChnlMap.value = Map.fromEntries(searchChnlMap.entries.where((element) => element.value.name.isCaseInsensitiveContains(searchString)));
     // print('Searching for Value:$searchString , With Result Count:'+userChnlMap.value.length.toString());
    }


  }
}
