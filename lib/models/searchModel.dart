import 'dart:ffi';

class searchModel {
  final String searchImage;
  final int imageID;
  searchModel({required this.imageID, required this.searchImage});

  factory searchModel.fromJson(Map<Int, dynamic> json) {
    return searchModel(
        imageID: json['image_id'], searchImage: 'searched_images');
  }
}
