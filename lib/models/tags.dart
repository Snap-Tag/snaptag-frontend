class Image {
  final String imageID;
  final String imagePath;
  Image({
    required this.imageID,
    required this.imagePath,
  });
}

class Tags {
  final String tagID;
  final String tag;
  Tags({
    required this.tagID,
    required this.tag,
  });
}

class ImageTags {
  final String imageID;
  final String tagID;
  ImageTags({
    required this.imageID,
    required this.tagID,
  });
}
