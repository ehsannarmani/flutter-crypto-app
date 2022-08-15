
import 'package:flutter/cupertino.dart';

import '../../data/data_source/base_model.dart';
import '../../data/models/crypto_model.dart';
import '../../data/repository/crypto_repo.dart';

enum Market { TopMarketCap, TopLosers, TopGainers }

class CryptoApiProvider extends ChangeNotifier {
  final CryptoRepo _cryptoRepo = CryptoRepo();

  BaseModel<CryptoModel>? topMarketCap;

  Future<void> getMarket(
      {bool refresh = false,
      bool forceShowLoading = false,
      Market market = Market.TopMarketCap}) async {
    topMarketCap = BaseModel.loading("Loading...");
    try {
      var response;
      switch (market) {
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
        topMarketCap = BaseModel.success(response);
      } else {
        topMarketCap = BaseModel.failed("something went wrong...");
      }
    } catch (e) {
      topMarketCap = BaseModel.failed("check your connection..., $e");
    }
    notifyListeners();
  }
}
