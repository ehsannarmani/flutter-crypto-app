
import 'package:flutter/cupertino.dart';

import '../../data/data_source/base_model.dart';
import '../../data/models/banner_model.dart';
import '../../data/repository/banner_repo.dart';

class BannerApiProvider extends ChangeNotifier{
  BaseModel<BannerModel>? data;
  final BannerRepo _bannerRepo = BannerRepo();

  void getBanners() async{
    if(data?.status != ResponseStatus.Success){
      data = BaseModel.loading("Loading...");
    }
    var response = await _bannerRepo.getBanners();
    try{
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