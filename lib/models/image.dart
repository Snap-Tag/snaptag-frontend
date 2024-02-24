class Image {
  final String imageID;
  final String imagePath;
  Image({
    required this.imageID,
    required this.imagePath,
  });
  factory Image.fromSqfliteDatabase(Map<String,dynamic> map) => Image(
      imageID: map['imageID']?.toString() ?? 'null',
      imagePath: map['imagePath']?.toString() ?? 'null');
}

