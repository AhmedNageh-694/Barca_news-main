import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// LocaleViewModel - handles locale/language state and persistence
class LocaleViewModel extends GetxController {
  static const String _localeKey = 'locale';

  final Rx<Locale> locale = const Locale('en').obs;

  // Getters
  bool get isArabic => locale.value.languageCode == 'ar';
  bool get isEnglish => locale.value.languageCode == 'en';

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final dynamic savedLocale = prefs.get(_localeKey);

    if (savedLocale is String && savedLocale.isNotEmpty) {
      locale.value = Locale(savedLocale);
      Get.updateLocale(locale.value);
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    await _saveLocale();
  }

  Future<void> toggleLocale() async {
    final newLocale = isEnglish ? const Locale('ar') : const Locale('en');
    await setLocale(newLocale);
  }

  Future<void> _saveLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.value.languageCode);
  }
}
