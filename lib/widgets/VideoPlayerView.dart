import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:video_player/video_player.dart';

import '../data/models/media/MediaInput.dart';

class VideoPlayerView extends StatefulWidget {

  bool zoomAndPan;
  bool showOptions;
  bool showControls;
  bool allowFullScreen;
  bool allowedScreenSleep;
  MediaInput input;
  BuildContext context;
 // String keyId;
  VideoPlayerView({
    super.key,
    required this.input,
    required this.context,
    zoomAndPan,
    showOptions,
    showControls,
    allowFullScreen,
    allowedScreenSleep,
       // required this.dataSourceType,
  }):   zoomAndPan = zoomAndPan ?? false,
        showOptions = showOptions ?? false,
        showControls = showControls?? true,
        allowFullScreen = allowFullScreen?? true,
        allowedScreenSleep = allowedScreenSleep ?? true
  ;


  //final DataSourceType dataSourceType;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;
  //bool showOptions;
  //bool
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initChewiePlayer();
  }

  Future<void> initChewiePlayer()
  async {
    if( (null != widget.input.url) && (widget.input.url != 'NA'))
    {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.input.url));
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
   // _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      zoomAndPan: widget.zoomAndPan,
      showOptions: widget.showOptions,
      controlsSafeAreaMinimum: EdgeInsets.all(10),
      showControls: widget.showControls,
      allowFullScreen: widget.allowFullScreen,
      allowedScreenSleep: widget.allowedScreenSleep,


    );
    setState(() {});

    print("Video Player Initilization Completed.....");
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
    print("Disposing Video Player for Contnt ID:"+widget.key.toString());
  }

  @override
  Widget build(context) {
     WidgetsFlutterBinding.ensureInitialized();
    /*
    return  AspectRatio(
      aspectRatio: 16 / 9,
      child: _chewieController != null ?    Chewie(controller: _chewieController!)
          :  CircularProgressIndicator(),
      );
    */

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Expanded(
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _chewieController != null ?    Chewie(controller: _chewieController!)
                    :  const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
            ),
          ),

          /*
           Expanded(
               child: Center(
                 child: _chewieController != null ?
                 Chewie(controller: _chewieController!)
          : const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      CircularProgressIndicator(),
      SizedBox(height: 20),
      Text('Loading'),
      ],
      ),
      ),
               )
        */

        ],
      ),
    )  ;

  }

  void onBtnPressed()
  {
    _chewieController!.isPlaying ? _chewieController!.pause() : _chewieController!.play();
  }

}