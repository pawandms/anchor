
enum MsgType {
  Text,
  Html,
  Audio,
  Video,
  Image,
  Document,
  System,
  Notification,
  None,


}

extension MsgTypeExtension on MsgType {

  static MsgType getType(String type) {
    switch (type) {
      case "Text":
        return MsgType.Text;
      case "Html":
        return MsgType.Html;
      case "Audio":
        return MsgType.Audio;
      case "Video":
        return MsgType.Video;
      case "Image":
        return MsgType.Image;
      case "Document":
        return MsgType.Document;
      case "System":
        return MsgType.System;
      case "Notification":
        return MsgType.Notification;

      default:
        return MsgType.None;
    }
  }
}