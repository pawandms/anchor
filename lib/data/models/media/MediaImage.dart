import 'package:anchor_getx/data/enums/EntityType.dart';

import '../../../widgets/custom_image_view.dart';

class MediaImage{
   late String id;
   late int? width;
   late int? height;
   late EntityType entityType;
   late String entityId;
   late ImageType imageType;


   MediaImage(this.id, this.width, this.height, this.entityType, this.entityId,
      this.imageType);

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'width': this.width,
      'height': this.height,
      'entityType': this.entityType,
      'entityId': this.entityId,
      'imageType': this.imageType,
    };
  }

  factory MediaImage.fromMap(Map<String, dynamic> map) {
    final id =  map['id'];
    final width =  map['width'];
    final height =  map['height'];
    final entityType =   EntityType.values.byName(map['entityType']);
    final entityId =  map['entityId'];
    final imageType =  map['imageType'];
    return MediaImage(id, width, height, entityType, entityId, imageType);
  }
}