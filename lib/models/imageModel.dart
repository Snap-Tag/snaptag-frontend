class ImageModel {
  final String imageData;
  final int imageID;
  final bool favorite;

  ImageModel(
      {required this.imageID, required this.imageData, required this.favorite});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        imageID: json['image_id'],
        imageData: json['image_data'],
        favorite: (json['favorite'] == 1) ? true : false);
  }

  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ImageModel.fromJson(item)).toList();
  }
}
