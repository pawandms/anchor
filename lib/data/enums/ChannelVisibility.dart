enum ChannelVisibility {
  Public,
  Private,
}

extension ChannelVisibilityExtension on ChannelVisibility {
  String? get value {
    switch (this) {
      case ChannelVisibility.Public:
        return "Public";
      case ChannelVisibility.Private:
        return "Private";
      default:
        return null;
    }
  }

  static ChannelVisibility? getType(String type) {
    switch (type) {
      case "Public":
        return ChannelVisibility.Public;
      case "Private":
        return ChannelVisibility.Private;
      default:
        return null;
    }
  }


}

