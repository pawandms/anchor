import 'dart:io';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/utils/Helper.dart';
import 'package:anchor_getx/data/enums/AttachmentType.dart';
import 'package:anchor_getx/data/enums/MediaInputType.dart';
import 'package:anchor_getx/data/models/message/ApiMessage.dart';
import 'package:anchor_getx/widgets/VideoPlayerView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/enums/MsgType.dart';
import '../../../data/models/media/MediaInput.dart';
import '../../../data/models/message/Attachment.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../controller/chat_controller.dart';
import 'MsgInputField.dart';

class UploadMediaPage extends StatelessWidget{

  RxList<MediaInput> mediaList =  RxList();
  late Rx<MediaInput> _selectedMedia;
  ScrollController _controller = ScrollController();
  ChatController chatController = Get.find<ChatController>();
  UploadMediaPage(List<MediaInput> inputList)
 {
   mediaList.value.addAll(inputList);
   _selectedMedia = mediaList.first.obs;
   //chatController = Get.find<ChatController>();
 }

  void _update(oldIdx, newIdx) {
    var el = mediaList.value[oldIdx];

    if (newIdx > oldIdx) {
      newIdx = mediaList.value.length - 1;
    }
    mediaList.value.removeAt(oldIdx);
    mediaList.value.insert(newIdx, el);
    print("Update List : ");
    mediaList.value.forEach((element) {
      print(element.key);
    }
    );
   }

  void deleteMediaInput(int itemKey)
  {
    mediaList.value.removeWhere((element) => element.key == itemKey);
    if(itemKey == _selectedMedia.value.key)
    {
      if(mediaList.isNotEmpty)
      {
        _selectedMedia.value = mediaList.value.first;
      }
      else {
        _selectedMedia.value = MediaInput(key: 0, type: MediaInputType.Unknown );
      }

    }
    //mediaList.refresh();

  }


  @override
  Widget build(BuildContext context) {
     return Obx (()=>  Column(
        mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 3,
              child:
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*0.95,
                    child:  _selectedMedia != null ? showWidget(_selectedMedia.value, BoxFit.cover, context, 1): Text('No Preview Available'),
                  )
              ),

          Flexible(
            flex: 2,
            child: Container(
              child: Scrollbar(
                controller: _controller,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child:ReorderableListView(
                  primary: false,
                scrollController: _controller,
                   padding: EdgeInsets.only(left: 10,bottom: 5, right: 5, top: 10),
                  scrollDirection: Axis.horizontal,

                  children: [
                    for (final item in mediaList)
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 2),
                          key: ValueKey(item.key),
                          // width: 400,
                          child: InkWell(
                            child: buildCard(item.key, item, context) ,
                            onTap: (){
                              onMediaSelection(item);
                            },

                            )


                      )
                  ],
                  onReorder: _update,
                ),
              ),
            ),

          ),
          Container(
            child: _buildInputRow(context),
          ),
        ],
      ));

  }

  Widget buildCard(int indexKey, MediaInput media, BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      key: ValueKey(indexKey),
      elevation: 10,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            key: key,
            child: Container(
              width: 200,
              child: showWidget(media, BoxFit.fill, context, 0),
            )

          ),
          SizedBox(height: 10,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                 // width: 150,
                  //height: 20,
                  // width: 150,
                    child: Text(media.file!.name,
                      style: TextStyle(color: Colors.grey.shade600, fontWeight: false ?FontWeight.bold:FontWeight.normal, overflow: TextOverflow.ellipsis),

                    )

                ),
                Align(alignment: Alignment.topRight,
                  //widthFactor: 09,
                  child:  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.blue),
                    tooltip: 'Delete media',
                    onPressed: () {
                      deleteMediaInput(media.key);
                    },
                  ),)
              ],
            ),
          )

        ],
      ),
    );
  }

  showWidget(MediaInput media, BoxFit boxFit, BuildContext context, int type){
    if(media.type == MediaInputType.Unknown)
    {
      return Center(child:
      ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox.fromSize(
          // size: const Size.fromRadius(144),
            child: GetPlatform.isWeb ?Image.asset('assets/images/image_not_found.png', fit: boxFit, alignment: Alignment.center,)
                : Image.file(File(media.file!.path), fit: boxFit, alignment: Alignment.center,)
        ),
      ),
      );


    }
    else if(media.type == MediaInputType.Image)
    {
      print("file path:"+File(media.file!.path).uri.toString());

      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: GetPlatform.isWeb ?
        //Image.network(media.file!.path, fit: BoxFit.scaleDown, alignment: Alignment.center,)
        CustomImageView(
          imagePath: media.file!.path,
          imgType: ImageType.network,
          fit: boxFit,
          // height: 161.v,
          // width: 117.h,
          radius: BorderRadius.circular(
            10.h,
          ),
        )
            :
        CustomImageView(
          imagePath: media.file!.path,
          imgType: ImageType.file,
         fit: boxFit,
         // height: 161.v,
         // width: 117.h,
          radius: BorderRadius.circular(
            10.h,
          ),
        )
        //Image.file(File(media.file!.path), fit: BoxFit.fill, alignment: Alignment.center,),
        );

    } else if (media.type == MediaInputType.Video)
    {
      return Center(child:
      ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox.fromSize(
          // size: const Size.fromRadius(144),
            child: type == 0 ? VideoPlayerView(input: media,context:  context,key: Key(media.key.toString()), )
                :VideoPlayerView(input: media,context:  context,key: Key(media.key.toString()+"_Selected"),)
        ),
      ),
      );
    }
    else {
      return Placeholder();
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgClose,
          margin: EdgeInsets.only(left: 16.h, top: 13.v, bottom: 13.v),
          onTap: () {
            Get.back(closeOverlays: true);
          }),
    );
  }

  onMediaSelection(MediaInput selectedMedia)
  {
    _selectedMedia.value = selectedMedia;
    mediaList.refresh();

  }

  Widget _buildInputRow(context) {
    return MsgInputField(context: context,
        //submitMsgText: chatController.addNewMessageToChat,
      submitMsgText: submitMultiMediaMsg,
        enableSoundBtn: false,
        enableAttachmentBtn: false,
      enableCameraBtn: false,
        );
  }

  void submitMultiMediaMsg(String msgTxt)
  {
    String myId = chatController.myId;
    String msgID = "new_"+DateTime.now().millisecond.toString();
    MsgType type = MsgType.Text;

    ApiMessage msg = new ApiMessage(id: msgID,  type: type, body: msgTxt,createdBy:myId , createdOn: DateTime.now(), modifiedBy: myId, modifiedOn: DateTime.now());
    if(mediaList.isNotEmpty)
    {
      List<Attachment> attachments =  Helper.convertMediaInputToAttachment(mediaList, myId);
      msg.attachments = attachments;
      msg.attachmentType = AttachmentType.Local;

    }
    Navigator.pop(Get.overlayContext!, true);
   // Get.back(closeOverlays: true);
    chatController.addNewMessageToChat(msg);

  }
}