part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetMarketEvent extends HomeEvent{
  final Market market;
  final bool showLoading;
  GetMarketEvent({required this.market,this.showLoading = true});
}
class GetBannersEvent extends HomeEvent{}
class ChangeMarketTypeEvent extends HomeEvent{
  final int index;
  ChangeMarketTypeEvent({required this.index});
}

