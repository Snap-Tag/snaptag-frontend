import 'package:dio/dio.dart';
import 'package:snaptag_frontend/models/favouriteModel.dart';
import 'package:snaptag_frontend/models/recentModel.dart';
import 'package:snaptag_frontend/models/responseModel.dart';
import 'package:snaptag_frontend/models/searchedModel.dart';

class SnapTagAPIRequest {
  static const serverIP = "192.168.1.2:8000";
  static Future<ResponseModel> getTags(String imagePath) async {
    const String url = "http://$serverIP/snapservice";
    final dio = Dio();

    FormData formData = FormData.fromMap({
      "image_file": await MultipartFile.fromFile(imagePath),
      "content_type": "image",
    });

    final response = await dio.post(
      url,
      data: formData,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to get tags");
    }

    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return responseModel;
  }

  static Future<List<RecentModel>> getRecentNotes() async {
    const String url = "http://$serverIP/recentnotes";
    final dio = Dio();

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<RecentModel> recentList = RecentModel.fromJsonList(response.data);

        return recentList;
      } else {
        throw Exception("Failed to get recent notes");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<List<FavouriteModel>> getFavouriteNotes() async {
    const String url =
        "http://$serverIP/savednotes"; // Adjust the URL accordingly
    final dio = Dio();

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data as List<dynamic>;
        List<FavouriteModel> savedList =
            data.map((json) => FavouriteModel.fromJson(json)).toList();

        return savedList;
      } else {
        throw Exception("Failed to get favourite notes");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<List<SearchedModel>> getSearchImage(String tags) async {
    const String url = "http://$serverIP/searchNotes";
    final dio = Dio();

    final Map<String, dynamic> queryParameters = {
      "tag": tags,
    };

    try {
      final Response response =
          await dio.get(url, queryParameters: queryParameters);

      print(response.data);

      if (response.statusCode == 200) {
        List<SearchedModel> searchList =
            SearchedModel.fromJsonList(response.data);
        return searchList;
      } else {
        throw Exception("No Image found");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }
}
