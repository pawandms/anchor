
import 'package:anchor_getx/presentation/chat_screen/widgets/ChatListPage.dart';
import 'package:anchor_getx/presentation/chat_screen/widgets/MsgInputField.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../data/models/channel/ChnlParticipents.dart';
import '../../data/models/message/ApiMessage.dart';
import 'controller/chat_controller.dart';
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/widgets/app_bar/appbar_title.dart';
import 'package:anchor_getx/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:anchor_getx/widgets/app_bar/appbar_title_image.dart';
import 'package:anchor_getx/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if(controller.isLoading.isTrue)
        {
          return Center(child: CircularProgressIndicator());
        }
        else {
         return Scaffold(
              appBar: _buildAppBar(),
              body:Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 5.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.v),
                        _buildMsgList(controller.myId, controller.chnl.value.messages.value, controller.itemScrollController, context)
                      ])),
             bottomNavigationBar: _buildInputRow(context) ,
          );
        }

      }),

    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        height: 71.v,
        centerTitle: true,
        title: Column(
            children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                AppbarTitleImage(
                    imagePath: ImageConstant.imgClose,
                    margin: EdgeInsets.symmetric(vertical: 15.v),
                    onTap: () {
                      onTapClose();
                    }),
                AppbarTitle(
                    //text: controller.messageService.selectedChnl.value.name,
                    text: controller.chnl.value.name,
                    margin:
                        EdgeInsets.only(left: 108.h, top: 10.v, bottom: 6.v)),
                AppbarTitleCircleimage(
                    imagePath: ImageConstant.imgEllipse14,
                    margin: EdgeInsets.only(left: 95.h)),

              ])),
          SizedBox(height: 29.v),
          SizedBox(width: double.maxFinite, child: Divider())
        ]),
        styleType: Style.bgFill_1);
  }

  /// Section Widget
  Widget _buildInputRow(context) {
    return MsgInputField(context: context,
        submitMsgText: controller.addNewMessageTextToChat,

    );
  }

  /// Common widget
  Widget _buildDeliveredRow({required String deliveredText}) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text(deliveredText,
          style: CustomTextStyles.bodySmallGray600
              .copyWith(color: appTheme.gray600)),
      CustomImageView(
          imagePath: ImageConstant.imgSettingsDeepPurpleA200,
          height: 10.v,
          width: 15.h,
          margin: EdgeInsets.only(left: 12.h, top: 2.v, bottom: 2.v))
    ]);
  }

  Widget _buildMsgList(String myId, List<ApiMessage> messages, GroupedItemScrollController itemScrollController, BuildContext context) {
    Map<String,ChnlParticipent>userMap = Map.fromIterable(controller.chnl.value.users,
        key: (e) => e.userID,
        value: (e) => e);
    return Expanded(
     // child: ListPage(myId,messages,userMap, scrollControl, context),
      child: ChatListPage(myId,messages,userMap, itemScrollController, context),
    );
  }

  /// Navigates to the previous screen.
  onTapClose() {
    Get.back();
  }
}
