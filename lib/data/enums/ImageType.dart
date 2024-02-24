// Assuming you have the enum and the functions in the same file, otherwise, import the necessary libraries.

enum ImageType {
  PersonImage,
  CompanyLogo,
  CollectionPoster,
  CollectionBackDrop,
  MediaPoster,
  MediaBackDrop,
  ChannelLogo,
  ChannelImage,
  Other
}

extension ChannelTypeExtension on ImageType {
  static final Map<String, ImageType> _map = {
    'PersonImage': ImageType.PersonImage,
    'CompanyLogo': ImageType.CompanyLogo,
    'CollectionPoster': ImageType.CollectionPoster,
    'CollectionBackDrop': ImageType.CollectionBackDrop,
    'MediaPoster': ImageType.MediaPoster,
    'MediaBackDrop': ImageType.MediaBackDrop,
    'ChannelLogo': ImageType.ChannelLogo,
    'ChannelImage': ImageType.ChannelImage,
    'Other': ImageType.Other,
  };

  String? get value {
    switch (this) {
      case ImageType.PersonImage:
        return 'PersonImage';
      case ImageType.CompanyLogo:
        return 'CompanyLogo';
      case ImageType.CollectionPoster:
        return 'CollectionPoster';
      case ImageType.CollectionBackDrop:
        return 'CollectionBackDrop';
      case ImageType.MediaPoster:
        return 'MediaPoster';
      case ImageType.MediaBackDrop:
        return 'MediaBackDrop';
      case ImageType.ChannelLogo:
        return 'ChannelLogo';
      case ImageType.ChannelImage:
        return 'ChannelImage';
      case ImageType.Other:
        return 'Other';
      default:
        return null;
    }
  }

  static ImageType? getType(String type) {
    return _map[type];
  }
}

