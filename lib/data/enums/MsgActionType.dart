
enum MsgActionType {
  Add,
  Reply,
  Forward,
  Delete,
  DeleteForAll,
  View,
  Like,
  DisLike,
  Heart,
  None,


}

extension MsgActionTypeExtension on MsgActionType {

  static MsgActionType getType(String type) {
    switch (type) {
      case "Add":
        return MsgActionType.Add;
      case "Reply":
        return MsgActionType.Reply;
      case "Forward":
        return MsgActionType.Forward;
      case "Delete":
        return MsgActionType.Delete;
      case "DeleteForAll":
        return MsgActionType.DeleteForAll;
      case "View":
        return MsgActionType.View;
      case "Like":
        return MsgActionType.Like;
      case "DisLike":
        return MsgActionType.DisLike;
      case "Heart":
        return MsgActionType.Heart;
      default:
        return MsgActionType.None;
    }
  }
}