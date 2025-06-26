import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Cilad farsamo ayaa dhacay');
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
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Cilad farsamo ayaa dhacay');
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
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Cilad farsamo ayaa dhacay');
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
      if (baseResponse.statusCode == 200 && baseResponse.result != null) {
        callback(true, baseResponse.result, null);
      } else {
        callback(false, null, baseResponse.error?.message ?? 'Cilad farsamo ayaa dhacay');
      }
    } catch (e) {
      _handleDioError(e, callback);
    }
  }

  static void _handleDioError(dynamic error, void Function(bool, dynamic, String?) callback) {
    String errorMessage = 'Adeeggu wuu ciladaysan yahay';
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Amminta ayaa ka dhacday isku-xirka adeegga. Fadlan isku day mar kale.';
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Adeeggu wuu ciladaysan yahay. Fadlan dib u tijaabi ammin yar kadib.';
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Codsiga waa la jooyiyey. Fadlan in yar sug.';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Internet lama helin: Fadlan hubi qadkaaga.';
          break;
        case DioExceptionType.unknown:
          errorMessage = 'Cilad farsamo ayaa dhacay, fadlan mar kale isku day.';
          break;
        default:
          errorMessage = error.message ?? 'Adeeggu wuu ciladaysan yahay.';
      }
    } else {
      errorMessage = error.toString();
    }

    if (kDebugMode) {
      print('[DioException] $error');
    }
    callback(false, null, errorMessage);
  }
}