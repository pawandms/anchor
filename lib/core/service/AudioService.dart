import 'package:audioplayers/audioplayers.dart';

import '../constants/AppConfig.dart';

class AudioService {

  static final AssetSource sound = AssetSource('sound/wet.mp3');
  AudioService._();

  static final AudioService _instance = AudioService._();

  factory AudioService() {
    return _instance;
  }

  void playNotificationSound()
  {
   // AudioPlayer().setSource(sound);
    if(AppConfig.instance.enableMsgSound)
    {
      AudioPlayer().play(sound, mode: PlayerMode.lowLatency); // faster play low latency eg for a game...
    }


  }
  void playSound(AssetSource assetSource) async{
    AudioPlayer().play(assetSource, mode: PlayerMode.lowLatency); // faster play low latency eg for a game...
  }
}