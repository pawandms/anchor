
import 'dart:convert';
import 'dart:html';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/AppConfig.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:anchor_getx/core/repository/MessageRep.dart';
import 'package:anchor_getx/core/service/AudioService.dart';
import 'package:anchor_getx/data/enums/ChannelType.dart';
import 'package:anchor_getx/data/models/channel/ChannelResp.dart';
import 'package:loggy/loggy.dart';

import '../../../core/errors/ApiException.dart';
import '../../../core/service/EventService.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/channel/UserChannel.dart';
import '../../../data/models/message/ApiMessage.dart';
import '../../../data/models/message/ChnlMsgResp.dart';

class MessageService extends GetxService  {

  //final GetConnect connect = Get.find<GetConnect>();
  late final ApiClient apiClient;
  late final EventService eventService;
  late final MessageRep msgRep;
  bool dataLoaded = false;
  late RxMap<String,UserChannel> userChnlMap =  RxMap<String,UserChannel>(); //<String, UserChannel>{}.obs;
  late RxMap<String,List<ApiMessage>> userChnlMsgMap =  RxMap<String, List<ApiMessage>>();

  @override
  void onInit() {
    apiClient = Get.find<ApiClient>();
    eventService = Get.find<EventService>();
    msgRep =  Get.put(MessageRep());

  }

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

        Map<String, dynamic>? queryParam = {'userID': userID, 'chnlType': ChannelType.Messaging.name};
        String getChnlUrl = EnvConfig.getMsgChnlUrl(userID);
        final response = await apiClient.get(getChnlUrl,headers:{}, contentType : null, query: {});
        if (response.statusCode == HttpStatus.ok) {
          resp =  ChannelResp.fromMap(response.body);
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

  Future<UserChannel?> getChannelMsgDetails(String chnlID, int page, int itemPerPage)
   async {
         UserChannel? result = null;
     List<ApiMessage> msgList = List.empty();
    try{
      if(userChnlMap.isEmpty)
      {
        // Intilize User Channel map
       await  getUserChannels();
      }

      if(userChnlMap.value.containsKey(chnlID))
      {
        result = userChnlMap[chnlID]!;

        String? userID = apiClient.getLoggedInUserID();
        if(null == userID)
        {
          throw new ApiException("Invalid logged in User");
        }
        ChnlMsgResp  resp = await msgRep.getChnlMsgForUser(userID, chnlID, itemPerPage, page);

        if(null != resp)
        {
          msgList =  resp.content.map((e) => e.message).obs.value.toList();
          result.messages.value.addAll(msgList);
        }

      }
      else {
        // Wrong Channel Details Request for user

      }


    }
    catch(e)
    {
      logError(e);
    }

    return result;

  }


  void printCurrentChannel(String channelId)
  {
    UserChannel? chnl = userChnlMap[channelId];
    //print("............................Message Service Updated UserChnl:"+String.fromCharCode(chnl!.unreadCount));
  }

  void incrementUnreadCount(String channelId)
  {
    UserChannel? chnl = userChnlMap[channelId];
    if( null != chnl)
    {
      chnl.unreadCount.value=  chnl.unreadCount.value+1;
     // userChnlMap.refresh();
      print("............................Message Service Updated UserChnl:"+chnl.unreadCount.value.toString());
    }

  }

  void addNewMsgToChnl(String channelId, ApiMessage? msg)
  {
    if( null != msg)
    {
      UserChannel? chnl = userChnlMap[channelId];
      if( null != chnl)
      {
        chnl.unreadCount.value=  chnl.unreadCount.value+1;
        chnl.msg = Rx(msg);
        userChnlMap.refresh();
        if(AppConfig.instance.enableMsgSound)
        {
          AudioService().playNotificationSound();
        }

      }
    }
  }

  /*
  void addMessage(ApiMessage msg)
  {
    try{
      Future<ApiMessage> response =  sendMessage(msg);
    }
    catch(e)
    {
      rethrow;
    }

  }

   */

  Future<ApiMessage> sendMessage(ApiMessage msg)
  async {
    try{

      String? userID = apiClient.getLoggedInUserID();
      if(null == userID)
      {
        throw new ApiException("Invalid logged in User");
      }

      String getAddMsgUrl = EnvConfig.getAddMsgUrl();
      var msgJson = msg.toMap();
      final String encodedData = json.encode(msgJson);
      final response = await apiClient.post(getAddMsgUrl,encodedData, headers:{}, contentType : 'application/json');
      print("Response:$response");
      if (response.statusCode == HttpStatus.ok) {
        ApiMessage resp =  ApiMessage.fromMap(response.body);
      } else {
        ApiMessage resp =  ApiMessage.fromMap(response.body);
      }

    }
    catch(e)
    {
      logError(e);
    }

    return msg;
  }


  void setSelectedChannel(String chnlID)
  {
   // selectedChnl = Rx(userChnlMap[chnlID]!);
    Get.toNamed(AppRoutes.chatScreen,
        parameters: {"chnlID" : chnlID});
  }



  /*
  Future<void> addMsgtoSelectedChannel()
  async {
    if(selectedChnl.value.page== 0)
    {
    List<ApiMessage> msgList = await getChannelMsg(selectedChnl.value.chnlId, selectedChnl.value.page, selectedChnl.value.itemPerPage);
    if(msgList.isNotEmpty)
    {
      selectedChnl.value.messages.value.addAll(msgList);
    }
    }

  }


   */
}
