class LoginResponse {
  String? accessToken;
  String? refreshToken;
  int? expireAt;
  String? tokenType;

  LoginResponse({this.accessToken, this.refreshToken, this.expireAt, this.tokenType});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expireAt = json['expire_at'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['expire_at'] = expireAt;
    data['token_type'] = tokenType;
    return data;
  }
}
