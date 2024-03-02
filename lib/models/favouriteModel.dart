class FavouriteModel {
  final String favImage;
  final int imageID;

  FavouriteModel({required this.imageID, required this.favImage});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
        imageID: json['image_id'], favImage: json['saved_images']);
  }

  static List<FavouriteModel> fromJsonList(
      List<Map<String, dynamic>> jsonList) {
    return jsonList.map((item) => FavouriteModel.fromJson(item)).toList();
  }
}
