import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/settings_local_datasource.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsLocalDataSource localDataSource;

  SettingsBloc(this.localDataSource) : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LoadSettings) {
      final theme = await localDataSource.loadTheme();
      final color = await localDataSource.loadPrimaryColor();
      final language = await localDataSource.loadLanguage();
      yield SettingsLoaded(theme, color, language);
    } else if (event is UpdateTheme) {
      await localDataSource.saveTheme(event.isLightTheme);
      yield SettingsUpdated();
    } else if (event is UpdatePrimaryColor) {
      await localDataSource.savePrimaryColor(event.color);
      yield SettingsUpdated();
    } else if (event is UpdateLanguage) {
      await localDataSource.saveLanguage(event.languageCode);
      yield SettingsUpdated();
    }
  }
}
