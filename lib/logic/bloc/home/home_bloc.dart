import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/data/data_source/base_model.dart';
import 'package:crypto_app/data/models/banner_model.dart';
import 'package:crypto_app/data/models/crypto_model.dart';
import 'package:crypto_app/data/repository/crypto_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/banner_repo.dart';

part 'home_event.dart';

part 'home_state.dart';

enum Market { TopMarketCap, TopLosers, TopGainers }

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CryptoRepo _cryptoRepo;
  final BannerRepo _bannerRepo;

  HomeBloc(this._cryptoRepo, this._bannerRepo)
      : super(HomeState(
            cryptoData: BaseModel.loading(),
            bannerData: BaseModel.loading(),
            marketTypeChoiceIndex: 0)) {
    on<GetMarketEvent>((event, emit) async {
      if (event.showLoading) {
        emit(state.copyWith(cryptoData: BaseModel.loading()));
      }
      try {
        CryptoModel? response;
        switch (event.market) {
          case Market.TopMarketCap:
            response = await _cryptoRepo.getTopMarketCap();
            break;
          case Market.TopGainers:
            response = await _cryptoRepo.getTopGainers();
            break;
          case Market.TopLosers:
            response = await _cryptoRepo.getTopLosers();
            break;
        }
        if (response != null) {
          emit(state.copyWith(cryptoData: BaseModel.success(response)));
        } else {
          emit(state.copyWith(
              cryptoData: BaseModel.failed("something went wrong...")));
        }
      } catch (e) {
        emit(state.copyWith(
            cryptoData: BaseModel.failed("check your connection")));
      }
    });
    on<GetBannersEvent>((event, emit) async {
      emit(state.copyWith(bannerData: BaseModel.loading()));
      try {
        var response = await _bannerRepo.getBanners();
        if (response != null) {
          emit(state.copyWith(bannerData: BaseModel.success(response)));
        } else {
          emit(state.copyWith(
              bannerData: BaseModel.failed("something went wrong...")));
        }
      } catch (e) {
        emit(state.copyWith(
            bannerData: BaseModel.failed("check your connection")));
      }
    });
    on<ChangeMarketTypeEvent>((event, emit) =>
        emit(state.copyWith(marketTypeChoiceIndex: event.index)));
  }
}
