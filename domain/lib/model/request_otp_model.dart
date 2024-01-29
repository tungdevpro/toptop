class RequestOTPModel {
  String? email;
  String? type;

  RequestOTPModel({this.email, this.type});

  RequestOTPModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['type'] = type;
    return data;
  }
}
