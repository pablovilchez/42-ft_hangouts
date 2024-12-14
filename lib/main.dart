import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/di/service_locator.dart';
import 'package:ft_hangouts/core/localization/app_localizations.dart';
import 'package:ft_hangouts/core/routes/app_router.dart';
import 'package:ft_hangouts/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:ft_hangouts/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider<ContactBloc>(
          create: (context) => ContactBloc(GetIt.instance()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          Locale locale;
          ThemeData themeData;

          if (settingsState is SettingsLoaded) {
            locale = Locale(settingsState.settings.languageCode);
            themeData = ThemeData(
              brightness: settingsState.settings.isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
              primaryColor: settingsState.settings.primaryColor,
              appBarTheme: AppBarTheme(
                backgroundColor: settingsState.settings.primaryColor,
              ),
            );
          } else {
            locale = const Locale('en');
            themeData = ThemeData.light();
          }

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'ft_hangouts',
            theme: themeData,
            routerConfig: appRouter,
            locale: locale,
            supportedLocales: const [
              Locale('en'),
              Locale('es'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}

