import 'package:flutter/material.dart';

abstract class AppConfigs {
  const AppConfigs._();

  static const String pathTranslations = 'assets/translations/';
  static const List<Locale> supportedLocales = [
    Locale('en', 'EN'),
    Locale('vi', 'VI'),
  ];

  static const Locale fallbackLocale = Locale('vi', 'VI');
}
