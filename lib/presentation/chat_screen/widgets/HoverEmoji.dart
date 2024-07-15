import 'package:anchor_getx/data/enums/MsgReactionType.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// Demo widget that demonstrates how to use [AnimationController] with [AnimatedEmoji].
class HoverEmoji extends StatefulWidget {
  /// Demo widget that demonstrates how to use [AnimationController] with [AnimatedEmoji].
  final String msgId;
  MsgReactionType emojiType;
  Rx<int> count;
  double size;
   Function (String msgId, MsgReactionType emoiType ) callbackFunction;
  HoverEmoji(
      {
    super.key,
    required this.msgId,
    this.size = 25,
    int itemCount = 0,
    required this.emojiType,
    required this.callbackFunction

  }): count = itemCount.obs
  ;

  @override
  State<HoverEmoji> createState() => _HoverEmojiState();
}

class _HoverEmojiState extends State<HoverEmoji>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
   // widget.emojiType = MsgReactionTypeExtension.getType(widget.emojiTxt);
    controller = AnimationController(
      vsync: this,
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
      child: Tooltip(
        message: widget.emojiType.name,
        child: Padding(
          padding: const EdgeInsets.only(right: 3),
          child: _getEmojiWidget(widget.emojiType, widget.size,widget.count.value),
        ),
      ),
    );
  }



  Widget _getEmojiWidget(MsgReactionType type, double _size, int itemCount)
  {
    print('Building Emoji With Type:${type.name}, count:${itemCount}');
    Widget result = SizedBox.shrink();
   // MsgReactionType type = MsgReactionTypeExtension.getType(emojiTxt);
    if((type != null) & (type != MsgReactionType.Unknown))
    {
      result =  InkWell(
        onTap: _EmojiClickedEvent,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
         // spacing: 5,
          children: [
            _getEmojiIcon(type, _size),
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 3),
              child: Text(
                itemCount.toString(),
                style: TextStyle(
                  color: Colors.black,

                ),
              ),
            )
          ],
        ),
      );

    }
   return result;
  }

  void _EmojiClickedEvent()
  {
    widget.callbackFunction( widget.msgId, widget.emojiType);
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
        onLoaded: (duration) {
          // Get the duration of the animation.
          controller.duration = duration;
        },
      );
    }
    return result;
  }
}