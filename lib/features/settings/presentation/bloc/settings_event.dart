part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class DarkModeChanged extends SettingsEvent {}

class PrimaryColorChanged extends SettingsEvent {
  final Color color;

  PrimaryColorChanged(this.color);
}

class LanguageChanged extends SettingsEvent {
  final String languageCode;

  LanguageChanged(this.languageCode);
}
