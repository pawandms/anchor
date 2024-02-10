
import 'package:anchor_getx/presentation/message_screen/controller/message_controller.dart';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/messages_page/messages_page.dart';
import 'package:flutter/material.dart';

import 'Calls_Fragment.dart';
import 'Chat_Fragment.dart';
import 'Status_Fragment.dart';

// ignore_for_file: must_be_immutable
class MessageScreen extends GetWidget<MessageController> {
  MessageScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new MessagesPage();
  }
  /*
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF075E54),
          title: Text("Whatsapp"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert_outlined,
                    size: 26.0,
                  ),
                )
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF6BA9AA),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Chat_Screen(),
            Status_Screen(),
            Calls_Screen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFF075E54),
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
*/

}
