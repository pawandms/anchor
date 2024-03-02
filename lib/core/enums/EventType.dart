
enum EventType {
  Chnl_Add_User,
  Chnl_Remove_User,
  Chnl_Add_Msg,
  Chnl_Remove_msg,
  None,

}

extension EventTypeExtension on EventType {

  static EventType getType(String type) {
    switch (type) {
      case "Chnl_Add_User":
        return EventType.Chnl_Add_User;
      case "Chnl_Remove_User":
        return EventType.Chnl_Remove_User;
      case "Chnl_Remove_User":
        return EventType.Chnl_Remove_User;
      case "Chnl_Add_Msg":
        return EventType.Chnl_Add_Msg;
      case "Chnl_Remove_msg":
        return EventType.Chnl_Remove_msg;

      default:
        return EventType.None;
    }
  }
}