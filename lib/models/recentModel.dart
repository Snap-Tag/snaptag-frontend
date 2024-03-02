import 'dart:ffi';

class RecentModel {
  final String recentImage;
  final int imageID;

  RecentModel({required this.imageID, required this.recentImage});

  factory RecentModel.fromJson(Map<String, dynamic> json) {
    return RecentModel(
        imageID: json['image_id'], recentImage: json['saved_images']);
  }

  static List<RecentModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((item) => RecentModel.fromJson(item)).toList();
  }
}
