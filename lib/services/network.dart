import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snaptag_frontend/models/imageModel.dart';
import 'package:snaptag_frontend/models/responseModel.dart';
import 'package:http_parser/http_parser.dart';

class SnapTagAPIRequest {
  static const serverIP = "10.0.2.2:8000";

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

  static Future<List<ImageModel>> getRecentNotes() async {
    const String url = "http://$serverIP/recentNotes";
    final dio = Dio();

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<ImageModel> recentList = ImageModel.fromJsonList(response.data);

        return recentList;
      } else {
        throw Exception("Failed to get recent notes");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<List<ImageModel>> getFavouriteNotes() async {
    const String url =
        "http://$serverIP/favoriteNotes"; // Adjust the URL accordingly
    final dio = Dio();

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data as List<dynamic>;
        List<ImageModel> savedList =
            data.map((json) => ImageModel.fromJson(json)).toList();

        return savedList;
      } else {
        throw Exception("Failed to get favourite notes");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<List<ImageModel>> getSearchImage(String tags) async {
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
        List<ImageModel> searchList = ImageModel.fromJsonList(response.data);
        return searchList;
      } else {
        throw Exception("No Image found");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<int> saveNote(String imageData, List<String> tags) async {
    const String url = "http://$serverIP/uploadNote";
    final dio = Dio();
    print(base64Decode(imageData));
    try {
      final FormData formData = FormData.fromMap({
        "image_file": await MultipartFile.fromString(
          imageData,
          filename: "image.png",
          contentType: MediaType("image", "png"),
        ),
        "tags": tags.join(" "), // Convert tags list to JSON string
      });

      final Response response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data["image_id"];
      } else {
        throw Exception("Failed to save note");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Error: $e");
    }
  }

  static Future<void> deleteNote(int imageID) async {
    const String url = "http://$serverIP/deleteNote";
    final dio = Dio();

    final FormData formData = FormData.fromMap({"image_id": imageID});

    final Response response = await dio.post(url, data: formData);

    if (response.statusCode != 200) {
      throw Exception("Failed to delete note");
    }
  }

  static Future<void> setFavorite(bool fav_val, int imageID) async {
    const String url = "http://$serverIP/setFavorite";
    final dio = Dio();

    final FormData formData =
        FormData.fromMap({"fav_val": fav_val, "image_id": imageID});

    final Response response = await dio.post(url, data: formData);

    if (response.statusCode != 200) {
      throw Exception("Failed to delete note");
    }
  }
}
