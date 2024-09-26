
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/message_screen/widgets/ConversationList.dart';
import 'package:flutter/material.dart';
import '../../data/models/channel/UserChannel.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title_searchview.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/messageScreenController.dart';

class MsgPage extends StatelessWidget
{
  //MessageScreenController controller = Get.put(MessageScreenController());
  MessageScreenController controller;
  MsgPage(this.controller);

  @override
  Widget build(BuildContext context) {
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
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        leadingWidth: 40.h,
        title: CustomSearchView(
          onChanged: controller.messageScreenSearch ,
         alignment: Alignment.center,
         autofocus: false,
         // margin: EdgeInsets.only(left: 16.h),
          hintText: "lbl_search".tr,
          //controller: controller.searchController,
        ),
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowBackDeepPurpleA200,
            margin: EdgeInsets.only(left: 16.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapArrowBack();
            }),

        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgAddDeepPurpleA200,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v))
        ]);
  }

  Widget _buildMessagesList() {
    return Expanded(
      child: Obx(() => ListView.separated(
        //  physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0.v),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Divider(
                        height: 1.v,
                        thickness: 1.v,
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
          })),
    );
  }

  onTapArrowBack() {
    Get.rootDelegate.popRoute();
  }
  onChannelSelection(String selectedChannelId)
  {
    controller.setSelectedChannel(selectedChannelId);
  }


}