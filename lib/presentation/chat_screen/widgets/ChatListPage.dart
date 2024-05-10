
import 'package:anchor_getx/core/utils/Helper.dart';
import 'package:anchor_getx/presentation/chat_screen/widgets/MessageBox.dart';
import 'package:flutter/material.dart';
import 'package:simple_grouped_listview/simple_grouped_listview.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../data/models/channel/ChnlParticipents.dart';
import '../../../data/models/message/ApiMessage.dart';
import 'AttachmentBox.dart';

class ChatListPage extends StatelessWidget{

  String myId;
  List<ApiMessage> msgs;
  Map<String,ChnlParticipent>userMap;
  //ScrollController controller;
  GroupedItemScrollController itemScrollController;
  final itemPositionsListener = ItemPositionsListener.create();
  BuildContext context;
  ChatListPage(
      this.myId, this.msgs, this.userMap, this.itemScrollController, this.context,{
        Key? key,
      }) : super(
    key: key,
  );

  @override
  Widget build(context) {
    return Scaffold(
      body: StickyGroupedListView<ApiMessage, DateTime>(
        elements: msgs,
        groupBy: (ApiMessage i) => DateTime(
          i.createdOn.year,
          i.createdOn.month,
          i.createdOn.day,
        ),
        elementIdentifier: (ApiMessage element) => element.id,
        itemPositionsListener: itemPositionsListener,
        itemScrollController: itemScrollController,
        floatingHeader: true,
        groupSeparatorBuilder: _getGroupSeparator ,
        itemComparator: (e1, e2) => e1.createdOn.compareTo(e2.createdOn),
        itemBuilder: _getItem,

      ),
    );
  }

  Widget _getGroupSeparator(ApiMessage element) {
    return SizedBox(
      height: 40,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.blue[300],
            border: Border.all(
              color: Colors.blue[300]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              Helper.getText(element.createdOn),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem(BuildContext ctx, ApiMessage item) {


   return Container(
      child:
      MessageBox( context: context,myId: myId, msg: item, userMap: userMap),
      padding: const EdgeInsets.all(8),
    );


    /*
    return InkWell(
        onTap: () {},
        child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Container(
                child:
                Column(
                  children: [
                     // if(item.attachments.isNotEmpty)
                     // AttachmentBox(ctx: ctx, myId: myId, msg: item ),
                      MessageBox( context: ctx,myId: myId, msg: item, userMap: userMap),

                  ],
                )

            )

        )
    );

     */
  }

}