import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/widgets/error_screen.dart';
import 'package:presentation/features/login/login.dart';
import 'package:presentation/features/main/main_page.dart';
import 'package:presentation/features/register/register_page.dart';

import '../../features/home/home_page.dart';
import '../../features/splash/splash_page.dart';

part '_path.dart';

abstract class Routes {
  const Routes._();

  static Map<String, WidgetBuilder> routes = {
    PATHS.splash.route(): (_) => const SplashPage(),
    PATHS.main.route(): (_) => const MainPage(),
    PATHS.home.route(): (_) => const HomePage(),
    PATHS.login.route(): (_) => const LoginPage(),
    PATHS.register.route(): (_) => const RegisterPage(),
  };

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    String? routeName = settings.name?.split('?').first;

    return CupertinoPageRoute(builder: routes[routeName] ?? (_) => const Scaffold(body: ErrorScreen()), settings: settings);
  }
}
