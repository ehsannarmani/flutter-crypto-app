part of 'crypto_bloc.dart';

class CryptoState {
  BaseModel<CryptoModel> cryptoData;
  BaseModel<List<CandleModel>> candleData;
  BaseModel<List<double>> priceData;
  int timeframeIndex;
  int chartType;

  CryptoState(
      {
        required this.candleData,
        required this.cryptoData,
      required this.priceData,
      required this.timeframeIndex,
      required this.chartType
      });

  CryptoState copyWith(
      {BaseModel<List<CandleModel>>? candleData,
      BaseModel<List<double>>? priceData,
        BaseModel<CryptoModel>? cryptoData,
        int? timeframeIndex,
      int? chartType}) {
    return CryptoState(
        candleData: candleData ?? this.candleData,
        priceData: priceData ?? this.priceData,
        timeframeIndex: timeframeIndex ?? this.timeframeIndex,
        chartType: chartType ?? this.chartType,
    cryptoData: cryptoData ?? this.cryptoData);
  }
}
