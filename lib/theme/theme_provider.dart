import 'package:easy_notes/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDark => _themeData == darkTheme;

  void toggleTheme() {
    _themeData = isDark ? lightTheme : darkTheme;
    notifyListeners();
  }
}
