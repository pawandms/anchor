import 'package:anchor_getx/data/enums/EntityType.dart';

import '../../../widgets/custom_image_view.dart';

class MediaImage{
   late String id;
   late int? width;
   late int? height;
   late EntityType entityType;
   late String entityId;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'width': this.width,
      'height': this.height,
      'entityType': this.entityType,
      'entityId': this.entityId,

    };
  }

  factory MediaImage.fromMap(Map<String, dynamic> map) {
    return MediaImage(
      id: map['id'],
      entityId: map['entityId'],
      entityType:  EntityTypeExtension.getType(map['entityType']),
      width: map['width'],
      height: map['height'],

    );

  }

   MediaImage({
    required this.id,
    this.width,
    this.height,
    required this.entityType,
    required this.entityId,

  });
}