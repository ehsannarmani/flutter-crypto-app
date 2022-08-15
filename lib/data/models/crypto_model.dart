class CryptoModel {
  CryptoModel({
    required this.data,
    required this.status,
  });
  late final Data data;
  late final Status status;

  CryptoModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    status = Status.fromJson(json['status']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['status'] = status.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.cryptoCurrencyList,
    required this.totalCount,
  });
  late final List<CryptoCurrencyList> cryptoCurrencyList;
  late final String totalCount;

  Data.fromJson(Map<String, dynamic> json){
    cryptoCurrencyList = List.from(json['cryptoCurrencyList']).map((e)=>CryptoCurrencyList.fromJson(e)).toList();
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cryptoCurrencyList'] = cryptoCurrencyList.map((e)=>e.toJson()).toList();
    _data['totalCount'] = totalCount;
    return _data;
  }
}

class CryptoCurrencyList {
  CryptoCurrencyList({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.cmcRank,
    required this.marketPairCount,
    required this.circulatingSupply,
    required this.selfReportedCirculatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.atl,
    required this.high24h,
    required this.low24h,
    required this.isActive,
    required this.lastUpdated,
    required this.dateAdded,
    required this.quotes,
    required this.isAudited,
  });
  late final int id;
  late final String name;
  late final String symbol;
  late final String slug;
  late final int cmcRank;
  late final int marketPairCount;
  late final double? circulatingSupply;
  late final double? selfReportedCirculatingSupply;
  late final double? totalSupply;
  late final double? maxSupply;
  late final double ath;
  late final double atl;
  late final double high24h;
  late final double? low24h;
  late final int? isActive;
  late final String lastUpdated;
  late final String dateAdded;
  late final List<Quotes> quotes;
  late final bool isAudited;

  CryptoCurrencyList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    cmcRank = json['cmcRank'];
    marketPairCount = json['marketPairCount'];
    circulatingSupply = json['circulatingSupply'];
    selfReportedCirculatingSupply = json['selfReportedCirculatingSupply']?.toDouble();
    totalSupply = json['totalSupply'];
    maxSupply = json['maxSupply']?.toDouble();
    ath = json['ath'];
    atl = json['atl'];
    high24h = json['high24h'];
    low24h = json['low24h'];
    isActive = json['isActive'];
    lastUpdated = json['lastUpdated'];
    dateAdded = json['dateAdded'];
    if (json['quotes'] != null) {
      quotes = [];
      json['quotes'].forEach((v) {
        quotes.add(Quotes.fromJson(v));
      });
    }
    isAudited = json['isAudited'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['symbol'] = symbol;
    _data['slug'] = slug;
    _data['cmcRank'] = cmcRank;
    _data['marketPairCount'] = marketPairCount;
    _data['circulatingSupply'] = circulatingSupply;
    _data['selfReportedCirculatingSupply'] = selfReportedCirculatingSupply;
    _data['totalSupply'] = totalSupply;
    _data['maxSupply'] = maxSupply;
    _data['ath'] = ath;
    _data['atl'] = atl;
    _data['high24h'] = high24h;
    _data['low24h'] = low24h;
    _data['isActive'] = isActive;
    _data['lastUpdated'] = lastUpdated;
    _data['dateAdded'] = dateAdded;
    _data['quotes'] = quotes;
    _data['isAudited'] = isAudited;
    return _data;
  }
}

class DateAdded {
  DateAdded({
    required this.name,
    required this.price,
    required this.volume24h,
    required this.volume7d,
    required this.volume30d,
    required this.marketCap,
    required this.selfReportedMarketCap,
    required this.percentChange1h,
    required this.percentChange24h,
    required this.percentChange7d,
    required this.lastUpdated,
    required this.percentChange30d,
    required this.percentChange60d,
    required this.percentChange90d,
    required this.fullyDilluttedMarketCap,
    required this.marketCapByTotalSupply,
    required this.dominance,
    required this.turnover,
    required this.ytdPriceChangePercentage,
  });
  late final String name;
  late final double? price;
  late final double volume24h;
  late final double volume7d;
  late final double volume30d;
  late final double marketCap;
  late final int selfReportedMarketCap;
  late final double? percentChange1h;
  late final double? percentChange24h;
  late final double? percentChange7d;
  late final String lastUpdated;
  late final double? percentChange30d;
  late final double? percentChange60d;
  late final double? percentChange90d;
  late final double fullyDilluttedMarketCap;
  late final double marketCapByTotalSupply;
  late final double dominance;
  late final double turnover;
  late final double ytdPriceChangePercentage;

  DateAdded.fromJson(Map<String, dynamic> json){
    name = json['name'];
    price = json['price'];
    volume24h = json['volume24h'];
    volume7d = json['volume7d'];
    volume30d = json['volume30d'];
    marketCap = json['marketCap'];
    selfReportedMarketCap = json['selfReportedMarketCap'];
    percentChange1h = json['percentChange1h'];
    percentChange24h = json['percentChange24h'];
    percentChange7d = json['percentChange7d'];
    lastUpdated = json['lastUpdated'];
    percentChange30d = json['percentChange30d'];
    percentChange60d = json['percentChange60d'];
    percentChange90d = json['percentChange90d'];
    fullyDilluttedMarketCap = json['fullyDilluttedMarketCap'];
    marketCapByTotalSupply = json['marketCapByTotalSupply'];
    dominance = json['dominance'];
    turnover = json['turnover'];
    ytdPriceChangePercentage = json['ytdPriceChangePercentage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['price'] = price;
    _data['volume24h'] = volume24h;
    _data['volume7d'] = volume7d;
    _data['volume30d'] = volume30d;
    _data['marketCap'] = marketCap;
    _data['selfReportedMarketCap'] = selfReportedMarketCap;
    _data['percentChange1h'] = percentChange1h;
    _data['percentChange24h'] = percentChange24h;
    _data['percentChange7d'] = percentChange7d;
    _data['lastUpdated'] = lastUpdated;
    _data['percentChange30d'] = percentChange30d;
    _data['percentChange60d'] = percentChange60d;
    _data['percentChange90d'] = percentChange90d;
    _data['fullyDilluttedMarketCap'] = fullyDilluttedMarketCap;
    _data['marketCapByTotalSupply'] = marketCapByTotalSupply;
    _data['dominance'] = dominance;
    _data['turnover'] = turnover;
    _data['ytdPriceChangePercentage'] = ytdPriceChangePercentage;
    return _data;
  }
}

class Quotes {
  Quotes({
    required this.name,
    required this.price,
    required this.volume24h,
    required this.volume7d,
    required this.volume30d,
    required this.marketCap,
    required this.selfReportedMarketCap,
    required this.percentChange1h,
    required this.percentChange24h,
    required this.percentChange7d,
    required this.lastUpdated,
    required this.percentChange30d,
    required this.percentChange60d,
    required this.percentChange90d,
    required this.fullyDilluttedMarketCap,
    required this.marketCapByTotalSupply,
    required this.dominance,
    required this.turnover,
    required this.ytdPriceChangePercentage,
  });
  late final String name;
  late final double? price;
  late final double volume24h;
  late final double volume7d;
  late final double volume30d;
  late final double? marketCap;
  late final double selfReportedMarketCap;
  late final double? percentChange1h;
  late final double? percentChange24h;
  late final double? percentChange7d;
  late final String lastUpdated;
  late final double? percentChange30d;
  late final double? percentChange60d;
  late final double? percentChange90d;
  late final double fullyDilluttedMarketCap;
  late final double? marketCapByTotalSupply;
  late final double dominance;
  late final double? turnover;
  late final double ytdPriceChangePercentage;

  Quotes.fromJson(Map<String, dynamic> json){
    name = json['name'];
    price = json['price'].toDouble();
    volume24h = json['volume24h'];
    volume7d = json['volume7d'];
    volume30d = json['volume30d'];
    marketCap = json['marketCap'].toDouble();
    selfReportedMarketCap = json['selfReportedMarketCap'];
    percentChange1h = json['percentChange1h'].toDouble();
    percentChange24h = json['percentChange24h'].toDouble();
    percentChange7d = json['percentChange7d'].toDouble();
    lastUpdated = json['lastUpdated'];
    percentChange30d = json['percentChange30d'].toDouble();
    percentChange60d = json['percentChange60d'].toDouble();
    percentChange90d = json['percentChange90d'].toDouble();
    fullyDilluttedMarketCap = json['fullyDilluttedMarketCap'];
    marketCapByTotalSupply = json['marketCapByTotalSupply'];
    dominance = json['dominance'];
    turnover = json['turnover'];
    ytdPriceChangePercentage = json['ytdPriceChangePercentage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['price'] = price;
    _data['volume24h'] = volume24h;
    _data['volume7d'] = volume7d;
    _data['volume30d'] = volume30d;
    _data['marketCap'] = marketCap;
    _data['selfReportedMarketCap'] = selfReportedMarketCap;
    _data['percentChange1h'] = percentChange1h;
    _data['percentChange24h'] = percentChange24h;
    _data['percentChange7d'] = percentChange7d;
    _data['lastUpdated'] = lastUpdated;
    _data['percentChange30d'] = percentChange30d;
    _data['percentChange60d'] = percentChange60d;
    _data['percentChange90d'] = percentChange90d;
    _data['fullyDilluttedMarketCap'] = fullyDilluttedMarketCap;
    _data['marketCapByTotalSupply'] = marketCapByTotalSupply;
    _data['dominance'] = dominance;
    _data['turnover'] = turnover;
    _data['ytdPriceChangePercentage'] = ytdPriceChangePercentage;
    return _data;
  }
}

class IsAudited {
  IsAudited({
    required this.coinId,
    required this.auditor,
    required this.auditStatus,
    required this.reportUrl,
  });
  late final String coinId;
  late final String auditor;
  late final int auditStatus;
  late final String reportUrl;

  IsAudited.fromJson(Map<String, dynamic> json){
    coinId = json['coinId'];
    auditor = json['auditor'];
    auditStatus = json['auditStatus'];
    reportUrl = json['reportUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coinId'] = coinId;
    _data['auditor'] = auditor;
    _data['auditStatus'] = auditStatus;
    _data['reportUrl'] = reportUrl;
    return _data;
  }
}

class Status {
  Status({
    required this.timestamp,
    required this.errorCode,
    required this.errorMessage,
    required this.elapsed,
    required this.creditCount,
  });
  late final String timestamp;
  late final String errorCode;
  late final String errorMessage;
  late final String elapsed;
  late final int creditCount;

  Status.fromJson(Map<String, dynamic> json){
    timestamp = json['timestamp'];
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
    elapsed = json['elapsed'];
    creditCount = json['credit_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timestamp'] = timestamp;
    _data['error_code'] = errorCode;
    _data['error_message'] = errorMessage;
    _data['elapsed'] = elapsed;
    _data['credit_count'] = creditCount;
    return _data;
  }
}