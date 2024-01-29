import '../../import.dart';

abstract class ThemeManager {
  const ThemeManager._();

  static ThemeMode get mode => ThemeMode.light;

  static ThemeData get light => ThemeData(
        fontFamily: AppTypography.inter,
        appBarTheme: const AppBarTheme(
          elevation: .0,
          centerTitle: false,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
        ),
        scaffoldBackgroundColor: Colors.white,
      );

  static ThemeData get dark => ThemeData(
        fontFamily: AppTypography.inter,
        appBarTheme: const AppBarTheme(elevation: .0, centerTitle: true, backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
      );
}
