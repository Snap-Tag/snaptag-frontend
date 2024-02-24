// the response model is used to parse the response from the server
// it contains cropped_document a base64encoded image and extracted_tags a list of strings as the fields

class ResponseModel {
  final String croppedDocument;
  final List<String> extractedTags;

  ResponseModel({required this.croppedDocument, required this.extractedTags});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      croppedDocument: json['cropped_document'],
      extractedTags: List<String>.from(json['extracted_tags']),
    );
  }
}
