// Assuming you have the enum and the functions in the same file, otherwise, import the necessary libraries.

enum EntityType {
  Media,
  Movie,
  Person,
  Tv_Show,
  MusicVideo,
  Collection,
  Company,
  Channel,
  UserProfile,
  Unknown,
}

extension EntityTypeExtension on EntityType {

  static EntityType getType(String type) {
    switch (type) {
      case "Media":
        return EntityType.Media;
      case "Movie":
        return EntityType.Movie;
      case "Person":
        return EntityType.Person;
      case "Tv_Show":
        return EntityType.Tv_Show;
      case "MusicVideo":
        return EntityType.MusicVideo;
      case "Collection":
        return EntityType.Collection;
      case "Company":
        return EntityType.Company;
      case "Channel":
        return EntityType.Channel;
      case "UserProfile":
        return EntityType.UserProfile;
      default:
        return EntityType.Unknown;
    }
  }


}

