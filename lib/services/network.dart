import 'package:dio/dio.dart';
import 'package:snaptag_frontend/models/responseModel.dart';

class SnapTagAPIRequest {
  static Future<ResponseModel> getTags(String imagePath) async {
    const String url = "http://192.168.1.4:8000/snapservice";
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
}
