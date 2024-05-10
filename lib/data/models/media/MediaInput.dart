
import 'package:image_picker/image_picker.dart';

import '../../enums/MediaInputType.dart';

class MediaInput{
  late int key;
  MediaInputType type;
  late XFile? file;
  late String url;

  MediaInput({
    key,
    required this.type,
    this.file,
    url,
  }) : url = url ?? 'NA',
      key = key ?? 0 ;

}