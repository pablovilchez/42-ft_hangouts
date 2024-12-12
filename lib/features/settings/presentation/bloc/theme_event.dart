import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class UpdateColor extends ThemeEvent {
  final Color color;

  UpdateColor(this.color);
}
