enum CodeApiResponse { success, parseErr, timeout, tokenExprired, unknowErr }

const _mapApiCode = <CodeApiResponse, String>{
  CodeApiResponse.success: '0',
  CodeApiResponse.parseErr: '-1',
  CodeApiResponse.timeout: '-2',
  CodeApiResponse.unknowErr: '-99',
  CodeApiResponse.tokenExprired: '401'
};

extension ApiCodeExts on CodeApiResponse {
  String code() {
    return _mapApiCode[this]!;
  }
}

class ApiResponse<T> {
  int? code;
  String? message;
  String? statusCode;
  T? data;

  ApiResponse({this.code, this.message, this.statusCode, this.data});

  bool isSuccess() => CodeApiResponse.success.code() == code;

  bool isTimeOut() => CodeApiResponse.timeout.code() == code;

  bool isTokenExprired() => CodeApiResponse.tokenExprired.code() == code;

  ApiResponse.fromJson(Map<String, dynamic> json, {T Function(Object? json)? fromJson}) {
    code = json['code'];
    message = json['message'];
    statusCode = json['status_code'];
    data = data == null ? null : fromJson?.call(json);
  }

  Map<String, dynamic> toJson({Object? Function(T value)? toJson}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['status_code'] = statusCode;
    data['data'] = this.data == null ? null : toJson?.call(this.data as T);
    return data;
  }
}
