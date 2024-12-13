part of 'settings_bloc.dart';

sealed class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Settings settings;

  SettingsLoaded(this.settings);
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);
}
