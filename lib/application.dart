import 'package:core/di/locator.dart';
import 'package:core/service/app_loading.dart';
import 'package:core/service/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/routes/routes.dart';
import 'package:presentation/common/themes/theme_manager.dart';
import 'package:presentation/presentation.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<AppNavigator>().navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.light,
      themeMode: ThemeManager.mode,
      darkTheme: ThemeManager.dark,
      onGenerateRoute: Routes.generateRoutes,
      initialRoute: GlobalConfiguration.initRoute,
      builder: locator<AppLoading>().init(),
    );
  }
}
