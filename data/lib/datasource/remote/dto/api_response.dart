enum CodeApiResponse { success, parseErr, timeout, tokenExprired, unknowErr }

const _mapApiCode = <CodeApiResponse, int>{
  CodeApiResponse.success: 200,
  CodeApiResponse.parseErr: -1,
  CodeApiResponse.timeout: -2,
  CodeApiResponse.unknowErr: -99,
  CodeApiResponse.tokenExprired: 401,
};

extension ApiCodeExts on CodeApiResponse {
  int code() => _mapApiCode[this]!;
}

class ApiResponse<T> {
  String? code;
  int? status;
  String? error;
  List<String>? codes;
  T? data;

  ApiResponse({this.code, this.error, this.codes, this.status, this.data});

  bool isSuccess() => CodeApiResponse.success.code() == status;

  bool isTimeOut() => CodeApiResponse.timeout.code() == status;

  bool isTokenExprired() => CodeApiResponse.tokenExprired.code() == status;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    codes = json['codes'];
    data = (json['data'] != null && json['data'] is Map) ? ((json['data'] as Map).containsKey('item') ? json['data']['item'] : null) : null;
  }
}
