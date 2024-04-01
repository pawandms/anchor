
import 'package:image_picker/image_picker.dart';

import '../../enums/MediaInputType.dart';

class MediaInput{
  late int key;
  MediaInputType type;
  late XFile? file;

  MediaInput({
    required this.key,
    required this.type,
    this.file,

  });

}