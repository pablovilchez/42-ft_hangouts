import 'package:ft_hangouts/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:ft_hangouts/features/settings/data/models/settings_model.dart';
import 'package:ft_hangouts/features/settings/domain/entities/settings.dart';
import 'package:ft_hangouts/features/settings/domain/repositories/settings_repository.dart';


class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Settings> getSettings() async {
    return await localDataSource.getSettings();
  }

  @override
  Future<void> saveSettings(Settings settings) {
    final settingsModel = SettingsModel.fromEntity(settings);
    return localDataSource.saveSettings(settings: settingsModel);
  }
}