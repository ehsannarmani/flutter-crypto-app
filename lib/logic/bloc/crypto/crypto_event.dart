part of 'crypto_bloc.dart';

@immutable
abstract class CryptoEvent {}

class GetCandlesEvent extends CryptoEvent{
  String symbol;
  String interval;
  GetCandlesEvent({required this.symbol, this.interval = "1d"});
}
class GetPricesEvent extends CryptoEvent{
  int id;
  String range;
  GetPricesEvent({required this.id, this.range = "1d"});
}
class UpdateTimeFrameEvent extends CryptoEvent{
  int index;
  UpdateTimeFrameEvent(this.index);
}
class UpdateChartType extends CryptoEvent{
  int index;
  UpdateChartType(this.index);
}
class GetCryptoEvent  extends CryptoEvent{}
class ClearEvent extends CryptoEvent{}

