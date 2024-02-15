class RegisterRequest {
  String? requestId;
  String? fullName;
  String? email;
  String? password;
  String? username;

  RegisterRequest({this.requestId, this.fullName, this.email, this.password, this.username});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['username'] = username;
    return data;
  }
}
