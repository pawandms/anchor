
import 'package:anchor_getx/data/models/message/ApiMessage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/channel/ChnlParticipents.dart';

class MessageBox extends StatelessWidget {
  final BuildContext context;
  final ApiMessage msg;
  final String myId;
  final Map<String,ChnlParticipent>userMap;


  const MessageBox({
    super.key,
    required this.context,
    required this.myId,
    required this.msg,
    required this.userMap
  });


  @override
  Widget build(context) {
    const BoxDecoration chatBackgroundDecoration = BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFFe3edff),
              Color(0xFFcad8fd)
            ]
        )
    );

    bool
    displayUserName = true,
        displayAvatar = true;

    if (msg.createdBy == myId){
      displayUserName = false;
    } else
      {
        displayUserName = true;
      }

    displayAvatar = displayUserName;
    //displayUserName = false;

    return Row(
      mainAxisAlignment: msg.createdBy == myId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (displayAvatar)
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blueAccent,
              child: const Icon(
                  Icons.person,
                  color: Colors.white
              ),
            ),
          ),
        if (!displayAvatar)
          const SizedBox(width: 40),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: msg.createdBy == myId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (displayUserName)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text( getUserName(msg.createdBy!),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.blueAccent,
                  ),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.76,
              child: Align(
                alignment: msg.createdBy == myId
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: msg.createdBy == myId ? Colors.green : Colors.white,
                  borderOnForeground: true,
                  elevation: 10.0,
                  surfaceTintColor: Colors.red,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        topLeft: Radius.circular(
                            msg.createdBy == myId ? 18.0 : 0
                        ),
                        bottomRight: Radius.circular(
                            msg.createdBy == myId ? 0 : 18.0
                        ),
                      )
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
                        child: Text(msg.body,
                        style: TextStyle(color: msg.createdBy == myId ? Colors.white : Colors.black),
                        ),
                      ),
                      Positioned(
                          bottom: 4,
                          right: 8,
                          child: Text(
                            DateFormat.Hm().format(msg.createdOn),
                            style: TextStyle(color: msg.createdBy == myId ? Colors.white : Colors.black),
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getUserName(String userID)
  {
    String result = userID;
    if(userMap.containsKey(userID))
     {
       ChnlParticipent cp = userMap[userID]!;
       result =  cp.firstName+" "+cp.lastName;
     }

    return result;
  }
}