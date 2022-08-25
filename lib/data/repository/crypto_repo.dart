
import 'package:crypto_app/data/models/candle_model.dart';

import '../models/crypto_model.dart';
import '../data_source/app_api.dart';

class CryptoRepo{

  final AppApi _api;
  CryptoRepo(this._api);

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
  Future<List<CandleModel>?> getCandles({required String symbol,String interval = "1d"}) async{
    var result = await _api.getCandles(symbol: symbol,interval: interval.toLowerCase());
    if(result.statusCode == 200){
      var data = result.data as List<dynamic>;

      return data.map((element) {
         return CandleModel(
            date: DateTime.fromMicrosecondsSinceEpoch(element[0]),
            high: double.parse(element[2]),
            low: double.parse(element[3]),
            open: double.parse(element[1]),
            close: double.parse(element[4]),
            volume: double.parse(element[5])
        );
      }).toList();
    }else{
      return null;
    }
  }

  Future<List<double>?> getPrices({required int id,String range = "1D"}) async{
    var result = await _api.getPrices(id, range == "1W" ? "7d" : range);
    if(result.statusCode == 200){
      var data = result.data as Map<String, dynamic>;
      var points = data["data"]["points"] as Map<String, dynamic>;
      List<double> res=[];
      points.forEach((key, value) {
        res.add(value["v"][0]);
      });
      var orgRes = res;
      if(range != "1H"){
        // if(range == "1M"){
        //   res = removeBy(2,8, res);
        // }else if(range == "7d"){
        //   res = removeBy(2,10, res);
        // }else if(range == "1D"){
        //   res = removeBy(2,4, res);
        // }
        res = removeBy(2,8, res);

        res.add(orgRes.last);
      }
      return res.toList();
    }else{
      return null;
    }
  }

  List<double> removeBy(int num,int repeat,List<double> list){
    var res = list;
    var removeIndex = 1;
    List.generate(res.length~/2, (index){
      if(index==removeIndex){
        try{
          res.removeAt(index);
        }catch(e){}
        removeIndex+=2;
      }
    });
    if(repeat > 1){
      removeBy(num, repeat-1, list);
    }
    return res;
  }
}