// Assuming you have the enum and the functions in the same file, otherwise, import the necessary libraries.

enum ChannelType {
  Messaging,
  Video,
  Audio,
  Blog,
  All,
  None,
}

extension ChannelTypeExtension on ChannelType {
  static final Map<String, ChannelType> _map = {
    'Messaging': ChannelType.Messaging,
    'Media': ChannelType.Video,
    'Audio': ChannelType.Audio,
    'Blog': ChannelType.Blog,
    'All': ChannelType.All,
  };

  static ChannelType getType(String type) {
    switch (type) {
      case "Messaging":
        return ChannelType.Messaging;
      case "Media":
        return ChannelType.Audio;
      case "Audio":
        return ChannelType.Audio;
      case "Blog":
        return ChannelType.Blog;
      case "All":
        return ChannelType.All;

      default:
        return ChannelType.None;
    }
  }
  String? get value {
    switch (this) {
      case ChannelType.Messaging:
        return 'Messaging';
      case ChannelType.Video:
        return 'Media';
      case ChannelType.Audio:
        return 'Audio';
      case ChannelType.Blog:
        return 'Blog';
      case ChannelType.All:
        return 'All';
      default:
        return null;
    }
  }

}

