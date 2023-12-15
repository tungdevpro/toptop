import 'package:flutter/material.dart';
import 'package:presentation/common/routes/routes.dart';
import 'package:presentation/common/themes/theme_manager.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.light,
      themeMode: ThemeManager.mode,
      darkTheme: ThemeManager.dark,
      onGenerateRoute: Routes.generateRoutes,
      initialRoute: PATHS.home.route(),
    );
  }
}
