
import 'package:anchor_getx/data/enums/ChannelType.dart';

import 'Channel.dart';
import 'UserChannel.dart';

class ChannelResp{
  late String userID;
  late ChannelType type;
  late List<UserChannel> channels;
 // List<Channel> channels;


  @override
  String toString() {
    return 'ChannelResp{userID: $userID, type: $type, channels: $channels}';
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': this.userID,
      'type': this.type,
      'channels': this.channels,
    };
  }

  factory ChannelResp.fromMap(Map<String, dynamic> map) {
    return ChannelResp(
      userID: map['userID'] as String,
      type: ChannelTypeExtension.getType(map['type']),

      channels: List.of(map["channels"])
          .map((i) => UserChannel.fromMap(i) /* can't generate it properly yet */)
          .toList()
    );
  }


  ChannelResp({
    required this.userID,
    required this.type,
    required this.channels,
  }); //
}