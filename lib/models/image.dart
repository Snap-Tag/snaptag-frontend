import 'dart:typed_data';

class Images {
  final String imageID;
  final Uint8List imageData;
  Images({
    required this.imageID,
    required this.imageData,
  });
  factory Images.fromSqfliteDatabase(Map<String, dynamic> map) => Images(
      imageID: map['image_id']?.toString() ?? 'null',
      imageData: map['image_data'] ?? 'null');
}
