
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/data_source/base_model.dart';
import '../../data/models/crypto_model.dart';
import '../../data/repository/crypto_repo.dart';

class MarketPageProvider extends ChangeNotifier{
  BaseModel<CryptoModel>? data;
  final CryptoRepo _cryptoRepo = CryptoRepo();
  int startList = 1;


  void getMarketCap({bool forceShowLoading = false}) async{
    if(data?.status != ResponseStatus.Success || forceShowLoading){
      data = BaseModel.loading("Loading...");
    }
    try{
      var response = await _cryptoRepo.getTopMarketCap(count: 2000,start: startList);
      if(response != null){
        data = BaseModel.success(response);
      }else{
        data = BaseModel.failed("something went wrong...");
      }
    }catch(e){
      data = BaseModel.failed("check your connection...");
    }
    notifyListeners();
  }
}