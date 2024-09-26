
import 'package:anchor_getx/presentation/message_screen/controller/messageScreenController.dart';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/message_screen/msg_page.dart';
import 'package:anchor_getx/presentation/message_screen/widgets/ConversationList.dart';
import 'package:flutter/material.dart';

import '../../data/models/channel/ChnlParticipents.dart';
import '../../data/models/channel/UserChannel.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class MessageScreen extends GetView<MessageScreenController> {
  MessageScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MsgPage(controller);
    /*
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 24.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text("lbl_messages".tr,
                              style: theme.textTheme.headlineSmall)),
                      //_buildStories(),
                      SizedBox(height: 10.v),
                      _buildMessagesList()
                    ]))));

     */
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowBackDeepPurpleA200,
            margin: EdgeInsets.only(left: 16.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapArrowBack();
            }),
      title: AppbarTitle(
        onTap: (){
          Get.toNamed(
            AppRoutes.appNavigationScreen,
          );
        },
          text: 'channel list',
          margin:
          EdgeInsets.only(left: 108.h, top: 10.v, bottom: 6.v))
        //text: controller.messageService.selectedChnl.value.name,

        /*
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgAddDeepPurpleA200,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v))
        ]

         */
    );
  }

  /// Section Widget
  Widget _buildMessagesList() {
    return Obx(() => Expanded(
      child: ListView.separated(
        //  physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0.v),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Divider(
                        height: 2.v,
                        thickness: 2.v,
                        color: theme.colorScheme.secondaryContainer)));
          },
          itemCount:
          controller.userChnlMap.length,

          itemBuilder: (context, int index) {
            String key = controller.userChnlMap.keys.elementAt(index);
            UserChannel model = controller.userChnlMap[key]!;
            //  .channel[index];
            return InkWell(
              onTap: () {
                onChannelSelection(model.chnlId);
              },
                child: ConversationList(model, onChannelSelection,context, controller)
            );
          }),
    ));
  }

  /// Navigates to the previous screen.
  onTapArrowBack() {
    //Get.back();
    Get.rootDelegate.popRoute();
  }

   onChannelSelection(String selectedChannelId)
  {
    controller.setSelectedChannel(selectedChannelId);
  }

}
