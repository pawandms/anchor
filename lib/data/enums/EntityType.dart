// Assuming you have the enum and the functions in the same file, otherwise, import the necessary libraries.

enum EntityType {
  Media,
  Movie,
  Person,
  Tv_Show,
  MusicVideo,
  Collection,
  Company,
}

extension ChannelTypeExtension on EntityType {
  static final Map<String, EntityType> _map = {
    'Media': EntityType.Media,
    'Movie': EntityType.Movie,
    'Person': EntityType.Person,
    'Tv_Show': EntityType.Tv_Show,
    'MusicVideo': EntityType.MusicVideo,
    'Collection': EntityType.Collection,
    'Company': EntityType.Company,
  };

  String? get value {
    switch (this) {
      case EntityType.Media:
        return 'Media';
      case EntityType.Movie:
        return 'Movie';
      case EntityType.Person:
        return 'Person';
      case EntityType.Tv_Show:
        return 'Tv_Show';
      case EntityType.MusicVideo:
        return 'MusicVideo';
      case EntityType.Collection:
        return 'Collection';
      case EntityType.Company:
        return 'Company';
      default:
        return null;
    }
  }

  static EntityType? getType(String type) {
    return _map[type];
  }

  String toJson() => name;
  static EntityType? fromJson(String json) => getType(json);

}

