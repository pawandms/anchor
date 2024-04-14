
enum AttachmentType {
  Local,
  Network,
  None,

}

extension AttachmentTypeTypeExtension on AttachmentType {

  static AttachmentType getType(String type) {
    switch (type) {
      case "Local":
        return AttachmentType.Local;
      case "Network":
        return AttachmentType.Local;
      default:
        return AttachmentType.None;
    }
  }
}