
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/enums/MsgEventType.dart';
import 'package:anchor_getx/data/enums/MsgReactionType.dart';
import 'package:anchor_getx/data/models/message/ApiMessage.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:shadow/shadow.dart';
import '../../../data/enums/MsgActionType.dart';
import '../../../data/models/channel/ChnlParticipents.dart';
import '../../../data/models/media/MediaImage.dart';
import '../../../widgets/custom_image_view.dart';
import '../../messages_page/service/message_service.dart';
import 'AttachmentBox.dart';
import 'package:badges/badges.dart' as badges;

import 'HoverEmoji.dart';

class MessageBox extends StatelessWidget {
  final BuildContext context;
  final ApiMessage msg;
  final String myId;
  final Map<String,ChnlParticipent>userMap;
  Function emojiCallbackFunction;
  MessageService  messageService;

   MessageBox({
    super.key,
    required this.context,
    required this.myId,
    required this.msg,
    required this.userMap,
    required this.emojiCallbackFunction,
    messageService

  }):messageService = Get.find<MessageService>()
  ;


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
                 // width: SizeUtils.width * 0.70,
                  child: AttachmentBox(ctx: context, myId: myId, msg: msg )),
            Row(
              children: [
                SizedBox(
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
                ),
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
  String getUserName(String userID)
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
    if(userMap.containsKey(userID))
     {
       ChnlParticipent cp = userMap[userID]!;
       if(null != cp.profileImage)
        {
         return  prepareProfileLogo(cp.profileImage!);
        }
       else {
         return getDummyProfileLogo();
       }
     }
    else {
      return getDummyProfileLogo();
    }
  }

  Widget prepareProfileLogo(MediaImage img)
  {

    return Shadow(child: CustomImageView(
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

  Widget _getReactionWidget(String msgId, Map<String, String> reactionTypeMap)
  {
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
      /*
      for (var value in uniqueValues) {
        int count = reactionTypeMap.values.where((v) => v == value).length;
        emojiValueCounts[value] = count;
        // Output the results
        emojiValueCounts.forEach((value, count) {
          print('Value "$value" occurs $count times for MsgID: ${myId}');
        });

      }
      */
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

  }

  void _emojiCallbackFunction(String msgId, MsgReactionType emojiType)
  {
    emojiCallbackFunction(this.myId, msgId, emojiType);
  }


}