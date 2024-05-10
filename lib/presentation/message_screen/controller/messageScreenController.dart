import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/models/channel/UserChannel.dart';
import 'package:loggy/loggy.dart';

import '../../../core/constants/AppConfig.dart';
import '../../../core/service/AudioService.dart';
import '../../../data/models/message/ApiMessage.dart';
import '../../messages_page/service/message_service.dart';

/// A controller class for the InviteFriendsScreen.
///
/// This class manages the state of the InviteFriendsScreen, including the
/// current inviteFriendsModelObj
class MessageScreenController extends  GetxController  {
  late final MessageService messageService;
  //late final EventService eventService;
  late RxMap<String,UserChannel> userChnlMap =  RxMap<String,UserChannel>();

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
    Get.toNamed(AppRoutes.chatScreen,
        parameters: {"chnlID" : chnlID});
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

}
