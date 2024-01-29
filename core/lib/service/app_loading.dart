import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppLoading {
  TransitionBuilder init() {
    return EasyLoading.init();
  }

  static void show() {}

  static void hide() {}
}
