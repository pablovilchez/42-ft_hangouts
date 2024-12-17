import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/di/dependency_injection.dart';
import 'package:ft_hangouts/features/settings/domain/entities/settings.dart';
import 'package:ft_hangouts/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:ft_hangouts/features/settings/domain/usecases/save_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final getSettingsUseCase = getIt<GetSettingsUseCase>();
  final saveSettingsUseCase = getIt<SaveSettingsUseCase>();


  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<DarkModeChanged>(_onUpdateDarkMode);
    on<PrimaryColorChanged>(_onUpdatePrimaryColor);
    on<LanguageChanged>(_onUpdateLanguage);

    add(LoadSettings());
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    try {
      final settings = await getSettingsUseCase();
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError('Failed to load settings'));
    }
  }

  Future<void> _onUpdateDarkMode(
      DarkModeChanged event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings = currentState.settings
          .copyWith(isDarkMode: !currentState.settings.isDarkMode);
      try {
        await saveSettingsUseCase(updatedSettings);
        emit(SettingsLoaded(updatedSettings));
      } catch (e) {
        emit(SettingsError('Failed to update primary color'));
      }
    }
  }

  Future<void> _onUpdatePrimaryColor(
      PrimaryColorChanged event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings =
          currentState.settings.copyWith(primaryColor: event.color);
      try {
        await saveSettingsUseCase(updatedSettings);
        emit(SettingsLoaded(updatedSettings));
      } catch (e) {
        emit(SettingsError('Failed to update primary color'));
      }
    }
  }

  Future<void> _onUpdateLanguage(
      LanguageChanged event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final updatedSettings =
          currentState.settings.copyWith(languageCode: event.languageCode);
      try {
        await saveSettingsUseCase(updatedSettings);
        emit(SettingsLoaded(updatedSettings));
      } catch (e) {
        emit(SettingsError('Failed to update language'));
      }
    }
  }
}
