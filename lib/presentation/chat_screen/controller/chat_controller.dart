
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/enums/MsgActionType.dart';
import 'package:anchor_getx/data/enums/MsgEventType.dart';
import 'package:anchor_getx/data/models/message/ApiMessage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/errors/ApiException.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/enums/MsgReactionType.dart';
import '../../../data/enums/MsgType.dart';
import '../../../data/models/channel/UserChannel.dart';
import '../../messages_page/service/message_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/chat_scroll_possition.dart';
import '../models/scroll_location.dart';

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
  int itemPerPage = 20;
  bool getFirstData = false;
  bool lastPage = false;
  Rx<bool> isLoading = false.obs;
  late String myId;
  TextEditingController msgInputController = TextEditingController();
  ScrollController msgController = ScrollController();
  final itemScrollController = GroupedItemScrollController();
  late int initialScrollIndex = 0;
  // Chat Message Item Position Listener
  final itemPositionsListener = ItemPositionsListener.create();
  late ChatScrollPosition chatScrollPosition = new ChatScrollPosition(initFlag: false);
  @override
  onInit()  async {

    selectedChnlID = Get.parameters['chnlID']!;
    apiClient = Get.find<ApiClient>();
    messageService = Get.find<MessageService>();
    prepareData();
 //   addItemPositionListenerToMsgController();
  }


  @override
  void dispose() {

  }

  void prepareData()
  async {
      isLoading.value = true;
      myId = apiClient.getLoggedInUserID()!;
      if(null == myId)
      {
        throw new ApiException("Invalid logged in User");
      }

      // Populate Msg Channel Details along with Messages for Channel
    UserChannel? resp  =  await messageService.getChannelMsgDetails(selectedChnlID, page, itemPerPage);
    if( null == resp)
    {
    throw new ApiException("Unable to fetch data for selected channel:$selectedChnlID");
    }

    chnl = Rx<UserChannel>(resp);
    chatScrollPosition.currItemCount = resp.numberOfElements;
    chatScrollPosition.totalItemCount = resp.totalElements;
    chatScrollPosition.totalPages = resp.totalPages;
    chatScrollPosition.curPage = resp.pageNumber;
    print("MsgItems: ${chatScrollPosition.currItemCount} , total:${chatScrollPosition.totalItemCount}");
    initialScrollIndex = resp.unReadMsgIndex;

    isLoading.value = false;
  }

  void fetchMoreMsgForChnl()
  async {
    isLoading.value = true;
    myId = apiClient.getLoggedInUserID()!;
    if(null == myId)
    {
      throw new ApiException("Invalid logged in User");
    }

  }

  /*
  void addItemPositionListenerToMsgController()
  {
    itemPositionsListener.itemPositions.addListener(_onChatMessageItemListener);
    //msgController.addListener(_scrollListener);
  }
  */

  void chatItemVisibilityChangeListener(VisibilityInfo info)
  {
    DateTime tr_date = DateTime.now();
    String timeStr = DateFormat.Hms().format(tr_date);
    double visiblePercentage = info.visibleFraction * 100;
    ValueKey<int>? vkey = info.key as ValueKey<int>?;
    int id = 0;
    if( null != vkey)
    {
     // debugPrint('${vkey.value}, ${visiblePercentage.round()},${timeStr}');
      if(visiblePercentage == 100)
      {
        id = vkey.value;
        calculateItemPosition(tr_date, id);

      }

    }

  }

  void calculateItemPosition(DateTime tr_date, int id)
  {
    if(!chatScrollPosition.initFlag)
    {
      chatScrollPosition.crDate = tr_date;
      chatScrollPosition.modDate = tr_date;
      chatScrollPosition.curIndexs.add(id);
      chatScrollPosition.curMin = 0;
      chatScrollPosition.curMax = 0;
      chatScrollPosition.preMin = 0;
      chatScrollPosition.preMax = 0;
      chatScrollPosition.initFlag = true;
    }
    else {
      int eventDiff = tr_date.difference(chatScrollPosition.modDate).inSeconds;
      if(eventDiff <= 2)
      {
        chatScrollPosition.curIndexs.add(id);

        if(chatScrollPosition.curIndexs.length > 1)
        {
          int curMin = chatScrollPosition.curIndexs.reduce((curr, next) => curr < next? curr: next);
          int curMax = chatScrollPosition.curIndexs.reduce((curr, next) => curr > next? curr: next);
          chatScrollPosition.curMin = curMin;
          chatScrollPosition.curMax = curMax;
        }

        if(id > chatScrollPosition.curMin)
         {
           chatScrollPosition.direction = 'DOWN';
         }
        else {
          chatScrollPosition.direction = 'UP';
        }
      }
      else {
        chatScrollPosition.preIndexs.clear();
        chatScrollPosition.curIndexs.sort();
        chatScrollPosition.preIndexs.addAll(chatScrollPosition.curIndexs);
        chatScrollPosition.curIndexs.clear();
        chatScrollPosition.curIndexs.sort();
        chatScrollPosition.curIndexs.add(id);
        chatScrollPosition.modDate = tr_date;

        int curMin = 0;
        int curMax = 0;
        int preMin = 0;
        int preMax = 0;
        if(chatScrollPosition.curIndexs.length > 1)
        {
          curMin = chatScrollPosition.curIndexs.reduce((curr, next) => curr < next? curr: next);
          curMax = chatScrollPosition.curIndexs.reduce((curr, next) => curr > next? curr: next);

        }

        if(chatScrollPosition.preIndexs.length > 1)
        {
          preMin = chatScrollPosition.preIndexs.reduce((curr, next) => curr < next? curr: next);
          preMax = chatScrollPosition.preIndexs.reduce((curr, next) => curr > next? curr: next);

        }
        chatScrollPosition.preMin = preMin;
        chatScrollPosition.preMax = preMax;
        chatScrollPosition.curMin = curMin;
        chatScrollPosition.curMax = curMax;

       // print("CurItem: ${chatScrollPosition.curIndexs} , Prev:${chatScrollPosition.preIndexs}");
       // print(' After reset curRange:${chatScrollPosition.curMin},${chatScrollPosition.curMax}, preRange:${chatScrollPosition.preMin!},${chatScrollPosition.preMax!} ');

      }

    }

    int nextMsgPageTrigger = (chatScrollPosition.currItemCount/3).round();
    if((nextMsgPageTrigger >= chatScrollPosition.curMin) && (nextMsgPageTrigger <= chatScrollPosition.curMax))
    {
        int remItemCount = chatScrollPosition.totalItemCount - chatScrollPosition.currItemCount;
          if((remItemCount > 0) && (!chatScrollPosition.loading) && (chatScrollPosition.curPage+1 < chatScrollPosition.totalPages))
          {
            getMoreMsgForChnl(chatScrollPosition.curPage+1, itemPerPage);
            print("Need to call Next Msg Page as ${nextMsgPageTrigger} reached remaining item:${remItemCount}");
          }
          else {
            //print("Skip .... Need to call Next Msg Page as ${nextMsgPageTrigger} reached remaining item:${remItemCount}");
          }



    }
   // print('Before Resent Dir: ${chatScrollPosition.direction}, curRange:${chatScrollPosition.curMin},${chatScrollPosition.curMax}, preRange:${chatScrollPosition.preMin!},${chatScrollPosition.preMax!} ');

  }

/*

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
*/


  Future<void> addNewMessageToChat(ApiMessage msg)
  async {
    try{
        msg.actionType= MsgActionType.Add;
        msg.chnlID = selectedChnlID;
        msg.userID = myId;
        msg.msgEvent.value = MsgEventType.Sending;
        // Insert Chat Message to Chnl Msg
        insertChatMsg(this.selectedChnlID, msg);
       // print("Sending Msg Inserted to Chat with ID:"+msg.id);
        sendMsgToServer(msg);

    }
    catch(e,stacktrace)
    {
      Logger.log(e.toString(),stackTrace: stacktrace);
    }
  }

  Future<void> sendMsgToServer(ApiMessage msg)
  async {
    print('Sending msg to Server with ID:$msg.id');
    ApiMessage? uploadMsg = await messageService.sendMessage(msg);
    print("Upload Message to Server done for ID:"+msg.id);
    if( null != uploadMsg)
    {
      uploadMsg.msgEvent.value = MsgEventType.Sent;
      updateSentMsgToChnl(msg.id, uploadMsg);
    }
    else {
      msg.msgEvent.value = MsgEventType.Error;
      updateSentMsgToChnl(msg.id, msg);
    }

  }

  void updateSentMsgToChnl(String msgId, ApiMessage uploadMsg)
  {
    print("Msg Uploading completed Updating Channel");
    try{
      int index  =
      chnl.value.messages.indexWhere((element) =>
      element.id == msgId);
      if( index > 0)
       {

        chnl.value.messages[index] = uploadMsg;
       }
    }
    catch(e,stacktrace)
    {
      Logger.log(e.toString(),stackTrace: stacktrace);
    }
  }

  void addNewMessageTextToChat(String msgText)
  {
    try{
      String msgID = "new_"+DateTime.now().millisecond.toString();
      ApiMessage msg = new ApiMessage(id: msgID, type: MsgType.Text, body: msgText.trim(), createdOn: DateTime.now(),
        createdBy: myId, modifiedBy: myId, modifiedOn: DateTime.now());
      msg.actionType = MsgActionType.Add;
      msg.chnlID = selectedChnlID;
      msg.userID = myId;

     addNewMessageToChat(msg);
    }
    catch(e,stacktrace)
    {
      Logger.log(e.toString(),stackTrace: stacktrace);
    }
  }

  Future<void> insertChatMsg(String chnlId, ApiMessage? msg)
  async {
    if( this.selectedChnlID == chnlId)
   {
     if( null != msg)
   {
   chnl.value.messages.add(msg);
   print("Text Msg Added to MsgList");
   setSelectedMessage(msg.id);
   }
   }

  }

  void setSelectedMessage(String msgID)
  {
    itemScrollController.scrollToElement(identifier: msgID, duration: Duration(seconds: 1));
   // itemScrollController.jumpToElement(identifier: msgID);
  }


  void getMoreMsgForChnl(int page, int itemPerPage)
  async {
 chatScrollPosition.loading = true;
 // isLoading.value = true;
  myId = apiClient.getLoggedInUserID()!;
  if(null == myId)
  {
  throw new ApiException("Invalid logged in User");
  }
  // Populate Msg Channel Details along with Messages for Channel
   await messageService.getMoreMsgForChnl(chnl, selectedChnlID, page, itemPerPage);
  chatScrollPosition.currItemCount = chnl.value.messages.length;

  chatScrollPosition.totalPages = chnl.value.totalPages;
  chatScrollPosition.curPage = chnl.value.pageNumber;
  chatScrollPosition.loading = false;

  print("new Msg Received count:${chnl.value.messages.length}");

}

  void emojiCallbackFunctionForUser(String userID, String msgId, MsgReactionType emojiType)
  {
    print("ChatController Callback Received for Emoji for User:${userID}, msgID: ${msgId} , chnlID : ${selectedChnlID}, type:${emojiType.name}");

    ApiMessage? emojiMsg = chnl.value.messages.value.firstWhereOrNull((element) => element.id == msgId);

    if( emojiMsg != null)
     {
       emojiMsg.msgAttribute.userReaction[userID] = emojiType.name;
       print("Updated Emoji Reaction.....................");
       emojiMsg.msgAttribute.userReaction.forEach((key, value) {
         print("Key: ${key}, value:${value}");
       });
     }
  }


}
