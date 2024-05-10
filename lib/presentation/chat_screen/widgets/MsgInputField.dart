
import 'dart:io';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/enums/ContentSrcType.dart';
import 'package:anchor_getx/data/enums/MediaInputType.dart';
import 'package:anchor_getx/data/models/media/MediaInput.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import 'UploadMediaPage.dart';

class MsgInputField extends StatelessWidget{

  final BuildContext context;
  final TextEditingController _controller = TextEditingController();
  Rx<bool> _isTextadded = false.obs;
  Rx<bool> _isEmojiMenuEnabled = false.obs;
  Function(String) submitMsgText;
  late Rx<MediaInput> _selectedMedia;
  RxList<MediaInput> _selectedFiles =RxList<MediaInput>();
  bool enableSoundBtn = true;
  bool enableCameraBtn = true;
  bool enableAttachmentBtn = true;

  MsgInputField({
    required this.context,
    required this.submitMsgText,
    this.enableSoundBtn = true,
    this.enableCameraBtn= true,
    this.enableAttachmentBtn= true,
  })
  {
    _controller.addListener(_onMsgBoxValueChange);

  }



  /*
  MsgInputField(this.context, this.submitMsgText, bool enableSoundBtn, bool enableCameraBtn, bool enableAttachmentBtn)
  {
    _controller.addListener(_onMsgBoxValueChange);
    this.enableSoundBtn = enableSoundBtn;
    this.enableCameraBtn = enableCameraBtn;
    this.enableAttachmentBtn = enableAttachmentBtn;

  }

   */

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
                        Visibility(
                          visible: enableCameraBtn == true,
                          child: IconButton(
                            icon: Icon(Icons.photo_camera ,  color: Colors.blueAccent),
                            onPressed: () {},
                          ),
                        ),
                        Visibility(
                          visible: enableSoundBtn == true,
                          child: IconButton(
                            icon: Icon(Icons.attach_file ,  color: Colors.blueAccent),
                            onPressed: _showUploadCard,
                          ),
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
                        visible: (_isTextadded.isFalse && enableSoundBtn == true),
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
                        visible: _isTextadded.isTrue || enableSoundBtn == false,
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

  _showUploadCard()
  {
    Get.bottomSheet(
        Wrap(
          //crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.end,
          children: [
            Container(
              height: 278,
              width: 400,
              child: Card(
                margin: const EdgeInsets.all(18.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconCreation(
                              Icons.insert_drive_file, Colors.indigo, ContentSourceType.Document),
                          SizedBox(
                            width: 20,
                          ),
                          iconCreation(Icons.camera_alt, Colors.pink, ContentSourceType.Camera),
                          SizedBox(
                            width: 20,
                          ),
                          iconCreation(Icons.insert_photo, Colors.purple, ContentSourceType.Gallery),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconCreation(Icons.headset, Colors.orange, ContentSourceType.Audio),
                          SizedBox(
                            width: 20,
                          ),
                          iconCreation(Icons.location_pin, Colors.teal, ContentSourceType.Location),
                          SizedBox(
                            width: 20,
                          ),
                          iconCreation(Icons.person, Colors.blue, ContentSourceType.Contact),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget iconCreation(IconData icons, Color color, ContentSourceType type) {
    return InkWell(
      onTap: () {
        iconSelected(type);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            type.name,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Future<void> iconSelected(ContentSourceType type)
  async {
    ImagePicker picker = ImagePicker();
    if((type == ContentSourceType.Gallery)
        || (type == ContentSourceType.Camera)
    )
    {
      Navigator.pop(context);
      print("Icon Selected with Type:"+type.name);
      List<XFile>? _paths = [] ;
      try {
        String _directoryPath = '';
        String _extension = '';
          if(type == ContentSourceType.Camera)
          {
           bool isCameraSupport = picker.supportsImageSource(ImageSource.camera);
           if(isCameraSupport)
           {
             print("Camara Picker Support Available");
             XFile? cameraFile  = await ImagePicker().pickVideo(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
             if(null != cameraFile )
             {
               _paths.add(cameraFile);
             }
           }

          }
          else {
            _paths = await ImagePicker().pickMultipleMedia();
          }

        if(_paths.isNotEmpty)
        {
          int i = 0;
          _selectedFiles.clear();
          _paths?.forEach((element) {
            String mimeType = lookupMimeType(element.name)!;
            print("Selected Mime Type is:"+mimeType);
            MediaInputType type = MediaInputTypeExtension.getType(mimeType);
            MediaInput input = MediaInput(key: i,type: type, file: element);
            _selectedFiles.value.add(input);
            i++;
          });

          _selectedMedia = _selectedFiles.first.obs;
          openUploadPreviewDialog(_selectedFiles);
        }
        else {
          return null;
        }
      } on PlatformException catch (e) {
        _logException('Unsupported operation' + e.toString());
      } catch (e) {
        _logException(e.toString());
      }
    }

  }

  void openUploadPreviewDialog(List<MediaInput> selectedMedia)
  {
    Get.dialog(
      Scaffold(
        appBar: _buildAppBar(),
        body: UploadMediaPage(_selectedFiles.value),

      ),
    );
  }


  void _logException(String message) {
    print(message);
    Get.snackbar(
       message,
      "Display the message here",
      colorText: Colors.white,
      backgroundColor: Colors.lightBlue,
      icon: const Icon(Icons.add_alert),
    );

  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: Text("lbl_upload_media".tr, style:  CustomTextStyles.titleSmallBlack90001),
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgClose,
            margin: EdgeInsets.only(left: 16.h, top: 13.v, bottom: 13.v),
            onTap: () {
            //  Get.back(closeOverlays: true);
              Navigator.pop(context);
            }),
        );
  }

  onMediaSelection(MediaInput selectedMedia)
  {
    _selectedMedia.value = selectedMedia;

  }


}