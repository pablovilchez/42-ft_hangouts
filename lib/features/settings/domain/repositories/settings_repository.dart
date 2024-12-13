import 'package:ft_hangouts/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Settings> getSettings();
  Future<void> saveSettings(Settings settings);
}