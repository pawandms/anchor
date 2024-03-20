
enum GenderType {
  Unknown,
  Male,
  Female,
  Other,

}

extension GenderTypeExtension on GenderType {

  static GenderType getType(String type) {
    switch (type) {
      case "Unknown":
        return GenderType.Unknown;
      case "Male":
        return GenderType.Male;
      case "Female":
        return GenderType.Female;
      case "Other":
        return GenderType.Other;
      default:
        return GenderType.Unknown;
    }
  }
}