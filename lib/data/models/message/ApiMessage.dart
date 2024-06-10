
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../core/utils/Helper.dart';
import '../../enums/AttachmentType.dart';
import '../../enums/MsgActionType.dart';
import '../../enums/MsgEventType.dart';
import '../../enums/MsgType.dart';
import 'Attachment.dart';

class ApiMessage{

  late String id;
  late MsgType type;
  late String body;
  late AttachmentType attachmentType;
  late List<Attachment> attachments;
  late String? createdBy;
  late DateTime createdOn;
  late String? modifiedBy;
  late DateTime? modifiedOn;

  // Optional Paramaters
  late String? chnlID;
  late String? userID;
  late MsgActionType actionType = MsgActionType.None;
  late Rx<MsgEventType> msgEvent = MsgEventType.None.obs;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type.name,
      'body': this.body,
      'attachments': this.attachments,
      'createdBy': this.createdBy,
     // 'createdOn': this.createdOn,
      'modifiedBy': this.modifiedBy,
     // 'modifiedOn': this.modifiedOn,
      'chnlID' : this.chnlID,
      'userID' : this.userID,
      'actionType' : this.actionType == null ? MsgActionType.None.name : this.actionType?.name,
    };
  }

  factory ApiMessage.fromMap(Map<String, dynamic> map) {
    return ApiMessage(
      id: map['id'] as String,
      type: MsgTypeExtension.getType(map['type']),
      body: map['body'] as String,

      attachments: List.of(map["attachments"])
          .map((i) => Attachment.fromMap(i))
          .toList(),


      createdBy: map['createdBy'] == null? null : map['createdBy'] as String,
     // createdOn: map['createdOn'] == null ? DateTime.now() : DateTime.parse(map['createdOn']),
      createdOn: map['createdOn'] == null ? DateTime.now() : Helper.getLocalDateFromUtcDateString(map['createdOn']),
      modifiedBy: map['modifiedBy'] == null ? null : map['modifiedBy'] as String,
      modifiedOn: map['modifiedOn'] == null ? null : DateTime.parse(map['modifiedOn']),
    );
  }

  ApiMessage({
    required this.id,
    required this.type,
    required this.body,
    List<Attachment>? attachments ,
    this.createdBy,
    required this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
  }) : attachments = attachments ?? [],
  attachmentType = AttachmentType.Network
  ;
}