class ImageModel {
  final String imageData;
  final int imageID;

  ImageModel({required this.imageID, required this.imageData});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imageID: json['image_id'], imageData: json['image_data']);
  }

  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ImageModel.fromJson(item)).toList();
  }
}
