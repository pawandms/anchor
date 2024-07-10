enum MsgReactionType {
  Like,
  DisLike,
  Love,
  Smile,
  Laugh,
  Wink,
  Angry,
  Sad,
  Surprised,
  Unknown,
}

extension MsgReactionTypeExtension on MsgReactionType {

  static MsgReactionType getType(String type) {
    switch (type) {
      case "Like":
        return MsgReactionType.Like;
      case "DisLike":
        return MsgReactionType.DisLike;
      case "Love":
        return MsgReactionType.Love;
      case "Smile":
        return MsgReactionType.Smile;
      case "Laugh":
        return MsgReactionType.Laugh;
      case "Wink":
        return MsgReactionType.Wink;
      case "Angry":
        return MsgReactionType.Angry;
      case "Sad":
        return MsgReactionType.Sad;
      case "Surprised":
        return MsgReactionType.Surprised;
      default:
        return MsgReactionType.Unknown;
    }
  }




}

