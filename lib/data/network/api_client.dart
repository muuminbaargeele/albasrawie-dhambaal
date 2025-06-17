import 'package:dio/dio.dart';
import '../../core/constants/constants.dart';
import '../responses/base_response.dart';

class ApiClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.devBaseUrl,
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
      if (baseResponse.status_code == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      _handleDioError(e, callback);
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
      if (baseResponse.status_code == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      _handleDioError(e, callback);
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
      if (baseResponse.status_code == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      _handleDioError(e, callback);
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
      if (baseResponse.status_code == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Unknown error');
      }
    } catch (e) {
      _handleDioError(e, callback);
    }
  }

  static void _handleDioError(dynamic error, void Function(bool, dynamic, String?) callback) {
    String errorMessage = 'Something went wrong';
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Connection timed out. Please try again.';
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Server error. Please try again later.';
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Request was cancelled.';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Connection error. Please check your internet.';
          break;
        case DioExceptionType.unknown:
          errorMessage = 'Unknown error occurred. Please try again.';
          break;
        default:
          errorMessage = error.message ?? 'Something went wrong.';
      }
    } else {
      errorMessage = error.toString();
    }

    print('[DioException] $error');
    callback(false, null, errorMessage);
  }
}