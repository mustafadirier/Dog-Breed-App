import 'dart:convert';

class ApiResponseModel {
  dynamic message;
  String status;

  ApiResponseModel({required this.message, required this.status});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      message: json['message'],
      status: json['status'],
    );
  }
  
  factory ApiResponseModel.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return ApiResponseModel.fromJson(json);
  }
}
