class SearchedModel {
  final String imageData;
  final int imageId;
  SearchedModel({required this.imageData, required this.imageId});

  factory SearchedModel.fromJson(Map<String, dynamic> json) {
    return SearchedModel(
      imageData: json['image_data'],
      imageId: json['image_id'],
    );
  }

  static List<SearchedModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => SearchedModel.fromJson(item)).toList();
  }
}
