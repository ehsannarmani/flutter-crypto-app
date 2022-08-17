import '../data_source/app_api.dart';
import '../models/banner_model.dart';

class BannerRepo{
  final AppApi _api;
  BannerRepo(this._api);
  Future<BannerModel?> getBanners() async{
    var result =  await _api.getBanners();
    return result.statusCode == 200 ? BannerModel.fromJson(result.data) : null;
  }
}