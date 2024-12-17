import 'package:ft_hangouts/features/contacts/domain/repositories/contact_repository.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/delete_contact_usecase.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/update_contact_usecase.dart';
import 'package:ft_hangouts/features/settings/domain/repositories/settings_repository.dart';
import 'package:ft_hangouts/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:ft_hangouts/features/settings/domain/usecases/save_settings_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:ft_hangouts/features/contacts/data/datasources/contact_local_datasource.dart';
import 'package:ft_hangouts/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:ft_hangouts/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:ft_hangouts/features/contacts/data/repositories/contact_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setDi() {
  // Datasources
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(),
  );
  getIt.registerLazySingleton<ContactLocalDataSource>(
    () => ContactLocalDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
        localDataSource: getIt<SettingsLocalDataSource>()),
  );
  getIt.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(
        contactDataSource: getIt<ContactLocalDataSource>()),
  );

  // Settings Usecases
  getIt.registerLazySingleton<GetSettingsUseCase>(
    () => GetSettingsUseCase(getIt<SettingsRepository>()),
  );
  getIt.registerLazySingleton<SaveSettingsUseCase>(
    () => SaveSettingsUseCase(getIt<SettingsRepository>()),
  );

  // Contacts Usecases
  getIt.registerLazySingleton<AddContactUseCase>(
    () => AddContactUseCase(getIt<ContactRepository>()),
  );
  getIt.registerLazySingleton<DeleteContactUseCase>(
    () => DeleteContactUseCase(getIt<ContactRepository>()),
  );
  getIt.registerLazySingleton<GetContactsUseCase>(
    () => GetContactsUseCase(getIt<ContactRepository>()),
  );
  getIt.registerLazySingleton<UpdateContactUseCase>(
    () => UpdateContactUseCase(getIt<ContactRepository>()),
  );
}
