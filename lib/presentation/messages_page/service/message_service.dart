
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/AppConfig.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:anchor_getx/core/repository/MessageRep.dart';
import 'package:anchor_getx/core/service/AudioService.dart';
import 'package:anchor_getx/data/enums/ChannelType.dart';
import 'package:anchor_getx/data/models/channel/ChannelResp.dart';
import 'package:anchor_getx/data/models/message/Attachment.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';

import '../../../core/errors/ApiException.dart';
import '../../../core/service/EventService.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/enums/EntityType.dart';
import '../../../data/models/channel/UserChannel.dart';
import '../../../data/models/media/MediaImage.dart';
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
        final response = await apiClient.get(getChnlUrl,headers:{}, contentType : 'application/json', query: {}, decoder: null);

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

        if(!result.msgLoadedFlag)
        {
          String? userID = apiClient.getLoggedInUserID();
          if(null == userID)
          {
            throw new ApiException("Invalid logged in User");
          }
          String sort = 'createdOn.desc';
          late ChnlMsgResp  resp;
          if(null != result.unReadMsgID)
          {
            String unReadMsgID = result.unReadMsgID!;
            ApiMessage? unReadMsg;
            do{
              print('Getting ChnlMsg with Page:${page}');
              resp = await msgRep.getChnlMsgForUser(userID, chnlID, itemPerPage, page, sort);
              if(null != resp)
              {
                msgList =  resp.content.map((e) => e.message).obs.value.toList();
                result.messages.value.addAll(msgList);
                unReadMsg = msgList.firstWhereOrNull((element) => element.id == unReadMsgID);
                if( null != unReadMsg)
                {
                  result.messages.sort((a,b) => a.createdOn.compareTo(b.createdOn));
                  // Get Index No of Item
                 int unReadMsgIndex =  result.messages.indexOf(unReadMsg);
                 result.unReadMsgIndex = unReadMsgIndex;
                }

                result.totalPages = resp.totalPages;
                result.pageNumber = resp.number;
                result.totalElements = resp.totalElements;
                result.size = resp.size;
                result.numberOfElements = resp.numberOfElements;
                result.first = resp.first;
                result.last = resp.last;
                page++;

              }

              }
            while(null == unReadMsg);

          }
          else {
            resp = await msgRep.getChnlMsgForUser(userID, chnlID, itemPerPage, page, sort);
            if(null != resp)
            {
              msgList =  resp.content.map((e) => e.message).obs.value.toList();
            //  result.messages.value.addAll(msgList);
              result.messages.value.insertAll(0, msgList);
              result.unReadMsgIndex = msgList.length -1 ;
              result.totalPages = resp.totalPages;
              result.pageNumber = resp.number;
              result.totalElements = resp.totalElements;
              result.size = resp.size;
              result.numberOfElements = resp.numberOfElements;
              result.first = resp.first;
              result.last = resp.last;
            }
          }
          result.msgLoadedFlag = true;
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


  Future<void> getMoreMsgForChnl(Rx<UserChannel> chnl, String chnlID, int page, int itemPerPage)
  async {
    List<ApiMessage> msgList = List.empty();
    try{

          String? userID = apiClient.getLoggedInUserID();
          if(null == userID)
          {
            throw new ApiException("Invalid logged in User");
          }
          String sort = 'createdOn.desc';
          ChnlMsgResp  resp = await msgRep.getChnlMsgForUser(userID, chnlID, itemPerPage, page, sort);

          if(null != resp)
          {
            msgList =  resp.content.map((e) => e.message).obs.value.toList();
            if(msgList.isNotEmpty)
            {
              
              msgList.forEach((element) {
               chnl.value.messages.add(element);

              });

               
              //chnl.value.messages.addAll(msgList);
            }
           // chnl.messages.insertAll(0, msgList);
           // chnl.messages.value.addAll(msgList);
            chnl.value.totalPages = resp.totalPages;
            chnl.value.pageNumber = resp.number;
            chnl.value.totalElements = resp.totalElements;
            chnl.value.size = resp.size;
            chnl.value.numberOfElements = resp.numberOfElements;
            chnl.value.first = resp.first;
            chnl.value.last = resp.last;

          }

    }
    catch(e)
    {
      logError(e);

    }

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

  Future<ApiMessage?> sendMessage(ApiMessage msg)
  async {
    ApiMessage? resp;
    try{

      String? userID = apiClient.getLoggedInUserID();
      if(null == userID)
      {
        throw new ApiException("Invalid logged in User");
      }

      String getAddMsgUrl = EnvConfig.getAddMsgUrl();
      List<MultipartFile> newList = [];
      if(msg.attachments.isNotEmpty)
      {
        for (Attachment atch in msg.attachments)
        {
          if( null != atch.localInput.file)
          {
              MultipartFile? mfile = await getmfileFromXFile(atch.localInput.file!);

           if( null != mfile)
           {
             newList.add(mfile);
           }

          }
        }
      }
      // Clear Attachment List
      msg.attachments.clear();
      var msgJson = msg.toMap();
      final String encodedData = json.encode(msgJson);

      final _body = {
        "request": encodedData,
        "attachment": newList,
      };

      FormData formData = FormData(_body);
          var uri = Uri.parse(getAddMsgUrl);
          http.MultipartRequest request = new http.MultipartRequest('POST', uri);
          final response = await apiClient.post(getAddMsgUrl,formData, headers:{});
          if (response.statusCode == HttpStatus.ok) {
             resp =  ApiMessage.fromMap(response.body);
          } else {
            resp =  ApiMessage.fromMap(response.body);
          }

    }
    catch(e)
    {
      logError(e);
    }

    return resp;
  }

  Future<MultipartFile?> getmfileFromXFile(XFile xfile)
   async {
     MultipartFile? mfile;
    // http.MultipartFile? mpartFile;

     try{
       if(GetPlatform.isWeb)
       {
           var bytes = xfile.readAsBytes();
         mfile = MultipartFile(await bytes, filename: xfile.name );
       }
       else {
         mfile = await  MultipartFile(xfile.path, filename: xfile.name, );
       }

     }
     catch(e, stacktrace)
    {
      logError(e, stacktrace);
    }
    return mfile;
    //return mpartFile;
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


  String getContentUrl(MediaImage img)
  {
    String result = 'images/image_not_found.png';
    if(null != img)
     {
      result = apiClient.getContentUrl(img.entityId, img.entityType);
     }
    return result;
  }

  String getAttachmentUrl(Attachment attachment)
  {
    String result = 'images/image_not_found.png';
    if( null != attachment)
    {
      result = apiClient.getAttachmentUrl(attachment.contentID, attachment.extension, attachment.sizeInBytes, attachment.type);
    }

    return result;
  }

  Future<void> updateMsgReactionToServer( String chnlID, String msgId, String msgReaction)
  async {
    try{
   String? userID = apiClient.getLoggedInUserID();
      if(null == userID)
      {
        throw new ApiException("Invalid logged in User");
      }

      String editMsgUrl = EnvConfig.getEditMsgUrl(userID, chnlID, msgId);
      final _body = {
        "actionType": 'MsgReaction',
        "msgReaction" : msgReaction
      };
   final jsonString = json.encode(_body);
      final response = await apiClient.post(editMsgUrl,jsonString, headers:{});
      if (response.statusCode == HttpStatus.ok) {

      } else {
        logError('Update msg Reaction failed with Status :${response.statusCode}');
      }

    }
    catch(e)
    {
      logError(e);
    }

  }


}
