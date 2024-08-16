import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

import '../../../data/models/media/MediaImage.dart';

class ProfileWidget extends StatelessWidget {
  final double circleRadius = 200.0;
  final double circleBorderWidth = 5.0;
  String profileImageUrl;
   ProfileWidget(
       {super.key,
         required this.profileImageUrl}
       );



  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtils.width*0.50,
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: circleRadius / 2.0),
            child: Container(
              //replace this Container with your Card
              // color: Colors.white,
              height: 300.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1, right: 1, left: 1, bottom: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Card(
                         child: Column(
                           children: [

                           ],
                         ),
                        ),
                      ),
                      Divider(),
                      Expanded(
                        flex: 1,
                        child: Card(
                          color: Colors.green,
                          child: SizedBox.expand(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: circleRadius,
            height: circleRadius,
            //decoration:
            //ShapeDecoration(shape: CircleBorder(), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(circleBorderWidth),
              child:
              AdvancedAvatar(
                size: 100,
                statusColor: Colors.green,
                statusAlignment: Alignment.topRight,
                image: NetworkImage(
                  profileImageUrl,
                ),
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.75),
                    //width: 5.0,
                  ),
                ),



                //statusColor: Colors.green,
              )

                  /*
              DecoratedBox(
                decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          profileImageUrl,
                        ))),
              ),
              */
            ),
          )
        ],
      ),
    );
  }


}