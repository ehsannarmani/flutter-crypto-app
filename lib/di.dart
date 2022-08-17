

import 'package:crypto_app/data/data_source/app_api.dart';
import 'package:crypto_app/data/repository/banner_repo.dart';
import 'package:crypto_app/data/repository/crypto_repo.dart';
import 'package:crypto_app/logic/bloc/app/app_bloc.dart';
import 'package:crypto_app/logic/bloc/home/home_bloc.dart';
import 'package:crypto_app/logic/bloc/market/market_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup(){
  // api
  locator.registerSingleton(AppApi());

  // repositories
  locator.registerSingleton(CryptoRepo(locator()));
  locator.registerSingleton(BannerRepo(locator()));

  //bloc's
  locator.registerSingleton(AppBloc());
  locator.registerSingleton(HomeBloc(locator(),locator()));
  locator.registerSingleton(MarketBloc(locator()));
}