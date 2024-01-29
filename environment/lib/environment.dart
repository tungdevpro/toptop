library environment;

import 'package:environment/setting_app_model.dart';

enum Env { dev, uat, prod }

abstract class AppEnvironment {
  const AppEnvironment._();
  static late String headerKey;
  static String prefix = '/api/v2';
  static late SettingAppModel model;
  static late bool _useApiVersion;

  static setup(Env env, {bool useApiVersion = false}) {
    _useApiVersion = useApiVersion;
    headerKey = 'Authorization';

    switch (env) {
      case Env.uat:
        {
          model = SettingAppModel(
            title: 'UAT ',
            apiServerUrl: '',
            webUrl: "",
            clientId: "---",
            clientSecret: "---",
            iosAppId: "",
            androidAppId: "",
            apiVersion: 2,
            appBuildVersion: 21,
            mapAccessToken: "",
          );
          break;
        }
      case Env.prod:
        {
          model = SettingAppModel(
            title: 'Prod',
            apiServerUrl: "",
            apiMapVnpostUrl: "",
            apiKeyVnpost: "",
            apiMapVnpostVersion: 1.1,
            webUrl: "",
            clientId: "---",
            clientSecret: "---",
            iosAppId: "",
            androidAppId: "",
            apiVersion: 2,
            appBuildVersion: 21,
            mapAccessToken: "",
          );
          break;
        }
      default:
        {
          model = SettingAppModel(
            title: 'Dev',
            apiServerUrl: "",
            apiMapVnpostUrl: "",
            apiKeyVnpost: "",
            apiMapVnpostVersion: 1.1,
            webUrl: "",
            clientId: "---",
            clientSecret: "---",
            iosAppId: "",
            androidAppId: "",
            apiVersion: 2,
            appBuildVersion: 21,
            mapAccessToken: "",
          );
          break;
        }
    }
  }

  static String get title => model.title ?? 'App name';
  static String get apiBaseUrl => '${model.apiServerUrl}$prefix${_useApiVersion ? '${model.apiVersion}/' : ''}';
}
