import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/data/data_source/base_model.dart';
import 'package:crypto_app/data/models/candle_model.dart';
import 'package:crypto_app/data/models/crypto_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/crypto_repo.dart';

part 'crypto_event.dart';

part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoRepo _cryptoRepo;

  CryptoBloc(this._cryptoRepo)
      : super(CryptoState(
            candleData: BaseModel.loading(),
            priceData: BaseModel.loading(),
            cryptoData: BaseModel.loading(),
            timeframeIndex: 2,
  chartType: 0)) {
    on<GetCandlesEvent>((event, emit) async {
      emit(state.copyWith(candleData: BaseModel.loading()));
      try {
        var result = await _cryptoRepo.getCandles(
            symbol: event.symbol, interval: event.interval);
        if (result != null) {
          emit(state.copyWith(candleData: BaseModel.success(result)));
        } else {
          emit(state.copyWith(
              candleData: BaseModel.failed("Something went wrong...")));
        }
      } catch (e) {
        emit(state.copyWith(
            candleData: BaseModel.failed("Check your connection...")));
      }
    });
    on<GetPricesEvent>((event, emit) async {
      emit(state.copyWith(priceData: BaseModel.loading()));
      try {
        var result =
            await _cryptoRepo.getPrices(id: event.id, range: event.range);
        if (result != null) {
          emit(state.copyWith(priceData: BaseModel.success(result)));
        } else {
          emit(state.copyWith(
              priceData: BaseModel.failed("Something went wrong...")));
        }
      } catch (e) {
        emit(state.copyWith(
            priceData: BaseModel.failed("Check your connection...")));
      }
    });
    on<UpdateTimeFrameEvent>(
        (event, emit) => emit(state.copyWith(timeframeIndex: event.index)));
    on<UpdateChartType>((event, emit) => emit(state.copyWith(chartType: event.index)));
    on<GetCryptoEvent>((event, emit) async{
      emit(state.copyWith(cryptoData: BaseModel.loading()));
      try{
        var result = await _cryptoRepo.getTopMarketCap(count: 50);
        if(result != null){
          List<CryptoCurrencyList> finalResult = [];
          for(int i =0;i<11;i++){
            Random random = Random();
            int randomIndex = random.nextInt(result.data.cryptoCurrencyList.length-1);
            finalResult.add(result.data.cryptoCurrencyList[randomIndex]);
          }
          emit(state.copyWith(cryptoData: BaseModel.success(CryptoModel(data: Data(cryptoCurrencyList: finalResult,totalCount: ""),status: Status(timestamp: "",errorCode: "",errorMessage: "",elapsed: "",creditCount: 0),))));
        }else {
          emit(state.copyWith(
              cryptoData: BaseModel.failed("Something went wrong...")));
        }
      }catch(e){
        emit(state.copyWith(
            cryptoData: BaseModel.failed("Check your connection...")));
      }
    });
    on<ClearEvent>((event, emit) {
      emit(CryptoState(
          candleData: BaseModel.loading(),
          priceData: BaseModel.loading(),
          cryptoData: BaseModel.loading(),
          timeframeIndex: 2,
      chartType: 0));
    });
  }
}
