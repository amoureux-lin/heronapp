import 'code.dart';

class ResultData<T> {
  final T? data;
  final int code;
  final String message;
  final bool success;

  ResultData({this.data, required this.code, required this.message, required this.success});

  factory ResultData.fromResponse(dynamic response) {
    return ResultData(
      data: response["data"],
      code: response["code"] ?? -1,
      message: response["message"] ?? "Unknown Error",
      success: response["code"] == Code.SUCCESS,
    );
  }
}