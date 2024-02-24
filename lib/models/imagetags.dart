
class ImageTags {
  final String imageID;
  final String tagID;
  ImageTags({
    required this.imageID,
    required this.tagID,
  });
  factory ImageTags.fromSqfliteDatabase(Map<String, dynamic> map) => ImageTags(
      tagID: map['tagID']?.toString() ?? 'null',
      imageID: map['imageID']?.toString() ?? 'null');
}
