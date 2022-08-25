import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/data/data_source/base_model.dart';
import 'package:crypto_app/data/models/crypto_model.dart';
import 'package:crypto_app/data/repository/crypto_repo.dart';
import 'package:meta/meta.dart';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final CryptoRepo _cryptoRepo;
  MarketBloc(this._cryptoRepo) : super(MarketState(cryptoData: BaseModel.loading(),activeChoice: 0)) {
    on<GetMarketEvent>((event, emit) async {
      if(!event.refresh){
        emit(state.copyWith(cryptoData: BaseModel.loading()));
      }
      try{
        var response = await _cryptoRepo.getTopMarketCap(count: event.count);
        if(response != null){
          emit(state.copyWith(cryptoData: BaseModel.success(response)));
        }else{
          emit(state.copyWith(cryptoData: BaseModel.failed("Something went wrong...")));
        }
      }catch(e){
        emit(state.copyWith(cryptoData: BaseModel.failed("Check your connection")));
      }
    });
    on<UpdateChoiceEvent>((event, emit) => emit(state.copyWith(activeChoice: event.index)));
  }
}
