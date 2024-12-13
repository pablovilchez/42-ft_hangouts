import 'package:ft_hangouts/features/settings/domain/entities/settings.dart';

class SettingsModel extends Settings {
  SettingsModel({
    required super.isDarkMode,
    required super.primaryColor,
    required super.languageCode,
  });
  
  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
      isDarkMode: settings.isDarkMode,
      primaryColor: settings.primaryColor,
      languageCode: settings.languageCode,
    );
  }

  Settings toEntity() {
    return Settings(
      isDarkMode: isDarkMode,
      primaryColor: primaryColor,
      languageCode: languageCode,
    );
  }
}
