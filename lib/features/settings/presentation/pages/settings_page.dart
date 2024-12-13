import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SettingsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: const Text('Bright Mode'),
                    value: state.settings.isDarkMode,
                    onChanged: (bool value) {
                      context.read<SettingsBloc>().add(DarkModeChanged());
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Primary Color'),
                    trailing: CircleAvatar(
                      backgroundColor: state.settings.primaryColor,
                    ),
                    onTap: () async {
                      final color = await showColorPickerDialog(context, state.settings.primaryColor);
                      if (color != null) {
                        context.read<SettingsBloc>().add(PrimaryColorChanged(color));
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Language Selector
                  ListTile(
                    title: const Text('Language'),
                    subtitle: Text(state.settings.languageCode == 'en' ? 'English' : 'Español'),
                    onTap: () async {
                      final String? newLang = await showLanguageDialog(context, state.settings.languageCode);
                      if (newLang != null) {
                        context.read<SettingsBloc>().add(LanguageChanged(newLang));
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Future<Color?> showColorPickerDialog(BuildContext context, Color currentColor) {
    return showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {},
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(currentColor);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(currentColor);
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  Future<String?> showLanguageDialog(BuildContext context, String currentLanguage) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () => Navigator.of(context).pop('en'),
              ),
              ListTile(
                title: const Text('Español'),
                onTap: () => Navigator.of(context).pop('es'),
              ),
            ],
          ),
        );
      },
    );
  }
}
