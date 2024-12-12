import 'package:flutter/material.dart';

abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class UpdateTheme extends SettingsEvent {
  final bool isLightTheme;

  UpdateTheme(this.isLightTheme);
}

class UpdatePrimaryColor extends SettingsEvent {
  final Color color;

  UpdatePrimaryColor(this.color);
}

class UpdateLanguage extends SettingsEvent {
  final String languageCode;

  UpdateLanguage(this.languageCode);
}
