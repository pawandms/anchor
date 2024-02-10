import 'package:anchor_getx/presentation/message_screen/widgets/contact_list.dart';
import 'package:flutter/material.dart';

class Chat_Screen extends StatefulWidget {
  const Chat_Screen({Key? key}) : super(key: key);

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContactList(),
    );
  }
}
