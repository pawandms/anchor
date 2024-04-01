
enum ContentSourceType {
  Document,
  Camera,
  Gallery,
  Audio,
  Location,
  Contact,
  None,

}

extension ContentSourceTypeExtension on ContentSourceType {

  static ContentSourceType getType(String type) {
    switch (type) {
      case "Document":
        return ContentSourceType.Document;
      case "Camera":
        return ContentSourceType.Camera;
      case "Gallery":
        return ContentSourceType.Gallery;
      case "Audio":
        return ContentSourceType.Audio;
      case "Location":
        return ContentSourceType.Location;
      case "Contact":
        return ContentSourceType.Contact;
      default:
        return ContentSourceType.None;
    }
  }
}