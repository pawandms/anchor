
import 'package:anchor_getx/core/app_export.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MsgInputField extends StatelessWidget{

  final BuildContext context;
  final TextEditingController _controller = TextEditingController();
  Rx<bool> _isTextadded = false.obs;
  Rx<bool> _isEmojiMenuEnabled = false.obs;
  Function(String) submitMsgText;
  MsgInputField(this.context, this.submitMsgText)
  {
    _controller.addListener(_onMsgBoxValueChange);
  }

   void _onMsgBoxValueChange()
   {
     final text = _controller.text;
     if(text.characters.length > 0)
      {
        if(_isTextadded.isFalse)
        {
          _isTextadded.value = true;
        }
      }
     else {
       _isTextadded.value = false;
     }
   }


  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 10.v),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.face , color: Colors.blueAccent,), onPressed: () {
                              _isEmojiMenuEnabled.value = !_isEmojiMenuEnabled.value;
                        }),
                        Expanded(
                          child: TextField(
                           // focusNode: _focus,
                            decoration: InputDecoration(
                                hintText: "Type Something...",
                                border: InputBorder.none),
                            controller: _controller,
                            maxLines: 5,
                            minLines: 1,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_camera ,  color: Colors.blueAccent),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.attach_file ,  color: Colors.blueAccent),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                  child : Obx( () =>Row(
                    children: [
                      Visibility(
                        visible: _isTextadded.isFalse,
                        child: InkWell(
                          child: Icon(
                            Icons.keyboard_voice,
                            color: Colors.white,
                          ),
                          onLongPress: () {
                          },
                        ),
                      ),
                      Visibility(
                        visible: _isTextadded.isTrue,
                        child: InkWell(
                         child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _submitTextMsg();
                          },
                        ),
                      ),

                  ],
                 ))


                ),

               /*
                Container(
                  child: Obx(() => Expanded(child: _buildEmojiMenu()))
                )
                */


              ],
            ),

          ),
        Row(
          children: [
            Expanded(
             // flex: 10,
                child: Obx(() =>  _buildEmojiMenu())
            ),
          ],
        )


      ],
    );


  }

  void _submitTextMsg()
  {
    String text = _controller.text;
    if(text.length > 0)
    {
      submitMsgText(text);
    }

  }

  Widget _buildEmojiMenu()
  {
    return Offstage(
      offstage: _isEmojiMenuEnabled.isFalse,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
            onEmojiSelected: (Category? category, Emoji emoji) {
              _onEmojiSelected(emoji);
            },

            onBackspacePressed: _onBackspacePressed,
            config: Config(

                columns: 7,
                // Issue: https://github.com/flutter/flutter/issues/28894
                emojiSizeMax: 32 *  1.0,
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,

                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                // progressIndicatorColor: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,

                // showRecentsTab: true,
                recentsLimit: 28,

                noRecents: Text('No Recents',
                  style: const TextStyle(
                      fontSize: 20, color: Colors.black26),
                ),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL
            )
        ),


      ),
    );
  }
  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

}