import 'package:flutter/material.dart';

class Settings {
  final bool isDarkMode;
  final Color primaryColor;
  final String languageCode;

  Settings({
    required this.isDarkMode,
    required this.primaryColor,
    required this.languageCode,
  });

  Settings copyWith({
    bool? isDarkMode,
    Color? primaryColor,
    String? languageCode,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primaryColor: primaryColor ?? this.primaryColor,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}