
import 'package:anchor_getx/core/utils/Helper.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../data/models/channel/UserChannel.dart';
import '../../../theme/custom_text_style.dart';
import '../controller/messageScreenController.dart';

class ConversationList extends StatelessWidget
{
  UserChannel userChannel;
  MessageScreenController controller;
   Function(String) onChnlSelection;
   final BuildContext context;

  ConversationList(
      this.userChannel, this.onChnlSelection, this.context,this.controller,
  {
        Key? key,
      }) : super(
    key: key,
  );

  @override
  Widget build(context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Obx(() => Row(
        children: [
          Expanded(
              child: Row(
                children: [
                  AdvancedAvatar(
                    image: AssetImage('images/User3.jpg'),
                    size: 60,

                    //statusColor: Colors.green,
                  ),

                  SizedBox(width: 16,),
                  Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userChannel.name, style: CustomTextStyles.titleMediumBlack90001,),
                            const SizedBox(height: 6,),
                            Text(userChannel.msg!.value.body,
                              style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: false ?FontWeight.bold:FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                  )
                ],
              )
          ),
          badges.Badge(
              badgeStyle: BadgeStyle
            (badgeColor: Colors.blueAccent,),
            badgeContent: Text(userChannel.unreadCount.value.toString(),
            //style: theme.textTheme.titleMedium,
               ),
            ignorePointer: false,
            position:  badges.BadgePosition.topEnd(top: -30, end: -5),
            child: Text(
              Helper.getText(userChannel.msgDate!),
              //style: theme.dataTableTheme.dataTextStyle,
            ),
          )

        ],
      )),
    );

  }

}


  

