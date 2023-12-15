import 'package:flutter/material.dart';

abstract class ThemeManager {
  const ThemeManager._();

  static ThemeMode get mode => ThemeMode.light;

  static ThemeData get light => ThemeData(
        fontFamily: 'InterRegular',
        appBarTheme: const AppBarTheme(elevation: .0, centerTitle: true, backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
      );

  static ThemeData get dark => ThemeData(
        fontFamily: 'InterRegular',
        appBarTheme: const AppBarTheme(elevation: .0, centerTitle: true, backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
      );
}
