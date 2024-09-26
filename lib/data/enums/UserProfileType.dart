enum UserProfileType {
  Public,
  Private,
  Protected,
  NA
}

extension UserProfileTypeExtension on UserProfileType {
  String? get value {
    switch (this) {
      case UserProfileType.Public:
        return "Public";
      case UserProfileType.Private:
        return "Private";
      case UserProfileType.Protected:
        return "Protected";
      default:
        return "NA";
    }
  }

  static UserProfileType getType(String type) {
    switch (type) {
      case "Public":
        return UserProfileType.Public;
      case "Private":
        return UserProfileType.Private;
      case "Protected":
        return UserProfileType.Protected;
      default:
        return UserProfileType.NA;
    }
  }

}

