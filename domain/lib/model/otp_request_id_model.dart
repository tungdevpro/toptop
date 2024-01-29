class OTPRequestIdModel {
  String? requestId;

  OTPRequestIdModel({this.requestId});

  OTPRequestIdModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    return data;
  }
}
