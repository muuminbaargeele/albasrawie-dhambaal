import 'package:dio/dio.dart';
import '../../core/constants/constants.dart';
import '../responses/base_response.dart';

class ApiClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {
      'Content-Type': Constants.contentType,
    },
  ));

  static Future<void> getRequest(
    String path,
    void Function(bool status, dynamic result, String? error) callback,
  ) async {
    try {
      final response = await _dio.get(path);
      final baseResponse = BaseResponse.fromJson(response.data, (json) => json);
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      callback(false, null, e.toString());
    }
  }

  static Future<void> getRequestWithHeader(
    String path,
    Map<String, String> headers,
    void Function(bool status, dynamic result, String? error) callback,
  ) async {
    try {
      final response = await _dio.get(path, options: Options(headers: headers));
      final baseResponse = BaseResponse.fromJson(response.data, (json) => json);
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      callback(false, null, e.toString());
    }
  }

  static Future<void> postRequest(
    String path,
    Map<String, dynamic> data,
    void Function(bool status, dynamic result, String? error) callback,
  ) async {
    try {
      final response = await _dio.post(path, data: data);
      final baseResponse = BaseResponse.fromJson(response.data, (json) => json);
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      callback(false, null, e.toString());
    }
  }

  static Future<void> postRequestWithHeader(
    String path,
    Map<String, dynamic> data,
    Map<String, String> headers,
    void Function(bool status, dynamic result, String? error) callback,
  ) async {
    try {
      final response = await _dio.post(path, data: data, options: Options(headers: headers));
      final baseResponse = BaseResponse.fromJson(response.data, (json) => json);
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      callback(false, null, e.toString());
    }
  }
}