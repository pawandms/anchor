
import 'package:anchor_getx/core/utils/Helper.dart';
import 'package:anchor_getx/presentation/chat_screen/widgets/MessageBox.dart';
import 'package:flutter/material.dart';
import 'package:simple_grouped_listview/simple_grouped_listview.dart';

import '../../../data/models/channel/ChnlParticipents.dart';
import '../../../data/models/message/ApiMessage.dart';

class ListPage extends StatelessWidget{

  String myId;
  List<ApiMessage> msgs;
  Map<String,ChnlParticipent>userMap;
  ScrollController controller;
  BuildContext context;
  ListPage(
      this.myId, this.msgs, this.userMap, this.controller, this.context,{
        Key? key,
      }) : super(
    key: key,
  );

  @override
  Widget build(context) {

    return Scaffold(
      body: GroupedListView.list(
    controller: controller,
        items: msgs,
        itemGrouper: (ApiMessage i) => DateTime(
          i.createdOn.year,
          i.createdOn.month,
          i.createdOn.day,
        ), headerBuilder: (BuildContext context, DateTime header) =>
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0
                ),
                child: Text(
                  Helper.getText(header),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ), listItemBuilder: (context, int itemCountInGroup, int itemIndexInGroup, ApiMessage item, int itemIndexInOriginalList) =>

          Container(
            child:
            MessageBox( context: context,myId: myId, msg: item, userMap: userMap),
            padding: const EdgeInsets.all(8),
          ),


      ),
    );
  }
}