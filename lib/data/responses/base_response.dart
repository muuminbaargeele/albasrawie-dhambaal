class BaseResponse<T> {
  final int statusCode;
  final T? result;
  final ErrorPayload? error;

  BaseResponse({
    required this.statusCode,
    required this.result,
    required this.error,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return BaseResponse<T>(
      statusCode: json['statusCode'],
      result: json['payload']['result'] != null
          ? fromJsonT(json['payload']['result'])
          : null,
      error: json['payload']['error'] != null
          ? ErrorPayload.fromJson(json['payload']['error'])
          : null,
    );
  }
}

class ErrorPayload {
  final int code;
  final String message;
  final bool sessionExpired;

  ErrorPayload({
    required this.code,
    required this.message,
    required this.sessionExpired,
  });

  factory ErrorPayload.fromJson(Map<String, dynamic> json) {
    return ErrorPayload(
      code: json['code'],
      message: json['message'],
      sessionExpired: json['sessionExpired'] ?? false,
    );
  }
}