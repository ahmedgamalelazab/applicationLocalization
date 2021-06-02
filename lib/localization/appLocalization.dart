import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationLocalization {
  final Locale locale;

  ApplicationLocalization(this.locale);

  static ApplicationLocalization of(BuildContext context) {
    return Localizations.of<ApplicationLocalization>(
        context, ApplicationLocalization);
  }

  ///this is our target here
  Map<String, String> _localizedValues;

  //load the data source
  Future load() async {
    print(locale.languageCode);
    String languageValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String, dynamic> valuesParsed =
        json.decode(languageValues) as Map<String, dynamic>;
    print(valuesParsed);
    //lets convert from map<String,dynamic> into map<String,String>
    _localizedValues =
        valuesParsed.map((key, value) => MapEntry(key, value.toString()));
    print(_localizedValues);
  }

  //getting the translated values
  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate delegate =
      _ApplicationLocalizationDelegate();
}

//our custom delegate that will translate for us

class _ApplicationLocalizationDelegate
    extends LocalizationsDelegate<ApplicationLocalization> {
  const _ApplicationLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<ApplicationLocalization> load(Locale locale) async {
    ApplicationLocalization localization = new ApplicationLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_ApplicationLocalizationDelegate old) => false;
}
