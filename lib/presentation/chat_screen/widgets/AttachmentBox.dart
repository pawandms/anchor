
import 'dart:math';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/widgets/VideoPlayerView.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../data/enums/MediaInputType.dart';
import '../../../data/enums/MsgEventType.dart';
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
  Widget build(ctx) {
    /*
    const BoxDecoration chatBackgroundDecoration = BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFFe3edff),
              Color(0xFFcad8fd)
            ]
        )
    );
    */
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

    return InkWell(
      onLongPress: _enableMsgReactionMenu,
      child: Row(
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
                width: (MediaQuery.of(ctx).size.width < 600) ? MediaQuery.of(ctx).size.width * 0.50 : MediaQuery.of(ctx).size.width * 0.40,
                child: Align(
                  alignment: msg.createdBy == myId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child:  //Obx(()=> _attachmentComponent(msg, ctx  )),

                  Card(
                   // color: Colors.white,
                    borderOnForeground: true,
                    elevation: 10.0,
                    surfaceTintColor: Colors.white70,
                    shadowColor: Colors.white,
                    /*
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),

                        )
                    ),

                     */
                    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    child: Obx(()=> _attachmentComponent(msg, ctx  )),
                  ),

                ),
              ),
            ],
          ),
        ],
      ),
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

  Widget _attachmentComponent(ApiMessage msg, BuildContext wcontext)
  {
    int _crossAxisCount = 2;
   // double _width = MediaQuery.of(context).size.width * 0.50;
    int contentSize = msg.attachments.length ;
    List<Widget> items = [];
    if (contentSize == 1) {
      _crossAxisCount = 1;
     // _width = 200;
      items.add(_attachmentMedia( msg.attachments[0], 0,wcontext, msg.msgEvent.value));
    }
    else if(contentSize > 1 && contentSize <= 4)
    {
      for (int i = 0; i <= contentSize-1; i++) {
        items.add(_attachmentMedia(msg.attachments[i], 0, wcontext, msg.msgEvent.value));
      }
    }
    else if ((contentSize > 1 && contentSize > 4))
    {
      int remaining_item = contentSize - 4;
      for (int i = 0; i <= 3; i++) {
        if( i == 3 )
        {
          items.add(_attachmentMedia( msg.attachments[i], remaining_item, wcontext, msg.msgEvent.value));
        }
        else {
          items.add(_attachmentMedia(msg.attachments[i], 0, wcontext, msg.msgEvent.value));
        }

      }

    }
    print ("Preparing attachment Box Items Completed.....with Item Size:"+items.length.toString());
    return SizedBox(
      //width: _width,
      child:
      GridView.count(
        shrinkWrap: true,
       // primary: true,
       // padding: const EdgeInsets.all(01),
        crossAxisSpacing: 01,
        mainAxisSpacing: 01,
        crossAxisCount: _crossAxisCount,
        children: items,
       /*
        children: List.generate(items.length, (index) =>
            Container(
              color: Colors.green,
              alignment: Alignment.topLeft,
              child: items[index]
            )
        ),
        */

      ),

    );
  }
  Widget _attachmentMedia( Attachment attachment, int remaining, BuildContext wcontext, MsgEventType msgEvent )
  {
    Widget result = SizedBox.shrink();
    try{
      if(msgEvent == MsgEventType.Sending)
      {
        result = LinearProgressIndicator(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        );
      }
      else {
        Widget media = _getMsgAttachmentItem(wcontext, attachment);
        if(remaining > 0)
        {
          result = _prepareMoreMediaWidget(media, remaining, attachment);
        }
        else {
          result =  _prepareMediaWidget(media, attachment);
        }

      }

    }
    catch(e,stacktrace)
    {
      Logger.log(e.toString(),stackTrace: stacktrace);
    }

    return result;

  }


  Widget _prepareMediaWidget(Widget media, Attachment attachment)
  {
    Widget result = SizedBox.shrink();
    try{
     result =  InkWell(
        onTap: (){
          print("click on Attachmet with ID:"+attachment.contentID+" , for Msg:"+msg.id);
          openUploadPreviewDialog(msg, attachment);
        },
        child:
        Card(
          color: Colors.white,
          borderOnForeground: true,
          elevation: 10.0,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                topLeft: Radius.circular(18.0),
                bottomRight: Radius.circular(18.0),
              )
          ),
         // margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          child: media,
        )
       /*
        SizedBox(
          child: Shadow(
            options: ShadowOptions(
              offset: Offset(5, 5),
              scale: 1,
              blur: 4,
            ),
            child:media
            ,
          ),
        ),
       */
      );
    }
    catch(e,stacktrace)
    {
      Logger.log(e.toString(),stackTrace: stacktrace);
    }

    return result;
  }

  Widget _prepareMoreMediaWidget(Widget media, int remaining, Attachment attachment)
  {
    Widget result = SizedBox.shrink();
    try{
    result =   InkWell(
        onTap: (){
          openUploadPreviewDialog(msg, attachment);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
         //clipBehavior: Clip.antiAliasWithSaveLayer,
         // fit: StackFit.expand,
          children: <Widget>[
            Shadow(
              options: ShadowOptions(
                offset: Offset(5, 5),
                scale: 1,
                blur: 4,
              ),
              child: media,
            ),

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
    catch(e,stacktrace)
    {
      Logger.log(e.toString(),stackTrace: stacktrace);
    }

    return result;
  }
  MediaInput getAttachmentUrl(Attachment attachment)
  {
    String url =  messageService.getAttachmentUrl(attachment);
    MediaInput input = MediaInput( type: attachment.type, url: url);
   return input;

  }

  void openUploadPreviewDialog(ApiMessage msg, Attachment selectedAttachment)
  {
    int selectedIndex = msg.attachments.indexOf(selectedAttachment);

    Get.dialog(
      Scaffold(
        appBar: AppBar(
        //  title: Text(selectedAttachment.contentID),
        ),
        body: getAttachmentPreviewWidget(msg.attachments, selectedIndex),

      ),
    );

    print("OpenUpload Preview Dialog for Atch:"+selectedAttachment.contentID);
  }


  Widget getAttachmentPreviewWidget(List<Attachment> attachments, int selectedIndex)
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
        initialScrollIndex: selectedIndex,
        itemComparator: (e1, e2) => e1.contentID.compareTo(e2.contentID),
        itemBuilder: _getZoomAttachmentItem,

      ),
    );
  }

  Widget _getZoomAttachmentItem(BuildContext wcontext,  Attachment item)
  {
    Widget itemWg = _getMsgAttachmentItem(wcontext, item);
    return ZoomWidget(itemWg, item.id);
  }

  Widget _attachmentGroupSeparator(Attachment attachment)
  {
    return SizedBox.shrink();
  }


  Widget _getMsgAttachmentItem(BuildContext wcontext,  Attachment item) {
    Widget result = SizedBox.shrink();
    if(item.type == MediaInputType.Image)
      result = Container(
        padding: EdgeInsets.all(5),
          constraints: BoxConstraints(
            //minHeight: 200,
           // minWidth: 200,

          ),
        //constraints: BoxConstraints.expand(width: 300),
       // width: 200,
       // color: Colors.blue,
        child: CustomImageView(
            imagePath: getAttachmentUrl(item).url,
            // height: 400.adaptSize,
            // width: 400.adaptSize,
             fit: BoxFit.cover,
            radius: BorderRadius.circular(
              05,
            )
        ),
      );
    if(item.type == MediaInputType.Video)
      result =  VideoPlayerView(input: getAttachmentUrl(item), context: wcontext, key: Key(item.contentID+"_MsgCard"),);

    return result;
   // return ZoomWidget(result, item.id);

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

  void _enableMsgReactionMenu()
  {
    print("LogPress on AttachmentBox to enable Msg Reaction Menu");
  }
}