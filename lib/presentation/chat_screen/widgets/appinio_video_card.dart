
import 'dart:io';

import 'package:anchor_getx/data/models/media/MediaInput.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';

class appinioVideoCard extends StatelessWidget {

  BuildContext _context;
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  MediaInput input;
  Rx<bool> _isvideoControllerLoaed = false.obs;

  appinioVideoCard(this.input, this._context)
  {
    initState();
  }

  void initState() async {
    videoPlayerController = await VideoPlayerController.networkUrl(Uri.parse(input.file!.path))
    //videoPlayerController = await VideoPlayerController.file(File(input.file.path!))
      ..initialize().then((value) => initApinoController());
  }

  void initApinoController()
  {
    //videoPlayerController.play();
    _customVideoPlayerController = CustomVideoPlayerController(
      context: _context,
      videoPlayerController: videoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        placeholderWidget: CircularProgressIndicator(),
        settingsButtonAvailable: false,
      )


    );

    _isvideoControllerLoaed.value = true;
  }


  @override
  void dispose() {
    _customVideoPlayerController.dispose();

  }

  @override
  Widget build(context) {
     return
     Obx(() {
       if(_isvideoControllerLoaed.isTrue)
       {
         //return Placeholder();

         return Container(
           padding: EdgeInsets.all(20),
           child: CustomVideoPlayer(
             key: ValueKey(input.key),
               customVideoPlayerController: _customVideoPlayerController,

           ),
         );

       }
       else {
         return const Center(
           child: CircularProgressIndicator(),
         );
       }
     }

     );


  }


}



