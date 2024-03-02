
enum EventEntityType {
  Channel,
  User,
  Message,
  None,

}

extension EventEntityTypeExtension on EventEntityType {

  static EventEntityType getType(String type) {
    switch (type) {
      case "Channel":
        return EventEntityType.Channel;
      case "User":
        return EventEntityType.User;
      case "Message":
        return EventEntityType.Message;
      default:
        return EventEntityType.None;
    }
  }
}