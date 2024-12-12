import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData themeData;
  final bool isLightTheme;

  ThemeState._(this.themeData, this.isLightTheme);

  factory ThemeState.light() {
    return ThemeState._(
      ThemeData.light().copyWith(
        primaryColor: Colors.blue,
      ),
      true,
    );
  }

  factory ThemeState.dark() {
    return ThemeState._(
      ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
      ),
      false,
    );
  }

  ThemeState copyWith({required Color primaryColor}) {
    return ThemeState._(
      themeData.copyWith(primaryColor: primaryColor),
      isLightTheme,
    );
  }
}
