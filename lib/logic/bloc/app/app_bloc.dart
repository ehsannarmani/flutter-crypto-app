import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/presentation/ui/app.dart';
import 'package:crypto_app/presentation/utils/constants.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(bottomBarIndex: 0, darkModeEnabled: false)) {
    on<UpdateBottomBarEvent>((event, emit) => emit(state.copyWith(bottomBarIndex: event.index)));
    on<UpdateAppThemeEvent>((event, emit) async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      bool value = event.darkMode ?? !state.darkModeEnabled;
      sharedPreferences.setBool(Constants.DARK_MODE_ENABLED, value);
      emit(state.copyWith(darkModeEnabled: value));
    });
  }
}
