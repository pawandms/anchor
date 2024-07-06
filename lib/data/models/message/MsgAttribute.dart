
import 'package:anchor_getx/core/app_export.dart';

class MsgAttribute{

  late int recipientCount = 0;
  late int readUserCount = 0;
  late RxMap<String,String> userReaction;

  MsgAttribute(
      {
        required this.recipientCount,
        required this.readUserCount,
        required this.userReaction,
      });

  Map<String, dynamic> toMap() {
    return {
      'recipientCount': this.recipientCount,
      'readUserCount': this.readUserCount,
      'userReaction': this.userReaction,
    };
  }

  factory MsgAttribute.fromMap(Map<String, dynamic> map) {
    return MsgAttribute(
      recipientCount: map['recipientCount'] as int,
      readUserCount: map['readUserCount'] as int,
      userReaction: RxMap<String,String>(Map.from(map['userReaction'])) ,
    );

  }

  @override
  String toString() {
    return 'MsgAttribute{recipientCount: $recipientCount, readUserCount: $readUserCount, userReaction: $userReaction}';
  }


}