import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  void setLocale(BuildContext context, String langCode) {
    final locale = Locale(langCode);
    if (EasyLocalization.of(context)?.supportedLocales.contains(locale) ?? false) {
      EasyLocalization.of(context)?.setLocale(locale);
    } else {
      print('Locale $langCode is not supported');
    }
  }
}
