
import 'dart:io';

import 'package:anchor_getx/core/app_export.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../data/models/media/MediaInput.dart';

class FlickPlayer extends StatefulWidget
{
  MediaInput input;
  bool autoPlay;
  bool isMute;
  String url = 'https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/iceland_compressed.mp4?raw=true';
  FlickPlayer(
      {
        super.key,
        required this.input,
        this.autoPlay = false,
        this.isMute = true,
      });

  @override
  State<FlickPlayer> createState() => _FlickPlayerState();
}

class _FlickPlayerState extends State<FlickPlayer>
{
  late FlickManager flickManager;
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();

    if( (null != widget.input.url) && (widget.input.url != 'NA'))
    {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.input.url) );
    }
    else if ( null != widget.input.file)
    {
      if(GetPlatform.isWeb)
      {

        _videoPlayerController = VideoPlayerController.asset(widget.input.file!.path);
        //_videoPlayerController = VideoPlayerController.file(File(widget.input.file!.path));
      }
      else {
        _videoPlayerController = VideoPlayerController.file(File(widget.input.file!.path));
      }
    }


    flickManager = FlickManager(
      autoPlay: widget.autoPlay,
      videoPlayerController: _videoPlayerController,
    );


    if(widget.isMute)
    {
      flickManager.flickControlManager?.mute();
    }
    else {
      flickManager.flickControlManager?.unmute();
     // flickManager.flickControlManager?.setVolume(2.0);
    }



  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();

        }
      },
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          closedCaptionTextStyle: TextStyle(fontSize: 8),
         controls: FlickPortraitControls(
           fontSize: 4,
           //iconSize: 5,

        ),


          videoFit: BoxFit.fill,


        ),

        /*
            flickVideoWithControls: FlickVideoWithControls(
              closedCaptionTextStyle: TextStyle(fontSize: 8),
              controls: FlickPortraitControls(),
            ),

            flickVideoWithControlsFullscreen: FlickVideoWithControls(
              controls: FlickLandscapeControls(),
              playerLoadingFallback: CircularProgressIndicator(),
              videoFit: BoxFit.contain,
            ),

             */
      ),
    );
  }
  
}