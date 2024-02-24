import 'package:anchor_getx/core/app_export.dart';
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
  late Rx<MessagesModel> messagesModelObj;
  late RxMap<String,UserChannel> userChnlMap =  <String, UserChannel>{}.obs;

 RxList<UserChannel> channel = <UserChannel>[].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    //  isLoading(true);
    messageService = Get.put(MessageService());
    messagesModelObj = MessagesModel().obs;
    getUserChannel();

  }


  Future<void> getUserChannel()
  async {
    try{
      // Successfully fetched products data
      ChannelResp resp = await messageService.getUserChannels();
      userChnlMap.value = Map.fromIterable(resp.channels,
          key: (e) => e.chnlId,
          value: (e) => e
      );
      /*
      Map<String,UserChannel> ucMap = Map.fromIterable(resp.channels,
        key: (e) => e.chnlId,
        value: (e) => e
      );
      */

     // channel.assignAll(resp.channels);
      userChnlMap.refresh();
      channel.refresh();


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
      chnl.unreadCount=  chnl.unreadCount+1;
      userChnlMap.refresh();
    }

    print("Updated UserChnl:$chnl");
  }


}
