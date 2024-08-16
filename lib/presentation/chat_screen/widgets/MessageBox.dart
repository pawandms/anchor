
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/enums/MsgEventType.dart';
import 'package:anchor_getx/data/enums/MsgReactionType.dart';
import 'package:anchor_getx/data/models/message/ApiMessage.dart';
import 'package:anchor_getx/presentation/chat_screen/widgets/EmojiIcon.dart';
import 'package:anchor_getx/presentation/chat_screen/widgets/MsgAttachmentComponent.dart';
import 'package:anchor_getx/presentation/chat_screen/widgets/ProfileBoxWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:shadow/shadow.dart';
import '../../../core/utils/Helper.dart';
import '../../../core/utils/progress_dialog_utils.dart';
import '../../../data/models/channel/ChnlParticipents.dart';
import '../../../data/models/media/MediaImage.dart';
import '../../../widgets/custom_image_view.dart';
import '../../messages_page/service/message_service.dart';


class MessageBox extends StatelessWidget {
  final BuildContext context;
  final ApiMessage msg;
  final String myId;
  final Map<String,ChnlParticipent>userMap;
  Function emojiCallbackFunction;
  MessageService  messageService;
  Helper helper;
   MessageBox({
    super.key,
    required this.context,
    required this.myId,
    required this.msg,
    required this.userMap,
    required this.emojiCallbackFunction,
    messageService

  }):messageService = Get.find<MessageService>(),
  helper = Helper()
  ;

  @override
  Widget build(context) {
    return Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      child: _buildMsgWidget(context, myId, msg),
    );
  }


  Widget _buildMsgWidget(BuildContext _context, String myId, ApiMessage msg)
  {
    Widget result = SizedBox.shrink();
    Widget msgComponent = SizedBox.shrink();
    int leftFlex = 0;
    int rightFlex = 0;
    bool isMyMsg;
    int msgType = helper.getMsgCategory(msg.type, myId, msg.createdBy!);
    if(msgType > 0)
   {
     if(msgType == 1)
      {
        isMyMsg = true;
        leftFlex = 1;
        rightFlex = 2;
        msgComponent = _buildMyMsgComponent(_context, myId, msg, msgType);
      }
     else if (msgType == 2)
     {
       leftFlex = 2;
       rightFlex = 1;
       isMyMsg = false;
       msgComponent =  _buildSenderMsgComponent(_context, myId, msg, msgType);
     }
     else if (msgType == 3)
      {
        msgComponent =  _buildSystemMsgComponent(_context, myId, msg, msgType);
      }

     result = _buildMsgContainer(msgComponent, msgType);
   }

    return result;
  }

  Widget _buildMsgContainer(Widget msgComponent, int msgType)
  {
    Widget result = SizedBox.shrink();
    if(msgType == 1)
   {
     result = Container(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Expanded(
               flex: 1,
               child: SizedBox.shrink()
           ),
           Expanded(
               flex: 2,
               child: msgComponent
           )
         ],
       )
     );
   }
   else  if(msgType == 2)
    {
      result = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 2.0, right: 5),
                child: getUserProfileImage(msg.createdBy!)

            ),
            Expanded(
                flex: 2,
                child: msgComponent
            ),
            Expanded(
                flex: 1,
                child: SizedBox.shrink()
            )
          ],
        )
      );
    }
    else  if(msgType == 3)
    {
      result = Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: msgComponent
              ),

            ],
          )
      );
    }

    return result;
  }

  Widget _buildMyMsgComponent(BuildContext _context, String myId, ApiMessage msg, int msgType)
  {
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildAttachmentBox(_context, myId, msg),
          _buildMsgBoxWithReactionMenu(myId, msg, msgType),
          _buildReactionStatusWidget(msg)

        ],
      ),
    );
  }
  Widget _buildSenderMsgComponent(BuildContext _context, String myId, ApiMessage msg, int msgType)
  {
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAttachmentBox(_context, myId, msg),
          _buildMsgBoxWithReactionMenu(myId, msg, msgType),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 1, 0, 0),
            child: _buildReactionStatusWidget(msg),
          )

        ],
      ),
    );
  }

  Widget _buildSystemMsgComponent(BuildContext _context, String myId, ApiMessage msg, int msgType)
  {
    return  Container(
      child: _buildSystemMsgBoxWithStatus(myId, msg,msgType),
    );
  }

  Widget _buildAttachmentBox(BuildContext _context, String myId,  ApiMessage msg)
  {
    Widget result = SizedBox.shrink();
    if(msg.attachments.isNotEmpty)
    {
      result = MsgAttachmentComponent(ctx: _context, myId: myId, msg: msg,);
    }
    return  result;
  }
  Widget _buildMsgBoxWithReactionMenu(String myId, ApiMessage msg, int msgType)
  {
    Widget msgBox = SizedBox.shrink();
    if(msgType == 1)
    {
      msgBox = _buildMyMsgBoxWithStatus(myId,msg, msgType);
    }
    else if(msgType == 2)
    {
      msgBox = _buildSenderMsgBoxWithStatus(myId,msg, msgType);
    }
    else if(msgType == 3)
    {
      msgBox = _buildSystemMsgBoxWithStatus(myId,msg, msgType);
    }
    ReactionButton<String> reactBtn =  _buildReactionWidget(myId,msg, msgBox);
    return reactBtn;
  }

  Widget _buildMyMsgBoxWithStatus(String myId, ApiMessage msg, int msgType )
  {
     Widget msgBox = _buildMsgBoxBubble(msg, msgType);
    return Obx(() =>  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          msgBox,
          _msgStatusWidget(msg)

        ],
      ),
    ));

  }
  Widget _buildSenderMsgBoxWithStatus(String myId, ApiMessage msg, int msgType )
  {
    Widget msgBox = _buildMsgBoxBubble(msg, msgType);
    return Obx(() =>  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          msgBox,
          _msgStatusWidget(msg)

        ],
      ),
    ));

  }
  Widget _buildSystemMsgBoxWithStatus(String myId, ApiMessage msg, int msgType )
  {
    Widget msgBox = _buildMsgBoxBubble(msg, msgType);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          msgBox,
         // _msgStatusWidget(msg)

        ],
      ),

    );

  }

  Widget _msgStatusWidget(ApiMessage msg)
  {
    return Align(
        alignment: AlignmentDirectional.bottomEnd,
        child:
        _getMsgStatus(msg.msgEvent.value)

    );
  }

  ReactionButton<String> _buildReactionWidget(String myId, ApiMessage msg, Widget msgBox)
  {
    Map<String,String> reactionTypeMap =  msg.msgAttribute.userReaction.value;

    MsgReactionType curReaction = MsgReactionType.Like;
    // find If Reaction is already done by Current user
    if( reactionTypeMap.containsKey(myId))
    {
      String reacTxt = reactionTypeMap[myId]!;
      curReaction =  MsgReactionTypeExtension.getType(reacTxt);
    }

    return helper.buildReactionWidget(msg.id, curReaction, msgBox, _emojiCallbackFunction);

  }

  Widget _buildReactionStatusWidget(ApiMessage msg)
  {
   return Obx(() =>  Padding(padding: EdgeInsets.only(top: 5, right: 20),
      child: _getReactionWidget(msg.id, msg.msgAttribute.userReaction),
    ));
  }

  Widget _buildMsgBoxBubble(ApiMessage msg, int msgType)
  {
    return Container(

    //  width: SizeUtils.width * 0.76,
      child: InkWell(
        onTap: (){
          if(msg.msgEvent.value == MsgEventType.Sending)
          {
            msg.msgEvent.value = MsgEventType.Sent;
            print("click on Msg Box with ID:"+msg.id+" , with MsgType:"+msg.msgEvent.value.name);

          }
          else if (msg.msgEvent.value == MsgEventType.Sent)
          {
            msg.msgEvent.value = MsgEventType.Sending;
            print("click on Msg Box with ID:"+msg.id+" , with MsgType:"+msg.msgEvent.value.name);
          }
          else {
            msg.msgEvent.value = MsgEventType.Sending;
            print("click on Msg Box with ID:"+msg.id+" , with MsgType:"+msg.msgEvent.value.name);
          }

        },
        child: helper.buildMsgBoxCard(msg, msgType),

      ),
    );
  }


/*
  Widget _buildMsgStatusComponent(ApiMessage msg, bool isSender)
  {
    Widget result = SizedBox.shrink();
    if(isSender)
    {
      result = Obx(() =>   Align(
         heightFactor: 3,
         widthFactor: 2,
          alignment: AlignmentDirectional.bottomStart,
          child:
          _getMsgStatus(msg.msgEvent.value)

      ));
    }


    return result;
  }

 */
   /*
  @override
  Widget build(context) {
    const BoxDecoration chatBackgroundDecoration = BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFFe3edff),
              Color(0xFFcad8fd)
            ]
        )
    );

    bool
    displayUserName = true,
        displayAvatar = true;

    if (msg.createdBy == myId){
      displayUserName = false;
    } else
      {
        displayUserName = true;
      }

    displayAvatar = displayUserName;
    //displayUserName = false;

    return Obx(() => Row(
      mainAxisAlignment: msg.createdBy == myId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (displayAvatar)
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0),
            child: getUserProfileImage(msg.createdBy!)

          ),
        if (!displayAvatar)
          const SizedBox(width: 40),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: msg.createdBy == myId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (displayUserName)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text( getUserName(msg.createdBy!),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.blueAccent,
                  ),
                ),
              ),
            if(msg.attachments.isNotEmpty)
              SizedBox(
                  //width: SizeUtils.width * 0.70,
                  child: AttachmentBox(ctx: context, myId: myId, msg: msg )),
            Row(
              children: [
                _prepareReactionWidget(myId, msg),
               // _generateMessageBox(msg),
                Align(
                    heightFactor: 3,
                    widthFactor: 2,
                    alignment: AlignmentDirectional.bottomStart,
                    child:
                    //  msg.actionType == MsgActionType.Sending ?
                    _getMsgStatus(msg.msgEvent.value)

                ),

              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5, right: 20),
              child: _getReactionWidget(msg.id, msg.msgAttribute.userReaction),
            )

          ],
        ),


      ],
    ));
  }
  */
  Widget _getMsgStatus(MsgEventType type)
  {
    Widget result = SizedBox.shrink();
    if(type == MsgEventType.Sending)
     {
       result =  Tooltip(
         message: "lbl_msg_sending".tr,
         child: SizedBox(
           width: 20,
           height: 20,
             child: Center(child: CircularProgressIndicator(strokeWidth: 1, ),)),
       );
     }
    else  if(type == MsgEventType.Sent)
    {
      result =  Tooltip(
        message: "lbl_msg_sent".tr,
        child: Icon(
          Icons.check_circle_outline,
          size: 20,
          color: Colors.blue,
        ),
      );
    }
    else  if(type == MsgEventType.Error)
    {
      result =  Tooltip(
        message: "lbl_msg_error".tr,
        child: Icon(
          Icons.error,
          size: 20,
          color: Colors.redAccent,
        ),
      );
    }

    /*
    else  if(type == MsgEventType.View)
    {
      result =  Icon(
        Icons.fact_check_outlined,
        size: 20,
        color: Colors.blue,
      );
    }

     */
   return result;

  }
  String _getUserName(String userID)
  {
    String result = userID;
    if(userMap.containsKey(userID))
     {
       ChnlParticipent cp = userMap[userID]!;
       result =  cp.firstName+" "+cp.lastName;
     }

    return result;
  }

  Widget getUserProfileImage(String userID)
  {
    Widget result = SizedBox.shrink();
    Widget profilePic = SizedBox.shrink();
    String userName = 'NA';
    if(userMap.containsKey(userID))
     {
       ChnlParticipent cp = userMap[userID]!;
      userName = _getUserName(userID);
       if(null != cp.profileImage)
        {
          profilePic =  prepareProfileLogo(cp.profileImage!);
        }
       else {
         profilePic = getDummyProfileLogo();
       }

       result =  GestureDetector(
         onTap: (){
           print("User Profile clicked for name:${userName} , ID:${userID}");
           _openProfilePreviewDialog(userID);
         },
         child: Tooltip(
            message: userName,
           child: profilePic,
         ),
       );
     }
     return result;

  }
    void _openProfilePreviewDialog(String userID)
    {
      String profileUrl = '/images/user_icon.png';
      if(userMap.containsKey(userID))
      {
        ChnlParticipent cp = userMap[userID]!;
        if( null != cp.profileImage)
        {
          String userProfileUrl = messageService.getUserProfileUrl(cp.profileImage!);
          if(userProfileUrl.isNotEmpty)
          {
            //profileUrl = userProfileUrl;
          }
        }

      }
        showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0,100,0,0),
            child: Align(
              alignment: Alignment.topCenter,
              child: ProfileBoxWidget(profileImageUrl: profileUrl,),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: Offset(0, 1),
                end: Offset(0,0)).animate(anim1),
            child: child,
          );
        },
      );
    }

    Widget _getProfileWidget()
    {
      return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              color: Colors.blue
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                              color: Colors.red
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      );
    }
  Widget prepareProfileLogo(MediaImage img)
  {
    return Shadow(
    child: CustomImageView(
    imagePath: messageService.getContentUrl(img),
    height: 50.adaptSize,
    width: 50.adaptSize,
    fit: BoxFit.contain,
  //border: Border.all(color: Colors.black),
    margin: EdgeInsets.only(left: 05.h),
    radius: BorderRadius.circular(
    20.h,
    ),
    ));

  }

  Widget getDummyProfileLogo()
  {
    return Shadow(
        child: CustomImageView(
          imagePath: 'assets/images/group-chat-icon.svg',
          height: 50.adaptSize,
          width: 50.adaptSize,
          fit: BoxFit.contain,
          border: Border.all(color: Colors.green),
          margin: EdgeInsets.only(left: 05.h),
          color: Colors.green,
          radius: BorderRadius.circular(
            20.h,
          ),
        ),
        options: ShadowOptions(
          offset: Offset(5, 5),
          scale: 1,
          blur: 4,
        )
    );
  }

  /*
  ReactionButton<String> _prepareReactionWidget(String myId, ApiMessage msg)
  {
    Map<String,String> reactionTypeMap =  msg.msgAttribute.userReaction.value;

    MsgReactionType curReaction = MsgReactionType.Like;
    // find If Reaction is already done by Current user
    if( reactionTypeMap.containsKey(myId))
    {
      String reacTxt = reactionTypeMap[myId]!;
      curReaction =  MsgReactionTypeExtension.getType(reacTxt);
    }

    Widget msgBox = _generateMessageBox(msg);
    return helper.buildReactionWidget(msg.id, curReaction, msgBox, _emojiCallbackFunction);

  }
  void _reactionWidgetCallBackFunction(Reaction<String>? reaction)
  {
    print('Current Selected Reaction is :${reaction?.value}');
  }

  */
  Widget _getReactionWidget(String msgId, Map<String, String> reactionTypeMap)
  {
    print("Builing Reaction Tile for MsgID:${msgId}, with ReactionMap:${reactionTypeMap.length} ");
   return  helper.getReactionWidget(msgId, reactionTypeMap, _emojiCallbackFunction);

    /*
    Widget result = SizedBox.shrink();
    Map<String, int> emojiValueCounts = {};
    if(reactionTypeMap.isNotEmpty)
    {
      // Step 1: Get unique values using a set
      Set<String> uniqueValues = reactionTypeMap.values.toSet();
      // Step 2: Count occurrences of each unique value
      uniqueValues.forEach((value) {

        int count = reactionTypeMap.values.where((v) => v == value).length;
        emojiValueCounts[value] = count;
      });
      List<Widget> reactionWidgetList = [];

      emojiValueCounts.forEach((key, value) {
        MsgReactionType emojiType = MsgReactionTypeExtension.getType(key);
        Widget reactionWidget = HoverEmoji(msgId: msgId, emojiType: emojiType, size: 25, itemCount: value, callbackFunction: _emojiCallbackFunction, );
        reactionWidgetList.add(reactionWidget);
      });
      result =  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: reactionWidgetList
      );


    }


    return result;
    */
  }

  void _emojiCallbackFunction(String msgId, MsgReactionType emojiType)
  {
    print("_emojiCall Back for MsgID:${msgId}, Reactoin:${emojiType.name}");
    emojiCallbackFunction(this.myId, msgId, emojiType);
  }

  /*
  Widget _buildEmojiIcon(MsgReactionType type)
  {
   return  Container(
     padding: EdgeInsets.all(2),
     width: 50.0,
     height: 50.0,
    decoration: BoxDecoration(
       shape: BoxShape.circle,
       //border: Border.all(color: Colors.black)
      ),
      child: EmojiIcon(emojiType: type),

    );
  }

  Widget _generateMessageBox(ApiMessage msg)
  {
    return SizedBox(
      width: SizeUtils.width * 0.76,
      child: Align(
        alignment: msg.createdBy == myId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: InkWell(
          onTap: (){
            if(msg.msgEvent.value == MsgEventType.Sending)
            {
              msg.msgEvent.value = MsgEventType.Sent;
              print("click on Msg Box with ID:"+msg.id+" , with MsgType:"+msg.msgEvent.value.name);

            }
            else if (msg.msgEvent.value == MsgEventType.Sent)
            {
              msg.msgEvent.value = MsgEventType.Sending;
              print("click on Msg Box with ID:"+msg.id+" , with MsgType:"+msg.msgEvent.value.name);
            }
            else {
              msg.msgEvent.value = MsgEventType.Sending;
              print("click on Msg Box with ID:"+msg.id+" , with MsgType:"+msg.msgEvent.value.name);
            }
          },
          child: Card(
            color: msg.createdBy == myId ? Colors.green : Colors.white,
            borderOnForeground: true,
            elevation: 10.0,
            surfaceTintColor: Colors.red,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  topLeft: Radius.circular(
                      msg.createdBy == myId ? 18.0 : 0
                  ),
                  bottomRight: Radius.circular(
                      msg.createdBy == myId ? 0 : 18.0
                  ),
                )
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
                  child: (msg.body.length > 10) ? Text(msg.body.trim(), style: TextStyle(color: msg.createdBy == myId ? Colors.white : Colors.black),)
                      : Text(msg.body.trim()+"          ",
                    style: TextStyle(color: msg.createdBy == myId ? Colors.white : Colors.black),
                  ),
                ),
                Positioned(
                    bottom: 4,
                    right: 8,
                    child: Text(
                      DateFormat.jm().format(msg.createdOn),
                      style: TextStyle(color: msg.createdBy == myId ? Colors.white : Colors.black),
                    )
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
*/
}