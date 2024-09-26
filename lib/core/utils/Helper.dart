
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:intl/intl.dart';
import '../../data/enums/MsgReactionType.dart';
import '../../data/enums/MsgType.dart';
import '../../data/models/media/MediaInput.dart';
import '../../data/models/message/ApiMessage.dart';
import '../../data/models/message/Attachment.dart';
import '../../presentation/chat_screen/widgets/EmojiIcon.dart';
import '../../presentation/chat_screen/widgets/HoverEmoji.dart';
import 'logger.dart';

class Helper{

  static  DateFormat _formatter = DateFormat('yyyy-MM-dd');

  static DateTime getLocalDateFromUtcDateString(String utcDateString )
  {
    DateTime result = new DateTime.now();
    try{
      if( null != utcDateString)
      {
        DateTime dt = DateTime.parse(utcDateString).toUtc();
        result = dt.toLocal();
      }
    }
    catch(e, stacktrace)
    {
      Logger.log('Error in Refresh Token'+e.toString(),stackTrace: stacktrace);
    }
    return result;
  }
  static String getText(DateTime date) {
    final now = new DateTime.now();
    if (_formatter.format(now) == _formatter.format(date)) {
      return 'Today';
    } else if (_formatter
        .format(new DateTime(now.year, now.month, now.day - 1)) ==
        _formatter.format(date))   {
      return 'Yesterday';
    } else {
      return '${DateFormat.yMMMd().format(date)}';
    }
  }

  static List<Attachment> convertMediaInputToAttachment(List<MediaInput> mediaList, String createdBy)
  {
    List<Attachment> attachments = [];
    int atchId = 1;
    if(mediaList.isNotEmpty)
     {
       mediaList.forEach((element) {

         Attachment attachment = new Attachment(id: atchId.toString(), type: element.type, name: element.file!.name, extension: 'na',
             bucketName: 'NA', contentID: 'NA', sizeInBytes: 0, createdBy: createdBy, createdOn: DateTime.now(), modifiedBy: createdBy, modifiedOn: DateTime.now());
         attachment.localInput = element;
         attachments.add(attachment);
         atchId++;
       });
     }

    return attachments;
  }

  ReactionButton<String> buildReactionWidget(String msgId, MsgReactionType curReaction, Widget childWidget, Function onReactionChange)
  {

    // color: Colors.green,
    return ReactionButton<String>(
      //boxColor: Colors.redAccent,
      itemSize: const Size.square(30),
      animateBox: true,

      onReactionChanged:
          (Reaction<String>? reaction) {
        debugPrint('Selected value: ${reaction?.value}');
        if( null != reaction?.value)
        {
          String newVal = reaction!.value!;
          MsgReactionType type = MsgReactionTypeExtension.getType(newVal);
          onReactionChange(msgId, type);
        }

      },

      reactions: _getReactionItems(),
      placeholder: _getReactionItem(MsgReactionType.Like),
      selectedReaction: _getReactionItem(curReaction),
      child: childWidget,
    );

  }



  Widget buildReactionButton(MsgReactionType curReaction)
  {
    return Container(
      // color: Colors.green,
      child: ReactionButton<String>(
        //boxColor: Colors.redAccent,
        itemSize: const Size.square(30),
        onReactionChanged: (Reaction<String>? reaction) {
          debugPrint('Selected value: ${reaction?.value}');
        },
        reactions: _getReactionItems(),
        placeholder: _getReactionItem(MsgReactionType.Like),
        selectedReaction: _getReactionItem(curReaction),
      ),
    );
  }

  Widget _buildEmojiTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.75),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }



  Reaction<String> _getReactionItem(MsgReactionType type)
  {
    return Reaction<String>(
      value: type.name,
      title: _buildEmojiTitle(
          type.name
      ),
      //previewIcon: _buildEmojiIcon(type),
      icon: _buildEmojiIcon(type),

    );
  }

  Widget _buildEmojiIcon(MsgReactionType type)
  {
    //return Text(type.name);
    return  Tooltip(
        message: type.name,
        child: EmojiIcon(emojiType: type)
    );

  }

  List<Reaction<String>> _getReactionItems()
  {
    List<Reaction<String>> reactionItems = [];
    reactionItems.add(_getReactionItem(MsgReactionType.Like));
    reactionItems.add(_getReactionItem(MsgReactionType.DisLike));
    reactionItems.add(_getReactionItem(MsgReactionType.Love));
    reactionItems.add(_getReactionItem(MsgReactionType.Smile));
    reactionItems.add(_getReactionItem(MsgReactionType.Laugh));
   // reactionItems.add(_getReactionItem(MsgReactionType.Wink));
    reactionItems.add(_getReactionItem(MsgReactionType.Angry));
    //reactionItems.add(_getReactionItem(MsgReactionType.Sad));
    reactionItems.add(_getReactionItem(MsgReactionType.Surprised));

    return reactionItems;
  }


  Widget getReactionWidget(String msgId, Map<String, String> reactionTypeMap,Function (String msgId, MsgReactionType emoiType ) reactionClickCallBack)
  {
    Widget result = SizedBox.shrink();
    Map<MsgReactionType, int> emojiValueCounts = {};
    if(reactionTypeMap.isNotEmpty)
    {
      // Step 1: Get unique values using a set
      Set<String> uniqueValues = reactionTypeMap.values.toSet();
      // Step 2: Count occurrences of each unique value
      uniqueValues.forEach((value) {
        MsgReactionType emojiType = MsgReactionTypeExtension.getType(value);
        int count = reactionTypeMap.values.where((v) => v == value).length;
        emojiValueCounts[emojiType] = count;
      });

      var sortedByKeyMap = Map.fromEntries(
          emojiValueCounts.entries.toList()..sort((e1, e2) => e1.key.index.compareTo(e2.key.index)));

      List<Widget> reactionWidgetList = [];

      sortedByKeyMap.forEach((key, value) {
          Widget reactionWidget = HoverEmoji(msgId: msgId, emojiType: key, size: 25, itemCount: value, callbackFunction: reactionClickCallBack, );
          reactionWidgetList.add(reactionWidget);

      });

    result =   Container(
      child: Wrap(
          alignment: WrapAlignment.start,
          children:reactionWidgetList ,
        ),
    );

     /*
      result =  Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
         //   mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: reactionWidgetList
        ),
      );


      */



    }

    return result;

  }

  int getMsgCategory(MsgType msgType, String myId, String msgCreator)
  {
    int result = 0;
    if ((msgType == MsgType.System) || (msgType == MsgType.Notification))
   {
     result = 3;
   }
    else {
      if (( null != msgCreator) || ( null != myId))
     {
       if (msgCreator == myId)
       {
         result = 1;

       }
       else {
         result = 2;
       }
     }

    }

    return result;
  }

  Widget buildMsgBoxCard(ApiMessage msg, int msgType)
  {
    Widget result = SizedBox.shrink();

    if( msgType == 1)
    {
      result = _buildMyMsgCard(msg);
    }
    else if (msgType == 2)
    {
      result = _buildSenderMsgCard(msg);
    }
    else if (msgType == 3)
   {
     result = _buildSystemMsgCard(msg);
   }

    return result;
  }
  Widget _buildMyMsgCard(ApiMessage msg)
  {
    return Card(
      color: Colors.blue,
      borderOnForeground: true,
      elevation: 10.0,
      surfaceTintColor: Colors.blue,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            topLeft: Radius.circular(
                18.0
            ),
            bottomRight: Radius.circular(
                0
            ),
          )
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      child: _buildMyMsgText(msg),
    );
  }

  Widget _buildSenderMsgCard(ApiMessage msg)
  {
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      elevation: 10.0,
      surfaceTintColor: Colors.redAccent,
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            topLeft: Radius.circular(
                18.0
            ),
            bottomRight: Radius.circular(
                0
            ),
          )
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: _buildSenderMsgText(msg),
    );
  }

  Widget _buildSystemMsgCard(ApiMessage msg)
  {
    return Card(
      color: Colors.blueGrey,
      borderOnForeground: true,
      elevation: 10.0,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            topLeft: Radius.circular(
                10.0
            ),
            bottomRight: Radius.circular(
                10.0
            ),
          )
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      child: _buildSystemMsgText(msg),
    );
  }
  Widget buildMsgTxt(ApiMessage msg, int msgType)
  {
    Widget result = SizedBox.shrink();
    if(msgType == 1)
    {
      // Build my Msg Txt
      result = _buildMyMsgText(msg);
    }
    else if (msgType == 2)
    {
      // Build Sender Msg Txt
     result =  _buildSenderMsgText(msg);
    }
    else if (msgType == 3)
   {
     // Build System Msg Txt
     result = _buildSystemMsgText(msg);
   }

    return result;
  }

  Widget _buildMyMsgText(ApiMessage msg)
  {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
          child: (msg.body.length > 10) ? Text(msg.body.trim(), style: TextStyle(color:Colors.white))
              : Text(msg.body.trim()+"          ",
            style:TextStyle(color: Colors.white)
          ),
        ),
        Positioned(
            bottom: 4,
            right: 8,
            child: Text(
              DateFormat.jm().format(msg.createdOn),
              style: TextStyle(color: Colors.white)
            )
        )

      ],
    );
  }

  Widget _buildSenderMsgText(ApiMessage msg)
  {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
          child: (msg.body.length > 10) ? Text(msg.body.trim(), style: TextStyle(color:Colors.black87),)
              : Text(msg.body.trim()+"          ",
            style: TextStyle(color:Colors.black87),
          ),
        ),
        Positioned(
            bottom: 4,
            right: 8,
            child: Text(
              DateFormat.jm().format(msg.createdOn),
              style: TextStyle(color:Colors.black87),
            )
        )

      ],
    );
  }

  Widget _buildSystemMsgText(ApiMessage msg)
  {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
          child: (msg.body.length > 10) ? Text(msg.body.trim(), style: TextStyle(color:Colors.white))
              : Text(msg.body.trim()+"          ",
              style:TextStyle(color: Colors.white)
          ),
        ),
        Positioned(
            bottom: 4,
            right: 8,
            child: Text(
                DateFormat.jm().format(msg.createdOn),
                style: TextStyle(color: Colors.white)
            )
        )

      ],
    );
  }

}