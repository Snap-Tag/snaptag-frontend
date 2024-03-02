
import 'dart:ffi';

class RecentModel {
  final String recentImage;
  final int imageID;
  RecentModel({required this.imageID, required this.recentImage});

  factory RecentModel.fromJson(Map<Int, dynamic> json) {
    return RecentModel(
        imageID: (json['image_id']),
        recentImage: json['saved_images']);
  }
}