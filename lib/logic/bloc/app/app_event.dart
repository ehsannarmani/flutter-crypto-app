part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class UpdateBottomBarEvent extends AppEvent{
  final int index;
  UpdateBottomBarEvent(this.index);
}
class UpdateAppThemeEvent extends AppEvent{
}
