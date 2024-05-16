
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/widgets/VideoPlayerView.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../data/enums/MediaInputType.dart';
import '../../../data/models/media/MediaInput.dart';
import '../../../data/models/message/ApiMessage.dart';
import '../../../data/models/message/Attachment.dart';
import '../../../widgets/custom_image_view.dart';
import '../../messages_page/service/message_service.dart';
import 'package:shadow/shadow.dart';

class AttachmentBox extends StatelessWidget {
  final BuildContext ctx;
  final ApiMessage msg;
  final String myId;
  MessageService  messageService;
  //final Map<String,ChnlParticipent>userMap;


   AttachmentBox({
    super.key,
    required this.ctx,
    required this.myId,
    required this.msg,
    //required this.userMap
     messageService
  }):messageService = Get.find<MessageService>();



  @override
  Widget build(BuildContext context) {
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

    return Row(
      mainAxisAlignment: msg.createdBy == myId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: msg.createdBy == myId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Align(
                alignment: msg.createdBy == myId
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: Colors.white,
                  borderOnForeground: true,
                  elevation: 10.0,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.black,
                  /*
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),

                      )
                  ),

                   */
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: _attachmentComponent(msg, MediaQuery.of(ctx).size.width * 0.50, context  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getUserName(String userID)
  {
    /*
    String result = userID;
    if(userMap.containsKey(userID))
     {
       ChnlParticipent cp = userMap[userID]!;
       result =  cp.firstName+" "+cp.lastName;
     }
    */
    return userID;
  }

  Widget _attachmentComponent(ApiMessage msg, double _width, BuildContext ctx)
  {
    int _crossAxisCount = 2;
   // double _width = MediaQuery.of(context).size.width * 0.50;

    int contentSize = msg.attachments.length ;
    List<Widget> items = [];
    if (contentSize == 1) {
      _crossAxisCount = 1;
     // _width = 200;
      items.add(_attachmentMedia( msg.attachments[0], 0));
    }
    else if(contentSize > 1 && contentSize <= 4)
    {
      for (int i = 0; i <= contentSize-1; i++) {
        items.add(_attachmentMedia(msg.attachments[i], 0));
      }
    }
    else if ((contentSize > 1 && contentSize > 4))
    {
      int remaining_item = contentSize - 4;
      for (int i = 0; i <= 3; i++) {
        if( i == 3 )
        {
          items.add(_attachmentMedia( msg.attachments[i], remaining_item));
        }
        else {
          items.add(_attachmentMedia(msg.attachments[i], 0));
        }

      }

    }

    return SizedBox(
      width: _width,
      child:
      GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(05),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: _crossAxisCount,
        children: items,

      ),

    );
  }
  Widget _attachmentMedia( Attachment attachment, int remaining)
  {
    print("_attachmentMedia called for Attachment"+attachment.contentID+" , With Remaining:$remaining");
    if (remaining > 0)
    {
      return InkWell(
        onTap: (){
          print("click on Attachmet with ID:"+attachment.contentID+" , for Msg:"+msg.id);
          openUploadPreviewDialog(msg, attachment);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          //fit: StackFit.expand,
          children: <Widget>[
         //   if(attachment.type == MediaInputType.Image)
            Shadow(
                options: ShadowOptions(
                  offset: Offset(5, 5),
                  scale: 1,
                  blur: 4,
                ),
              child: _getMsgAttachmentItem(ctx, attachment),
            ),
           // if(attachment.type == MediaInputType.Video)

             // VideoPlayerView(input: getAttachmentUrl(attachment),context:  this.ctx, key: Key(attachment.contentID)),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: ColoredBox(
                color:  Colors.black.withOpacity(.7),
                child: Center(
                  child: Text(
                    "+${remaining}",
                    style:
                    const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    else {
      return InkWell(
        onTap: (){
          print("click on Attachmet with ID:"+attachment.contentID+" , for Msg:"+msg.id);
          openUploadPreviewDialog(msg, attachment);
        },
        child: SizedBox(
          child: Shadow(
              options: ShadowOptions(
                offset: Offset(5, 5),
                scale: 1,
                blur: 4,
              ),
            child:_getMsgAttachmentItem(ctx, attachment)
            ,
          ),
        ),
      );
    }

  }

  MediaInput getAttachmentUrl(Attachment attachment)
  {
    String url =  messageService.getAttachmentUrl(attachment);
    MediaInput input = MediaInput( type: attachment.type, url: url);
   return input;

  }

  void openUploadPreviewDialog(ApiMessage msg, Attachment selectedAttachment)
  {
    /*
    Get.dialog(
      Scaffold(
        appBar: AppBar(
        //  title: Text(selectedAttachment.contentID),
        ),
        body: getAttachmentList(msg.attachments),

      ),
    );

     */
    print("OpenUpload Preview Dialog for Atch:"+selectedAttachment.contentID);
  }



  Widget getAttachmentList(List<Attachment> attachments)
  {
    final itemPositionsListener = ItemPositionsListener.create();
    final itemScrollController = GroupedItemScrollController();
    return Scaffold(
      body: StickyGroupedListView<Attachment, String>(
        elements: attachments,
        groupBy: (Attachment i) => i.contentID,
          groupSeparatorBuilder: _attachmentGroupSeparator,
        elementIdentifier: (Attachment element) => element.contentID,
        itemPositionsListener: itemPositionsListener,
        itemScrollController: itemScrollController,
        floatingHeader: true,
        itemComparator: (e1, e2) => e1.contentID.compareTo(e2.contentID),
        itemBuilder: _getAttachmentItem,

      ),
    );
  }

  Widget _attachmentGroupSeparator(Attachment attachment)
  {
    return SizedBox.shrink();
  }


  Widget _getMsgAttachmentItem(BuildContext ctx, Attachment item) {
    print("Getting Msg Attachment Item for :"+item.contentID);
    Widget result = SizedBox.shrink();
    if(item.type == MediaInputType.Image)
      result = CustomImageView(
          imagePath: getAttachmentUrl(item).url,
          // fit: BoxFit.cover,
          radius: BorderRadius.circular(
            10,
          )
      );
    if(item.type == MediaInputType.Video)
      result =  VideoPlayerView(input: getAttachmentUrl(item), context: this.ctx, key: Key(item.contentID+"_MsgCard"),);

    return result;

  }

  Widget _getAttachmentItem(BuildContext ctx, Attachment item) {
    Widget result = SizedBox.shrink();
    if(item.type == MediaInputType.Image)
      result = CustomImageView(
          imagePath: getAttachmentUrl(item).url,
          // fit: BoxFit.cover,
          radius: BorderRadius.circular(
            10,
          )
      );
    if(item.type == MediaInputType.Video)
   result =   VideoPlayerView(input: getAttachmentUrl(item), context: this.ctx, key: Key(item.contentID),);
    return result;

  }
  Widget ZoomWidget(Widget widget, String id)
  {
    return WidgetZoom(
      heroAnimationTag: id,
      zoomWidget: Card(
        color: Colors.white,
        borderOnForeground: true,
        elevation: 10.0,
        surfaceTintColor: Colors.red,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              topLeft: Radius.circular(18.0),
              bottomRight: Radius.circular(18.0),
            )
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: widget,
      ),
    );
  }
}