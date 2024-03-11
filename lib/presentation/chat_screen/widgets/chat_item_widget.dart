import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/service/AudioService.dart';
import 'package:flutter/material.dart';
import '../../../data/models/message/ApiMessage.dart';

// ignore: must_be_immutable
class ChatItemWidget extends StatelessWidget {

  String myId;
  ApiMessage msg;
  //MessageScreenController controller;
  //Function(String) onChnlSelection;

  ChatItemWidget(
    this.myId, this.msg, {
    Key? key,
  }) : super(
          key: key,
        );


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
        padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        //vertical: 26.v,
      ),
      child: Align(
      alignment: (msg.createdBy != myId  ?Alignment.topLeft:Alignment.topRight),
      child: Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: (msg.createdBy != myId  ?Colors.grey.shade200:Colors.blue[200]),
      ),
      padding: EdgeInsets.all(16),
      child: Text(msg.body, style: TextStyle( color: Colors.black),),
    )
    )
    );
  }

}
