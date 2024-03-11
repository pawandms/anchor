import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/service/AudioService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/channel/UserChannel.dart';
import 'package:badges/badges.dart' as badges;

import '../controller/messageScreenController.dart';
// ignore: must_be_immutable
class ChannelItemWidget extends StatelessWidget {

  UserChannel userChannel;
  //MessageScreenController controller;
  Function(String) onChnlSelection;

  ChannelItemWidget(
    this.userChannel, this.onChnlSelection, {
    Key? key,
  }) : super(
          key: key,
        );


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 10.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 54.v,
            //  width: 52.h,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse22,
                  height: 54.v,
                  width: 52.h,
                  radius: BorderRadius.circular(
                    27.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 13.adaptSize,
                    width: 13.adaptSize,
                    decoration: BoxDecoration(
                      color: appTheme.green600,
                      borderRadius: BorderRadius.circular(
                        6.h,
                      ),
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              top: 2.v,
              bottom: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    userChannel.name,
                    style: CustomTextStyles.titleMediumBlack90001,
                  ),

                SizedBox(height: 8.v),
                Text(
                    userChannel.msg!.value.body,
                    style: theme.textTheme.bodyLarge,
                  ),

              ],
            ),
          ),
          Spacer(),

          Padding(
            padding: EdgeInsets.only(
              top: 3.v,
              bottom: 30.v,
            ),
            child:
             badges.Badge(
               onTap: (){
                  // onUnreadCountSelection(userChannel.chnlId);
                 onChnlSelection(userChannel.chnlId);

               },
               badgeContent: Obx(() => Text(userChannel.unreadCount.value.toString())),
               ignorePointer: false,
               position:  badges.BadgePosition.topEnd(top: -30, end: -5),


               child: Text(
                 DateFormat('yyyy-MM-dd HH:mm:ss').format(userChannel.msgDate!),
                 style: theme.textTheme.bodyLarge,
               ),
             )



          ),
        ],
      )
    );
  }

  /*
  void onUnreadCountSelection(String channelID)
  {
    controller.messageService.incrementUnreadCount(channelID);
    AudioService().playNotificationSound();
   // print("Unread Count Selected for Channel:"+channelID+" , Current Count:$currentUnreadCount");
  }

   */
}
