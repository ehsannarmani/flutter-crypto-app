class BannerModel {
  BannerModel({
    required this.code,
    required this.data,
    required this.message,
  });
  late final int code;
  late final List<Data> data;
  late final String message;

  BannerModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.sortId,
    required this.bannerId,
    required this.name,
    required this.platform,
    required this.param,
    required this.imgSrc,
    required this.imgSrcBig,
  });
  late final int sortId;
  late final int bannerId;
  late final String name;
  late final String platform;
  late final Param param;
  late final String imgSrc;
  late final String imgSrcBig;

  Data.fromJson(Map<String, dynamic> json){
    sortId = json['sort_id'];
    bannerId = json['banner_id'];
    name = json['name'];
    platform = json['platform'];
    param = Param.fromJson(json['param']);
    imgSrc = json['img_src'];
    imgSrcBig = json['img_src_big'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort_id'] = sortId;
    _data['banner_id'] = bannerId;
    _data['name'] = name;
    _data['platform'] = platform;
    _data['param'] = param.toJson();
    _data['img_src'] = imgSrc;
    _data['img_src_big'] = imgSrcBig;
    return _data;
  }
}

class Param {
  Param({
    required this.actionType,
    required this.link,
  });
  late final String actionType;
  late final String link;

  Param.fromJson(Map<String, dynamic> json){
    actionType = json['action_type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['action_type'] = actionType;
    _data['link'] = link;
    return _data;
  }
}