import 'package:anchor_getx/data/enums/MsgType.dart';

class Attachment {
  late String id;
  late MsgType type;
  late String name;
  late String extension;
  late String bucketName;
  late String contentID;
  late num? sizeInBytes = 0 ;
  late String? createdBy;
  late DateTime? createdOn;
  late String? modifiedBy;
  late DateTime? modifiedOn;




  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type,
      'name': this.name,
      'extension': this.extension,
      'bucketName': this.bucketName,
      'contentID': this.contentID,
      'sizeInBytes': this.sizeInBytes,
      'createdBy': this.createdBy,
      'createdOn': this.createdOn,
      'modifiedBy': this.modifiedBy,
      'modifiedOn': this.modifiedOn,
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      id: map['id'] as String,
      type: MsgTypeExtension.getType(map['type']),
      name: map['name'] as String,
      extension: map['extension'] as String,
      bucketName: map['bucketName'] as String,
      contentID: map['contentID'] as String,
      sizeInBytes: map['sizeInBytes'] == null ? null : num.parse(map['sizeInBytes']),
      createdBy: map['createdBy'] as String,
      createdOn: map['createdOn'] == null ? null : DateTime.parse(map['createdOn']),
      modifiedBy: map['modifiedBy'] as String,
      modifiedOn: map['modifiedOn'] == null ? null : DateTime.parse(map['createdOn']),
    );
  }

  Attachment({
    required this.id,
    required this.type,
    required this.name,
    required this.extension,
    required this.bucketName,
    required this.contentID,
    required this.sizeInBytes,
    required this.createdBy,
    required this.createdOn,
    required this.modifiedBy,
    required this.modifiedOn,
  });
}