
import 'dart:html';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:anchor_getx/core/service/AudioService.dart';
import 'package:anchor_getx/data/enums/ChannelType.dart';
import 'package:anchor_getx/data/models/channel/ChannelResp.dart';
import 'package:loggy/loggy.dart';

import '../../../core/errors/ApiException.dart';
import '../../../core/service/EventService.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/channel/UserChannel.dart';
import '../../../data/models/message/Message.dart';

class MessageService extends GetxService  {

  //final GetConnect connect = Get.find<GetConnect>();
  late final ApiClient apiClient;
  late final EventService eventService;
  bool dataLoaded = false;
  late RxMap<String,UserChannel> userChnlMap =  <String, UserChannel>{}.obs;

  @override
  void onInit() {
    apiClient = Get.find<ApiClient>();
    eventService = Get.find<EventService>();
  }

/*
  Future<List<StateModel>> getStateModel()
  async {
    late List<StateModel> modelList;
    try{
      const String url =
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

      final response = await connect.get(url,headers:{}, contentType : null, query: {});
      modelList = StateModel.listFromJson(response.body);
    }
    catch(e)
    {

    }

    return modelList;
}

 */

  Future<Map<String,UserChannel>> getUserChannels() async
  {
    ChannelResp resp;
    try{
      if(!dataLoaded)
      {
        print("MsgService:getUserChannel Called");
        String? userID = apiClient.getLoggedInUserID();
        if(null == userID)
        {
          throw new ApiException("Invalid logged in User");
        }

        // String chnlUrl = EnvConfig.getChannel;
        Map<String, dynamic>? queryParam = {'userID': userID, 'chnlType': ChannelType.Messaging.name};
        String getChnlUrl = EnvConfig.getMsgChnlUrl(userID);
        final response = await apiClient.get(getChnlUrl,headers:{}, contentType : null, query: {});
        print("getChannel Api Response:"+response.toString());
        //  resp = new ChannelResp(userID: "abc", type: ChannelType.Messaging);

        if (response.statusCode == HttpStatus.ok) {
          resp =  ChannelResp.fromMap(response.body);
          print("response:"+resp.toString());
        } else {
          resp =  ChannelResp.fromMap(response.body);
        }

        userChnlMap.value = Map.fromIterable(resp.channels,
            key: (e) => e.chnlId,
            value: (e) => e
        );
       // userChnlMap.refresh();
        eventService.addEventForChannels(userChnlMap.keys);
        dataLoaded = true;
      }

    }
    catch(e)
    {
      logError("getUserChannelError:$e");
      rethrow;
    }
   return userChnlMap.value;

  }


  void printCurrentChannel(String channelId)
  {
    UserChannel? chnl = userChnlMap[channelId];
    print("............................Message Service Updated UserChnl:"+String.fromCharCode(chnl!.unreadCount));
  }

  void incrementUnreadCount(String channelId)
  {
    UserChannel? chnl = userChnlMap[channelId];
    if( null != chnl)
    {
      chnl.unreadCount=  chnl.unreadCount+1;
      userChnlMap.refresh();
      print("............................Message Service Updated UserChnl:"+chnl.unreadCount.toString());
    }

  }

  void addNewMsgToChnl(String channelId, Message? msg)
  {
    if( null != msg)
    {
      UserChannel? chnl = userChnlMap[channelId];
      if( null != chnl)
      {
        chnl.unreadCount=  chnl.unreadCount+1;
        chnl.msg = msg;
        userChnlMap.refresh();
        AudioService().playNotificationSound();

      }
    }
  }

}
