import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SettingsLocalDataSource {
  static const String _themeKey = 'theme';
  static const String _colorKey = 'color';
  static const String _languageKey = 'language';

  Future<void> saveTheme(bool isLightTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isLightTheme);
  }

  Future<void> savePrimaryColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_colorKey, color.value);
  }

  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_languageKey, languageCode);
  }

  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? true;
  }

  Future<Color> loadPrimaryColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_colorKey);
    return colorValue != null ? Color(colorValue) : Colors.blue;
  }

  Future<String> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }
}
