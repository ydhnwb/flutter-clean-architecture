import 'package:flutter_clean_architecture/data/common/util/serializable.dart';

class WrappedResponse <T extends Serializable> {
  bool status;
  String message;
  T? data;

  WrappedResponse({ required this.status, required this.message, required this.data });

  factory WrappedResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create){
    return WrappedResponse<T>(status: json["status"], message: json["message"], data: create(json["data"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "status": this.status,
      "message": this.message,
      "data": this.data?.toJson()
    };
  }
}

class WrappedListResponse <T extends Serializable> {
  bool status;
  String message;
  List<T>? data;

  WrappedListResponse({ required this.status, required this.message, required this.data });

  factory WrappedListResponse.fromjson(Map<String, dynamic> json, Function(List<dynamic>) create){
    return WrappedListResponse(status: json["status"], message: json["message"], data: create(json["data"]));
  }

  Map<String, dynamic> toJson(){
    return {
      "status": this.status,
      "message": this.message,
      "data": this.data
    };
  }
}