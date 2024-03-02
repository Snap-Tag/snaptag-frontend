
import 'dart:ffi';

class favouriteModel {
  final String favImage;
  final Int imageID;
  favouriteModel({required this.imageID, required this.favImage});

  factory favouriteModel.fromJson(Map<Int, dynamic> json) {
    return favouriteModel(
        imageID: (json['image_id']),
        favImage: json['saved_images']);
  }
}
