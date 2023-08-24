import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class HydroLocalizations {
  final Locale locale;

  HydroLocalizations(this.locale);

  static HydroLocalizations? of(BuildContext context) {
    return Localizations.of<HydroLocalizations>(context, HydroLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'language': 'Language: English',
    },
    'ja': {
      'language': 'Language: Japanese',
    },
    'zh': {
      'language': 'Language: Chinese',
    },
  };

  String? get language {
    return _localizedValues[locale.languageCode]?['language'];
  }
}

class HydroLocalizationsDelegate
    extends LocalizationsDelegate<HydroLocalizations> {
  const HydroLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ja', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<HydroLocalizations> load(Locale locale) {
    return SynchronousFuture<HydroLocalizations>(HydroLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<HydroLocalizations> old) {
    return false;
  }
}
