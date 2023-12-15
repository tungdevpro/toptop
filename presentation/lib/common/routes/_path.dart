part of 'routes.dart';

enum PATHS { splash, intro, home, login, register }

const pathToString = <PATHS, String>{
  PATHS.splash: '/splash',
  PATHS.intro: '/intro',
  PATHS.home: '/home',
  PATHS.login: '/login',
};

extension PATHSExts on PATHS {
  String route() {
    return pathToString[this]!;
  }
}
