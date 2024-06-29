
import 'package:anchor_getx/core/utils/Helper.dart';
import 'package:anchor_getx/presentation/chat_screen/widgets/MessageBox.dart';
import 'package:flutter/material.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../data/models/channel/ChnlParticipents.dart';
import '../../../data/models/message/ApiMessage.dart';

class ChatListPage extends StatelessWidget{

  String myId;
  late int initalScrollIndex;
  List<ApiMessage> msgs;
  Map<String,ChnlParticipent>userMap;
  //ScrollController controller;
  GroupedItemScrollController itemScrollController;
  Function(VisibilityInfo) chatItemVisibilityChangeListener;
 // final itemPositionsListener = ItemPositionsListener.create();
 // ItemPositionsListener itemPositionsListener;
  BuildContext context;
  ChatListPage(
      this.myId, this.msgs, this.userMap, this.itemScrollController, this.chatItemVisibilityChangeListener, this.context,this.initalScrollIndex,{
        Key? key,
      }) : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    print("Building chatList Page ..");
    return Scaffold(
      body: StickyGroupedListView<ApiMessage, DateTime>(
        elements: msgs,
        groupBy: (ApiMessage i) => DateTime(
          i.createdOn.year,
          i.createdOn.month,
          i.createdOn.day,
        ),
        elementIdentifier: (ApiMessage element) => element.id,
        initialScrollIndex: initalScrollIndex,
        itemScrollController: itemScrollController,
        floatingHeader: true,
        groupSeparatorBuilder: _getGroupSeparator ,
        itemComparator: (e1, e2) => e1.createdOn.compareTo(e2.createdOn),
        indexedItemBuilder: _getIndexItem,
        //itemBuilder: _getItem,

      ),
    );
  }

  Widget _getGroupSeparator(ApiMessage element) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
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
      ),
    );
  }

  Widget _getItem(BuildContext ctx, ApiMessage item) {
  return Container(
      child:
      MessageBox( context: context,myId: myId, msg: item, userMap: userMap),
      padding: const EdgeInsets.all(8),
    );
  }

  Widget _getIndexItem(BuildContext context, ApiMessage item, int index)
  {
    print('Building Chat Msg with Idx:${index} , MsgID:${item.id} ');
    return VisibilityDetector(
      key: ValueKey(index),
      onVisibilityChanged: chatItemVisibilityChangeListener,
      child: Container(
        key: ValueKey(index),
        child:
        MessageBox( context: context,myId: myId, msg: item, userMap: userMap),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}