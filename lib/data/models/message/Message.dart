
import '../../enums/MsgType.dart';
import 'Attachment.dart';

class Message{

  late String id;
  late MsgType type;
  late String body;
  late List<Attachment>? attachments;
  late String? createdBy;
  late DateTime? createdOn;
  late String? modifiedBy;
  late DateTime? modifiedOn;



  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type,
      'body': this.body,
      'attachments': this.attachments,
      'createdBy': this.createdBy,
      'createdOn': this.createdOn,
      'modifiedBy': this.modifiedBy,
      'modifiedOn': this.modifiedOn,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      type: MsgTypeExtension.getType(map['type']),
      body: map['body'] as String,
      attachments: List.of(map["attachments"])
          .map((i) => Attachment.fromMap(i))
          .toList(),
      createdBy: map['createdBy'] == null? null : map['createdBy'] as String,
      createdOn: map['createdOn'] == null ? null : DateTime.parse(map['createdOn']),
      modifiedBy: map['modifiedBy'] == null ? null : map['modifiedBy'] as String,
      modifiedOn: map['modifiedOn'] == null ? null : DateTime.parse(map['modifiedOn']),
    );
  }

  Message({
    required this.id,
    required this.type,
    required this.body,
    this.attachments,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
  });
}