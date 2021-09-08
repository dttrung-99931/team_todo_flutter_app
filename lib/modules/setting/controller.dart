import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_todo_app/translation/app_translation.dart';

import '../../base/base_controller.dart';

class SettingController extends BaseController {
  static const String KEY_LANGUGAE_CODE = 'LANGUGAE_CODE';

  final currentLanguageObs = RxString();
  String get currentLanguage => currentLanguageObs.value;

  final currentLanguageCodeObs = RxString();
  String get currentLanguageCode => currentLanguageCodeObs.value;

  SharedPreferences _pref;

  Locale __currentLocale;
  Locale get currentLocale => __currentLocale;
  set _currentLocale(Locale locale) {
    __currentLocale = locale;
    currentLanguageObs.value = AppTranslation.LANGUAGES[locale.languageCode];
    currentLanguageCodeObs.value = locale.languageCode;
  }

  @override
  Future<void> onInit() async {
    _pref = await SharedPreferences.getInstance();
    _initCurrentLanguage();
    super.onInit();
  }

  /// Init current langage by language code stored in SharedPreferences. 
  /// If there's no stored lanaguage code, then set default language
  void _initCurrentLanguage() {
    var langCode = _pref.getString(KEY_LANGUGAE_CODE);
    if (langCode == null) {
      langCode = AppTranslation.getDefaultSupportedLangCode();
    }
    changeLanguage(langCode);
  }

  /// Change current langage by [langCode]
  /// [langCode] must be [AppTranslation.LANG_CODE_VI] or [AppTranslation.LANG_CODE_EN]
  void changeLanguage(String langCode) {
    _currentLocale = AppTranslation.findSupportedLocale(langCode);
    assert(currentLocale != null, 'Unsupport langage code ' + langCode);

    AppTranslation.changeLocale(__currentLocale);
    _pref.setString(KEY_LANGUGAE_CODE, __currentLocale.languageCode);
  }
}
