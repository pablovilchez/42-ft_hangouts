import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/di/service_locator.dart';
import 'package:ft_hangouts/core/routes/app_router.dart';
import 'package:ft_hangouts/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:ft_hangouts/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';


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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
