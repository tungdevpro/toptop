import 'dart:ui';

abstract class AppLangs {
  const AppLangs._();
  static const String path = 'assets/translations';
  static const String unused = 'unused';
  static const List<Locale> supportedLocales = [Locale('en', 'US'), Locale('vi', 'VN')];
  static const Locale fallbackLocale = Locale('vi', 'VN');
}
