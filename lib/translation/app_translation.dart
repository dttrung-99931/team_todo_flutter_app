import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:team_todo_app/translation/vi.dart';

import 'en.dart';

/// Class contains configurations for multi-language: default language, change locale, ...
class AppTranslation extends Translations {
  static const LANG_CODE_EN = 'en';
  static const LANG_CODE_VI = 'vi';
  static const LANG_VI = 'Tiếng việt';
  static const LANG_EN = 'English';
  static const SUPPORTED_LOCALES = [
    Locale(LANG_CODE_EN, 'US'),
    Locale(LANG_CODE_VI, 'VN'),
  ];
  static const LANGUAGES = {LANG_CODE_EN: LANG_EN, LANG_CODE_VI: LANG_VI};

  static final defaultLocale = _getDefaultSupportedLocale();

  static String get currentLanguage => currentLanguageObs.value;
  static final currentLanguageObs = RxString(
    LANGUAGES[defaultLocale.languageCode],
  );

  static changeLanguage(String languageCode) {
    final locale = _findSupportedLocale(languageCode);
    assert(locale != null, '$languageCode language is not supported');

    if (currentLanguageObs.value != LANGUAGES[languageCode]) {
      currentLanguageObs.value = LANGUAGES[languageCode];
      Get.updateLocale(locale);
    }
  }

  static Locale _findSupportedLocale(String languageCode) {
    final locales = SUPPORTED_LOCALES.where(
      (element) => element.languageCode == languageCode,
    );
    return locales.isNotEmpty ? locales.first : null;
  }

  static Locale _getDefaultSupportedLocale() {
    final isDefaultLocaleSupported =
        _findSupportedLocale(Get.deviceLocale.languageCode) != null;
    return isDefaultLocaleSupported
        ? Get.deviceLocale
        : SUPPORTED_LOCALES.first;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };
}
