part of 'app_bloc.dart';

class AppState{
  final int bottomBarIndex;
  final bool darkModeEnabled;
  AppState({required this.bottomBarIndex,required this.darkModeEnabled});

  AppState copyWith({int? bottomBarIndex,bool? darkModeEnabled}){
    return AppState(bottomBarIndex: bottomBarIndex ?? this.bottomBarIndex,darkModeEnabled: darkModeEnabled?? this.darkModeEnabled);
  }
}
