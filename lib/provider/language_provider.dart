import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

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

// class LanguageProvider {
//
//   static changeLanguage(BuildContext context){
//     Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
//     if(currentLocal == const Locale('en', 'US')){
//       EasyLocalization.of(context)!.setLocale( const Locale('en' ,'US'));
//     }
//     else{
//       EasyLocalization.of(context)!.setLocale( const Locale('es' ,'ES'));
//     }
//   }
// }