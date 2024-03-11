import 'package:anchor_getx/presentation/chat_screen/widgets/chat_item_widget.dart';

import '../../data/models/message/ApiMessage.dart';
import 'controller/chat_controller.dart';
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/widgets/app_bar/appbar_title.dart';
import 'package:anchor_getx/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:anchor_getx/widgets/app_bar/appbar_title_image.dart';
import 'package:anchor_getx/widgets/app_bar/custom_app_bar.dart';
import 'package:anchor_getx/widgets/custom_elevated_button.dart';
import 'package:anchor_getx/widgets/custom_icon_button.dart';
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
                  padding: EdgeInsets.symmetric(vertical: 24.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       // SizedBox(height: 10.v),
                        _buildMessagesList(controller.myId, controller.chnl.value.messages.value)
                      ])),

             bottomNavigationBar:  _buildMessageBoxRow(),
          );
        }

      }),

    );
  }



    /*
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 41.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 152.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 12.v),
                          decoration: AppDecoration.white.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL15),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 3.v),
                                Text("msg_hi_larry_how_are".tr,
                                    style: theme.textTheme.bodyMedium)
                              ])),
                      SizedBox(height: 9.v),
                      _buildDeliveredRow(deliveredText: "lbl_delivered".tr),
                      SizedBox(height: 22.v),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: 286.h,
                              margin: EdgeInsets.only(right: 96.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.h, vertical: 6.v),
                              decoration: AppDecoration.fillDeepPurple.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.customBorderBL15),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 6.v),
                                    Container(
                                        width: 226.h,
                                        margin: EdgeInsets.only(right: 19.h),
                                        child: Text("msg_hello_gerry_i_m".tr,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .bodyMediumPrimaryContainer
                                                .copyWith(height: 1.50)))
                                  ]))),
                      SizedBox(height: 24.v),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(right: 111.h),
                              child: Row(children: [
                                Column(children: [
                                  CustomImageView(
                                      imagePath: ImageConstant.img49,
                                      height: 65.v,
                                      width: 109.h,
                                      radius: BorderRadius.only(
                                          topLeft: Radius.circular(15.h))),
                                  SizedBox(height: 2.v),
                                  CustomImageView(
                                      imagePath: ImageConstant.img50,
                                      height: 65.v,
                                      width: 109.h,
                                      radius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.h)))
                                ]),
                                CustomImageView(
                                    imagePath: ImageConstant.img51,
                                    height: 130.v,
                                    width: 160.h,
                                    radius: BorderRadius.horizontal(
                                        right: Radius.circular(15.h)),
                                    margin: EdgeInsets.only(left: 2.h))
                              ]))),
                      SizedBox(height: 24.v),
                      CustomElevatedButton(
                          height: 45.v,
                          width: 179.h,
                          text: "lbl_wow_awesome".tr,
                          buttonStyle: CustomButtonStyles.fillDeepPurpleATL15,
                          buttonTextStyle: theme.textTheme.bodyMedium!),
                      SizedBox(height: 9.v),
                      _buildDeliveredRow(deliveredText: "lbl_delivered".tr),
                      SizedBox(height: 5.v)
                    ])),
            bottomNavigationBar: _buildMessageBoxRow()));
  }
  */

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        height: 71.v,
        centerTitle: true,
        title: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                    margin: EdgeInsets.only(left: 95.h))
              ])),
          SizedBox(height: 29.v),
          SizedBox(width: double.maxFinite, child: Divider())
        ]),
        styleType: Style.bgFill_1);
  }

  /// Section Widget
  Widget _buildMessageBoxRow() {
    return Padding(
        padding: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 39.v),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomIconButton(
              height: 50.v, width: 316.h, child: CustomImageView()),
          Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: CustomIconButton(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  padding: EdgeInsets.all(13.h),
                  decoration: IconButtonStyleHelper.fillDeepPurpleATL25,
                  child:
                      CustomImageView(imagePath: ImageConstant.imgGroup9143)))
        ]));
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

  /// Section Widget
  Widget _buildMessagesList(String myId, List<ApiMessage> messages) {
    return Expanded(
      child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0.v),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Divider(
                        height: 1.v,
                        thickness: 1.v,
                        color: theme.colorScheme.secondaryContainer)));
          },
          itemCount:
          messages.length,

          itemBuilder: (context, int index) {

            ApiMessage model = messages.elementAt(index);
            //  .channel[index];
            return InkWell(
                onTap: () {
                  print("Chat Message Clicket");
                },
                child: ChatItemWidget(myId, model)
            );

          }),
    );
  }

  /// Navigates to the previous screen.
  onTapClose() {
    Get.back();
  }
}
