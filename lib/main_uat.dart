import 'package:core/core.dart';
import 'package:environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo các dependency module
  await Core.init();
  AppEnvironment.setup(Env.uat);
  Presentation.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const Application());
  });
}
