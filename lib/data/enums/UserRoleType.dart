enum UserRoleType {
  SuperAdmin,
  Admin,
  Moderator,
  Author,
  Viewer,
  None,
}

extension UserRoleTypeExtension on UserRoleType {
  String? get value {
    switch (this) {
      case UserRoleType.SuperAdmin:
        return "SuperAdmin";
      case UserRoleType.Admin:
        return "Admin";
      case UserRoleType.Moderator:
        return "Moderator";
      case UserRoleType.Author:
        return "Author";
      case UserRoleType.Viewer:
        return "Viewer";
      default:
        return null;
    }
  }

  static UserRoleType getType(String type) {
    switch (type) {
      case "SuperAdmin":
        return UserRoleType.SuperAdmin;
      case "Admin":
        return UserRoleType.Admin;
      case "Moderator":
        return UserRoleType.Moderator;
      case "Author":
        return UserRoleType.Author;
      case "Viewer":
        return UserRoleType.Viewer;
      default:
        return UserRoleType.None;
    }
  }
}

