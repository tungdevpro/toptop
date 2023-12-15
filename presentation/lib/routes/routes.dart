import 'package:flutter/material.dart';

import '../features/home/home.dart';

part '_path.dart';

abstract class Routes {
  Routes._();

  static Map<String, WidgetBuilder> routes = {
    PATHS.home.route(): (_) => const HomePage(),
  };
}
