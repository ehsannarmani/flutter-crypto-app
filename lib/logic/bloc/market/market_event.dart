part of 'market_bloc.dart';

@immutable
abstract class MarketEvent {}

class GetMarketEvent extends MarketEvent{
  int count;
  bool refresh;
  GetMarketEvent({this.count = 500,this.refresh = false});
}
class UpdateChoiceEvent extends MarketEvent{
  int index;
  UpdateChoiceEvent({required this.index});
}
