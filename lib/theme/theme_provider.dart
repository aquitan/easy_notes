import 'package:easy_notes/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _prefs;
  ThemeData _themeData = lightTheme;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;
  bool get isDark => _themeData == darkTheme;

  void toggleTheme() {
    _themeData = isDark ? lightTheme : darkTheme;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadTheme() async {
    await _initPrefs();
    bool? isDarkMode = _prefs.getBool(key);
    _themeData = (isDarkMode ?? false) ? darkTheme : lightTheme;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    await _initPrefs();
    _prefs.setBool(key, isDark);
  }
}
