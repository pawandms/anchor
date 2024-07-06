
import 'package:anchor_getx/data/models/message/ApiMessage.dart';

import '../../../core/utils/Helper.dart';
import 'MsgAttribute.dart';

class ChannelMsg{
  late String id;
  late String userID;
  late String chnlID;
  late String msgID;
  late DateTime? createdOn;
  late ApiMessage message;
  late MsgAttribute? msgAttribute;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userID': this.userID,
      'chnlID': this.chnlID,
      'msgID': this.msgID,
      'createdOn': this.createdOn,
      'message': this.message,
      'msgAttribute' : this.msgAttribute,
    };
  }

  factory ChannelMsg.fromMap(Map<String, dynamic> map) {
    return ChannelMsg(
      id: map['id'] as String,
      userID: map['userID'] as String,
      chnlID: map['chnlID'] as String,
      msgID: map['msgID'] as String,
      createdOn: map['createdOn'] == null ? null : DateTime.parse(map['createdOn']),
      message: ApiMessage.fromMap(map['message']), 
      msgAttribute : map['msgAttribute'] == null ? null :  MsgAttribute.fromMap(map['msgAttribute']),
    );

  }

  ChannelMsg({
    required this.id,
    required this.userID,
    required this.chnlID,
    required this.msgID,
    required this.createdOn,
    required this.message, 
    this.msgAttribute,
  }) ;
}