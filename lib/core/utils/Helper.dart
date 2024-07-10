
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:intl/intl.dart';
import '../../data/enums/MsgReactionType.dart';
import '../../data/models/media/MediaInput.dart';
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
    reactionItems.add(_getReactionItem(MsgReactionType.Wink));
    reactionItems.add(_getReactionItem(MsgReactionType.Angry));
    reactionItems.add(_getReactionItem(MsgReactionType.Sad));
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
      result =  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: reactionWidgetList
      );


    }

    return result;

  }


}