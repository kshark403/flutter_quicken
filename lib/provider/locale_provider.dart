import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  // Shared Preferences for save locale
  SharedPreferences? _prefs;

  // Constructor
  LocaleProvider(Locale locale) {
    _locale = locale;
  }

  // Change Locale
  void changeLocale(Locale newLocale) async {

    // Save Locale to Shared Preferences
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.setString('languageCode', newLocale.languageCode);

    _locale = newLocale;
    notifyListeners();
  }

}