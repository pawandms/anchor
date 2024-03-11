
import 'package:anchor_getx/data/models/message/ApiMessage.dart';

class ChannelMsg{
  late String id;
  late String userID;
  late String chnlID;
  late String msgID;
  late DateTime createdOn;
  late ApiMessage message;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userID': this.userID,
      'chnlID': this.chnlID,
      'msgID': this.msgID,
      'createdOn': this.createdOn,
      'message': this.message,
    };
  }

  factory ChannelMsg.fromMap(Map<String, dynamic> map) {
    return ChannelMsg(
      id: map['id'] as String,
      userID: map['userID'] as String,
      chnlID: map['chnlID'] as String,
      msgID: map['msgID'] as String,
      createdOn: DateTime.parse(map['createdOn']),
      message: ApiMessage.fromMap(map['message']),
    );
  }

  ChannelMsg({
    required this.id,
    required this.userID,
    required this.chnlID,
    required this.msgID,
    required this.createdOn,
    required this.message,
  });
}