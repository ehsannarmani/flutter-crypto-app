part of 'market_bloc.dart';

class MarketState {
  int activeChoice;
  BaseModel<CryptoModel> cryptoData;

  MarketState({required this.cryptoData, required this.activeChoice});

  MarketState copyWith(
      {BaseModel<CryptoModel>? cryptoData, int? activeChoice}) {
    return MarketState(
        cryptoData: cryptoData ?? this.cryptoData,
        activeChoice: activeChoice ?? this.activeChoice);
  }
}
