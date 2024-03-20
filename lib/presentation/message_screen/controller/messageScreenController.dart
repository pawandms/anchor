import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/service/EventService.dart';
import 'package:anchor_getx/data/models/channel/UserChannel.dart';
import 'package:anchor_getx/presentation/message_screen/models/message_model.dart';
import 'package:loggy/loggy.dart';

import '../../../data/enums/ChannelType.dart';
import '../../../data/models/channel/ChannelResp.dart';
import '../../messages_page/models/messages_model.dart';
import '../../messages_page/service/message_service.dart';

/// A controller class for the InviteFriendsScreen.
///
/// This class manages the state of the InviteFriendsScreen, including the
/// current inviteFriendsModelObj
class MessageScreenController extends  GetxController  {
  late final MessageService messageService;
  //late final EventService eventService;
  late RxMap<String,UserChannel> userChnlMap =  <String, UserChannel>{}.obs;

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
      userChnlMap.refresh();
    }
    catch(e)
    {
      logError(e);
    }

  }

  void incrementUnreadCount(String channelId)
  {
    UserChannel? chnl = userChnlMap[channelId];
    if( null != chnl)
    {
      chnl.unreadCount=  RxInt(chnl.unreadCount.value+1);
      userChnlMap.refresh();
    }
    messageService.printCurrentChannel(channelId);
  }

}
