import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData _themeData;

  // status
  bool _isDark = false;

  // getter
  bool get isDark => _isDark;
  getTheme() => _themeData;

  // SharedPreference instance
  SharedPreferences? _prefs;

  // Constructor
  ThemeProvider(
    this._themeData,
    this._isDark,
  );

  // Set Theme
  setTheme(ThemeData themeData) async {
    _isDark = !_isDark;
    _themeData = themeData;

    // Save theme to SharedPreference
    _prefs = await SharedPreferences.getInstance();
    _prefs!.setBool('isDark', _isDark);

    notifyListeners();
  }

}