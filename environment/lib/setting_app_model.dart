class SettingAppModel {
  String? apiServerUrl;
  String? apiMapVnpostUrl;
  String? apiKeyVnpost;
  double? apiMapVnpostVersion;
  String? webUrl;
  String? clientId;
  String? clientSecret;
  String? iosAppId;
  String? androidAppId;
  int? apiVersion;
  int? appBuildVersion;
  String? mapAccessToken;
  String? title;

  SettingAppModel(
      {this.apiServerUrl,
      this.apiMapVnpostUrl,
      this.apiKeyVnpost,
      this.apiMapVnpostVersion,
      this.webUrl,
      this.clientId,
      this.clientSecret,
      this.iosAppId,
      this.androidAppId,
      this.apiVersion,
      this.appBuildVersion,
      this.mapAccessToken,
      this.title});

  SettingAppModel.fromJson(Map<String, dynamic> json) {
    apiServerUrl = json['api_server_url'];
    apiMapVnpostUrl = json['api_map_vnpost_url'];
    apiKeyVnpost = json['api_key_vnpost'];
    apiMapVnpostVersion = json['api_map_vnpost_version'];
    webUrl = json['web_url'];
    clientId = json['client_id'];
    clientSecret = json['client_secret'];
    iosAppId = json['ios_app_id'];
    androidAppId = json['android_app_id'];
    apiVersion = json['api_version'];
    appBuildVersion = json['appBuildVersion'];
    mapAccessToken = json['mapAccessToken'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['api_server_url'] = apiServerUrl;
    data['api_map_vnpost_url'] = apiMapVnpostUrl;
    data['api_key_vnpost'] = apiKeyVnpost;
    data['api_map_vnpost_version'] = apiMapVnpostVersion;
    data['web_url'] = webUrl;
    data['client_id'] = clientId;
    data['client_secret'] = clientSecret;
    data['ios_app_id'] = iosAppId;
    data['android_app_id'] = androidAppId;
    data['api_version'] = apiVersion;
    data['appBuildVersion'] = appBuildVersion;
    data['mapAccessToken'] = mapAccessToken;
    data['title'] = title;
    return data;
  }
}
