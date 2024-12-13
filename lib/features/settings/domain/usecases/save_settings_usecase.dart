import 'package:ft_hangouts/features/settings/domain/entities/settings.dart';
import 'package:ft_hangouts/features/settings/domain/repositories/settings_repository.dart';

class SaveSettingsUseCase {
  final SettingsRepository repository;

  SaveSettingsUseCase(this.repository);

  Future<void> call(Settings settings) async {
    await repository.saveSettings(settings);
  }
}
