import 'dart:async';

import 'package:core/core.dart';
import 'package:environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Khởi tạo các dependency module
    await Core.init();
    AppEnvironment.setup(Env.prod);
    Presentation.init();
    FlutterError.onError = (FlutterErrorDetails details) => Core.onError(details);
    // initApp();
  }, __tracker);
}

void __tracker(Object error, StackTrace stack) {
  debugPrint("-------------OUT-------------------");
  debugPrint("Error :  $error");
  debugPrint("StackTrace :  $stack");
  Core.telegramBot.send('Message: ${error.toString()}');
}
