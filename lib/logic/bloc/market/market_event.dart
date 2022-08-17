part of 'market_bloc.dart';

@immutable
abstract class MarketEvent {}

class GetMarketEvent extends MarketEvent{
  int count;
  GetMarketEvent({this.count = 500});
}
class UpdateChoiceEvent extends MarketEvent{
  int index;
  UpdateChoiceEvent({required this.index});
}
