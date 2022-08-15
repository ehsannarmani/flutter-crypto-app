
import '../models/crypto_model.dart';
import '../data_source/app_api.dart';

class CryptoRepo{

  final AppApi _api = AppApi();

  Future<CryptoModel?> getTopMarketCap({int count = 10,int start = 1}) async{
    var result = await _api.getTopMarketCap(count: count,start: start);
    return result.statusCode == 200 ? CryptoModel.fromJson(result.data) : null;
  }
  Future<CryptoModel?> getTopGainers() async{
    var result = await _api.getTopGainers();
    return result.statusCode == 200 ? CryptoModel.fromJson(result.data) : null;
  }
  Future<CryptoModel?> getTopLosers() async{
    var result = await _api.getTopLosers();
    return result.statusCode == 200 ? CryptoModel.fromJson(result.data) : null;
  }
}