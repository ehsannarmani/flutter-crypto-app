import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/presentation/ui/app.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(bottomBarIndex: 0, darkModeEnabled: SchedulerBinding.instance!.window.platformBrightness == Brightness.dark)) {
    on<UpdateBottomBarEvent>((event, emit) => emit(state.copyWith(bottomBarIndex: event.index)));
    on<UpdateAppThemeEvent>((event, emit) => emit(state.copyWith(darkModeEnabled: !state.darkModeEnabled)));
  }
}
