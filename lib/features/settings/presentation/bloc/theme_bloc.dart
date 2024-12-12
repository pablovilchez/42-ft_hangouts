import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.light());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ToggleTheme) {
      yield state.isLightTheme ? ThemeState.dark() : ThemeState.light();
    } else if (event is UpdateColor) {
      yield state.copyWith(primaryColor: event.color);
    }
  }
}

