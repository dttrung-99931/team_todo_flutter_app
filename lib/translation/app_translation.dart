import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:team_todo_app/translation/vi.dart';

import 'en.dart';

/// Class contains language translation configurations, 
/// static util methods about lanaguage 
class AppTranslation extends Translations {
  static const LANG_CODE_EN = 'en';
  static const LANG_CODE_VI = 'vi';
  static const SUPPORTED_LOCALES = [
    Locale(LANG_CODE_EN, 'US'),
    Locale(LANG_CODE_VI, 'VN'),
  ];
  static const LANGUAGES = {LANG_CODE_EN: 'Tiếng việt', LANG_CODE_VI: 'English'};

  static Locale findSupportedLocale(String languageCode) {
    final locales = SUPPORTED_LOCALES.where(
      (element) => element.languageCode == languageCode,
    );
    return locales.isNotEmpty ? locales.first : null;
  }

  static Locale getDefaultSupportedLocale() {
    final isCurrentDeviceLocaleSupported =
        findSupportedLocale(Get.deviceLocale.languageCode) != null;
    return isCurrentDeviceLocaleSupported
        ? Get.deviceLocale
        : SUPPORTED_LOCALES.first;
  }

  static String getDefaultSupportedLangCode() {
    return getDefaultSupportedLocale().languageCode;
  }

  static void changeLocale(Locale locale) {
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };
}
