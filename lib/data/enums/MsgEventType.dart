
enum MsgEventType {
  Like,
  DisLike,
  Heart,
  Sending,
  Sent,
  Error,
  None,


}

extension MsgEventTypeExtension on MsgEventType {

  static MsgEventType getType(String type) {
    switch (type) {
      case "Like":
        return MsgEventType.Like;
      case "DisLike":
        return MsgEventType.DisLike;
      case "Heart":
        return MsgEventType.Heart;
      case "Sending":
        return MsgEventType.Sending;
      case "Sent":
        return MsgEventType.Sent;
      default:
        return MsgEventType.None;
    }
  }
}