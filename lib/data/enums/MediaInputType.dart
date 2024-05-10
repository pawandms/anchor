
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
    switch (type) {
      case "Video":
        result = MediaInputType.Video;
        break;
      case "Audio":
        result = MediaInputType.Audio;
        break;
      case "Image":
        result = MediaInputType.Image;
        break;
      case "Document":
        result = MediaInputType.Document;
        break;

      default:
        result = MediaInputType.Unknown;
    }

    if(result == MediaInputType.Unknown)
     {
       if(type.startsWith('video', 0))
       {
         result = MediaInputType.Video;
       }
       else if(type.startsWith('image', 0))
       {
         result = MediaInputType.Image;
       }
     }

    return result;
  }
}