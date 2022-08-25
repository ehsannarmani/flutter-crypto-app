import 'package:dio/dio.dart';

class AppApi{

  Dio _dio;
  AppApi(this._dio);

  dynamic getTopMarketCap({int count = 10,int start = 1}) async{
    var response  = await _dio.get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=$start&limit=$count&sortBy=market_cap&sortType=desc&convert=USD,BTC,ETH&cryptoType=coins&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
    return response;
  }
  dynamic getTopGainers() async{
    var response  = await _dio.get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=desc&convert=USD,BTC,ETH&cryptoType=coins&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
    return response;
  }
  dynamic getTopLosers() async{
    var response  = await _dio.get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=asc&convert=USD,BTC,ETH&cryptoType=coins&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
    return response;
  }
  
  dynamic getBanners() async{
    var response = await _dio.get("https://www.coinex.zone/res/activity/banners");
    return response;
  }

  dynamic getCandles({required String symbol,String interval = "1d"}) async{
    var response = await _dio.get("https://www.binance.com/api/v3/uiKlines?limit=52&symbol=${symbol}BUSD&interval=$interval");
    return response;
  }
  dynamic getPrices(int id,String range) async{
    var response = await _dio.get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/detail/chart?id=$id&range=$range");
    return response;
  }
}