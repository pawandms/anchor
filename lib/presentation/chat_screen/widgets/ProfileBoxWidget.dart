import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

import '../../../data/models/media/MediaImage.dart';

class ProfileBoxWidget extends StatelessWidget {
  String profileImageUrl;
  ProfileBoxWidget(
       {super.key,
         required this.profileImageUrl}
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 400,
      //height: 300,
      padding: const EdgeInsets.all(10),
      child: _buildProfileBox()
    );
  }


  Widget _buildProfileBox()
  {
    return SizedBox(
      height: 260,
      width: 300,
      child: Card(
        color: Colors.white,
        borderOnForeground: true,
        elevation: 10.0,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            )
        ),
        //margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                children: [
                  Container(
                      child: CustomImageView(
                        imagePath: profileImageUrl,
                        height: 200,
                        width: 300,
                        fit: BoxFit.fill,

                      )
                  ),
                  Container(
                     color: Colors.grey,
                    padding: EdgeInsets.only(left: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Show text here',
                        style: TextStyle(color: Colors.white),
                      ))
                ],

              ),
            ),
            Divider(),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 CircleAvatar(
                   backgroundColor: Colors.blue,
                   radius: 20,
                   child: IconButton(
                     tooltip: 'Chat',
                     padding: EdgeInsets.zero,
                     icon: Icon(Icons.chat),
                     color: Colors.white,
                     onPressed: () {},
                   ),
                 ),
                 CircleAvatar(
                   backgroundColor: Colors.blue,
                   radius: 20,
                   child: IconButton(
                     padding: EdgeInsets.zero,
                     icon: Icon(Icons.info_outline),
                     color: Colors.white,
                     onPressed: () {},
                   ),
                 ),
                 CircleAvatar(
                   backgroundColor: Colors.blue,
                   radius: 20,
                   child: IconButton(
                     padding: EdgeInsets.zero,
                     icon: Icon(Icons.add),
                     color: Colors.white,
                     onPressed: () {},
                   ),
                 ),


               ],


              )
            )
          ],
        )

      ),
    );
  }

}