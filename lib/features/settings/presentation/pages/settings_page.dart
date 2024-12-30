import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ft_hangouts/core/localization/app_localizations.dart';
import '../bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translate('settings_page_title')),
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
                    title: Text(AppLocalizations.of(context)
                        .translate('settings_dark_mode')),
                    value: state.settings.isDarkMode,
                    activeColor: state.settings.primaryColor,
                    inactiveThumbColor: state.settings.primaryColor,
                    trackOutlineColor: WidgetStateProperty.all(
                        state.settings.primaryColor.withOpacity(0.5)),
                    onChanged: (bool value) {
                      context.read<SettingsBloc>().add(DarkModeChanged());
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Text(AppLocalizations.of(context)
                        .translate('settings_primary_color')),
                    trailing: CircleAvatar(
                      backgroundColor: state.settings.primaryColor,
                    ),
                    onTap: () async {
                      final color = await showColorPickerDialog(
                          context, state.settings.primaryColor);
                      if (color != null) {
                        settingsBloc.add(PrimaryColorChanged(color));
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Language Selector
                  ListTile(
                    title: Text(AppLocalizations.of(context)
                        .translate('settings_language')),
                    subtitle: Text(state.settings.languageCode == 'en'
                        ? 'English'
                        : 'Español'),
                    onTap: () async {
                      final String? newLang = await showLanguageDialog(
                          context, state.settings.languageCode);
                      if (newLang != null) {
                        settingsBloc.add(LanguageChanged(newLang));
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return Center(
              child: Text(
                  AppLocalizations.of(context).translate('error_undefined')));
        },
      ),
    );
  }

  Future<Color?> showColorPickerDialog(
      BuildContext context, Color currentColor) {
    Color selectedColor = currentColor;

    return showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context).translate('settings_pick_color')),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  Text(AppLocalizations.of(context).translate('text_cancel')),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedColor);
              },
              child: Text(AppLocalizations.of(context).translate('text_save')),
            ),
          ],
        );
      },
    );
  }

  Future<String?> showLanguageDialog(
      BuildContext context, String currentLanguage) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context).translate('settings_pick_language')),
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
