

import 'package:anchor_getx/data/enums/MsgReactionType.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emoji_data.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';

/// Demo widget that demonstrates how to use [AnimationController] with [AnimatedEmoji].
class EmojiIcon extends StatefulWidget {
  /// Demo widget that demonstrates how to use [AnimationController] with [AnimatedEmoji].
  MsgReactionType emojiType;
  double size;
  //final Function(String msgId, MsgReactionType emoiType ) callbackFunction;
  EmojiIcon(
      {
    super.key,
    this.size = 25,
    required this.emojiType,
    //required this.callbackFunction

  });

  @override
  State<EmojiIcon> createState() => _EmojiIconState();
}

class _EmojiIconState extends State<EmojiIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;


  @override
  void initState() {
    super.initState();
   // widget.emojiType = MsgReactionTypeExtension.getType(widget.emojiTxt);
    controller = AnimationController(
      vsync: this,
      duration: Duration()
    );
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        controller.forward(from: 0);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 3),
        child: _getEmojiWidget(widget.emojiType, widget.size),
      ),
    );
  }



  Widget _getEmojiWidget(MsgReactionType type, double _size)
  {
    Widget result = SizedBox.shrink();
    if((type != null))
    {
      result =  _getEmojiIcon(type, _size);
    }
   return result;
  }

  void _EmojiClickedEvent()
  {
    //widget.callbackFunction( widget.msgId, widget.emojiType);
  }

  Widget _getEmojiIcon(MsgReactionType type, double _size)
  {
    Widget result = SizedBox.shrink();
    if(type == MsgReactionType.Like)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.thumbsUp,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else if(type == MsgReactionType.DisLike)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.thumbsDown,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else if(type == MsgReactionType.Love)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.redHeart,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else if(type == MsgReactionType.Smile)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.smile,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
   else  if(type == MsgReactionType.Laugh)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.laughing,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else  if(type == MsgReactionType.Wink)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.wink,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else  if(type == MsgReactionType.Angry)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.angry,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else  if(type == MsgReactionType.Sad)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.sad,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else  if(type == MsgReactionType.Surprised)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.surprised,
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    else  if(type == MsgReactionType.Unknown)
    {
      result = AnimatedEmoji(
        AnimatedEmojis.thumbsUp.withSkinTone(SkinTone.light),
        controller: controller,
        size: _size,
        source: AnimatedEmojiSource.asset,
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    return result;
  }
}