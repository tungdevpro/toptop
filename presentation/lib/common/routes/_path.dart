part of 'routes.dart';

enum PATHS { splash, intro, main, home, login, register, feed }

const pathToString = <PATHS, String>{
  PATHS.splash: '/splash',
  PATHS.intro: '/intro',
  PATHS.main: '/main',
  PATHS.home: '/home',
  PATHS.login: '/login',
  PATHS.feed: '/fedd',
};

extension PATHSExts on PATHS {
  String route() {
    return pathToString[this]!;
  }
}
