import 'package:ft_hangouts/features/settings/data/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SettingsLocalDataSource {
  static const String _darkKey = 'dark';
  static const String _colorKey = 'color';
  static const String _languageKey = 'language';

  Future<void> saveSettings({
    required SettingsModel settings,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkKey, settings.isDarkMode);
    await prefs.setInt(_colorKey, settings.primaryColor.value);
    await prefs.setString(_languageKey, settings.languageCode);
  }

  Future<SettingsModel> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_darkKey) ?? false;
    final colorValue = prefs.getInt(_colorKey) ?? Colors.blue.value;
    final primaryColor = Color(colorValue);
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    return SettingsModel(
      isDarkMode: isDarkMode,
      primaryColor: primaryColor,
      languageCode: languageCode,
    );
  }
}
