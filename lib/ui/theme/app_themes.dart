import 'package:flutter/material.dart';

enum AppTheme { girls, boys, rainbow }

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = AppThemes.girlsTheme;
  AppTheme _currentThemeKey = AppTheme.girls;

  ThemeData get currentTheme => _currentTheme;
  AppTheme get currentThemeKey => _currentThemeKey;

  void setTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.girls:
        _currentTheme = AppThemes.girlsTheme;
        break;
      case AppTheme.boys:
        _currentTheme = AppThemes.boysTheme;
        break;
      case AppTheme.rainbow:
        _currentTheme = AppThemes.rainbowTheme;
        break;
    }
    _currentThemeKey = theme;
    notifyListeners();
  }
}

class AppThemes {
  static const _fontFamily = 'Inter';

  static final ThemeData girlsTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1a0b20),
    primaryColor: const Color(0xFFf957a7),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFf957a7),
      secondary: Color(0xFFa359e8),
      background: Color(0xFF1a0b20),
    ),
    fontFamily: _fontFamily,
  );

  static final ThemeData boysTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0c1425),
    primaryColor: const Color(0xFF00AFFF),
     colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00AFFF),
      secondary: Color(0xFF00FFC2),
      background: Color(0xFF0c1425),
    ),
    fontFamily: _fontFamily,
  );

  static final ThemeData rainbowTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF111111),
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.grey,
      background: Color(0xFF111111),
    ),
    fontFamily: _fontFamily,
  );
}
