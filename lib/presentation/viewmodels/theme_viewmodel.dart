import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ThemeViewModel - handles theme state and persistence
class ThemeViewModel extends GetxController {
  static const String _themeKey = 'theme_mode';

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Getters
  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint('ThemeViewModel: Loading theme from storage...');

    final Object? savedValue = prefs.get(_themeKey);
    debugPrint('ThemeViewModel: Saved value type: ${savedValue.runtimeType}');

    if (savedValue is String) {
      themeMode.value = savedValue == 'dark' ? ThemeMode.dark : ThemeMode.light;
    } else if (savedValue is bool) {
      themeMode.value = savedValue ? ThemeMode.dark : ThemeMode.light;
      await _saveTheme(); // Migrate
    }
  }

  Future<void> toggleTheme() async {
    themeMode.value =
        themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _saveTheme();
  }

  Future<void> setTheme(ThemeMode mode) async {
    themeMode.value = mode;
    await _saveTheme();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      themeMode.value == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
