import 'package:dio/dio.dart';

class AppApi{

  dynamic getTopMarketCap({int count = 10,int start = 1}) async{
    var response  = await Dio().get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=$start&limit=$count&sortBy=market_cap&sortType=desc&convert=USD,BTC,ETH&cryptoType=coins&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
    return response;
  }
  dynamic getTopGainers() async{
    var response  = await Dio().get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=desc&convert=USD,BTC,ETH&cryptoType=coins&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
    return response;
  }
  dynamic getTopLosers() async{
    var response  = await Dio().get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=asc&convert=USD,BTC,ETH&cryptoType=coins&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
    return response;
  }
  
  dynamic getBanners() async{
    var response = await Dio().get("https://www.coinex.zone/res/activity/banners");
    return response;
  }
}