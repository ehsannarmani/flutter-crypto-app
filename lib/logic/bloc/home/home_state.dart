part of 'home_bloc.dart';

class HomeState {
  final BaseModel<CryptoModel> cryptoData;
  final BaseModel<BannerModel> bannerData;
  final int marketTypeChoiceIndex;

  HomeState(
      {required this.cryptoData, required this.bannerData, required this.marketTypeChoiceIndex});

  HomeState copyWith({BaseModel<CryptoModel>? cryptoData,
    BaseModel<BannerModel>? bannerData,
    int? marketTypeChoiceIndex}) {
    return HomeState(
        cryptoData: cryptoData ?? this.cryptoData,
        bannerData: bannerData ?? this.bannerData,
        marketTypeChoiceIndex: marketTypeChoiceIndex ?? this.marketTypeChoiceIndex
        );
  }
}
