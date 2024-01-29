class SaveUserModel {
  String? username;
  String? token;
  String? id;
  String? fullname;

  SaveUserModel({this.username, this.token, this.id, this.fullname});

  SaveUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    token = json['token'];
    id = json['id'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['token'] = token;
    data['id'] = id;
    data['fullname'] = fullname;
    return data;
  }
}
