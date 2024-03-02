import 'package:dio/dio.dart';
import 'package:snaptag_frontend/models/favouriteModel.dart';
import 'package:snaptag_frontend/models/recentModel.dart';
import 'package:snaptag_frontend/models/responseModel.dart';
import 'package:snaptag_frontend/models/searchModel.dart';

class SnapTagAPIRequest {
  static Future<ResponseModel> getTags(String imagePath) async {
    const String url = "http://localhost/snapservice";
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
    const String url = "http://localhost/recentnotes";
    final dio = Dio();

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data as List<dynamic>;
        List<RecentModel> recentList =
            data.map((json) => RecentModel.fromJson(json)).toList();

        return recentList;
      } else {
        throw Exception("Failed to get recent notes");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<List<favouriteModel>> getFavouriteNotes() async {
    const String url =
        "http://localhost/savednotes"; // Adjust the URL accordingly
    final dio = Dio();

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data as List<dynamic>;
        List<favouriteModel> savedList =
            data.map((json) => favouriteModel.fromJson(json)).toList();

        return savedList;
      } else {
        throw Exception("Failed to get favourite notes");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<List<searchModel>> getSearchImage(String tags) async {
    const String url = "http://localhost/snapservice";
    final dio = Dio();

    
    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data as List<dynamic>;
        List<searchModel> searchList =
            data.map((json) => searchModel.fromJson(json)).toList();

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
