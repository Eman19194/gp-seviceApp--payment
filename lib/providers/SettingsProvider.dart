import 'package:flutter/material.dart';

// subject - observable - publisher
// data holder
class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLocale = 'en';


  String getSplash() {
   return 'assets/images/logo.png';
  }
  void changeLocale(String newLocale) {
    if (newLocale == currentLocale) return;
    currentLocale = newLocale;
    notifyListeners();
  }
}
