import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocale => _appLocale;

  void changeLocale(Locale newLocale) {
    if (_appLocale == newLocale) return;

    _appLocale = newLocale;
    notifyListeners();
  }
}
