import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_class/core/theme/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  static const myThemeKey = 'isDarkTheme';
  bool _isDarkTheme = false;
  bool get isDark => _isDarkTheme;
  ThemeData get currentTheme =>
      _isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;

  dynamic toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(myThemeKey, _isDarkTheme);
  }

  dynamic loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(myThemeKey) ?? true;
    notifyListeners();
  }
}
