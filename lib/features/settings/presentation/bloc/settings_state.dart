import 'package:flutter/material.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isLightTheme;
  final Color primaryColor;
  final String languageCode;

  SettingsLoaded(this.isLightTheme, this.primaryColor, this.languageCode);
}

class SettingsUpdated extends SettingsState {}
