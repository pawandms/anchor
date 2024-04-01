
enum MediaInputType {
  Unknown,
  Video,
  Audio,
  Image,
  Document,

}

extension MediaInputTypeExtension on MediaInputType {

  static MediaInputType getType(String type) {
    MediaInputType result = MediaInputType.Unknown;
    try{
      if(type.isNotEmpty && type.startsWith('image'))
       {
         result = MediaInputType.Image;
       }
      else if (type.isNotEmpty && type.startsWith('video'))
       {
        result = MediaInputType.Video;
       }
    }
    catch(e)
    {

    }

    return result;
  }
}