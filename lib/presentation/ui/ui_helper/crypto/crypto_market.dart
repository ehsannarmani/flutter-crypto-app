import 'dart:io';

import 'package:crypto_app/logic/bloc/home/home_bloc.dart';
import 'package:crypto_app/presentation/ui/pages/crypto_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../data/data_source/base_model.dart';
import '../../../../data/models/crypto_model.dart';

import '../../../../di.dart';
import '../../../../logic/bloc/crypto/crypto_bloc.dart';
import 'crypto_shimmer.dart';
import 'crypto.dart';

class CryptoMarket extends StatefulWidget {
  const CryptoMarket({Key? key}) : super(key: key);

  @override
  State<CryptoMarket> createState() => _CryptoMarketState();
}

class _CryptoMarketState extends State<CryptoMarket> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context)
        .add(GetMarketEvent(market: Market.TopMarketCap));
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      HomeBloc homeBloc = BlocProvider.of(context);
      int marketTypeChoiceIndex = homeBloc.state.marketTypeChoiceIndex;
      switch (marketTypeChoiceIndex) {
        case 0:
          homeBloc.add(GetMarketEvent(market: Market.TopMarketCap,showLoading: false));
          break;
        case 1:
          homeBloc.add(GetMarketEvent(market: Market.TopGainers,showLoading: false));
          break;
        case 2:
          homeBloc.add(GetMarketEvent(market: Market.TopLosers,showLoading: false));
          break;
      }
    }

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (preState,newState){
        return preState.cryptoData != newState.cryptoData;
      },
      builder: (context, state) {
        BaseModel<CryptoModel> cryptoData = state.cryptoData;
        switch (cryptoData.status) {
          case ResponseStatus.Loading:
            return CryptoShimmer();
          case ResponseStatus.Success:
            return RefreshIndicator(
              onRefresh: onRefresh,
              backgroundColor: Theme.of(context).primaryColorDark,
              color: Colors.white,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cryptoData.data.data.cryptoCurrencyList.length,
                itemBuilder: (context, index) {
                  CryptoCurrencyList crypto =
                      cryptoData.data.data.cryptoCurrencyList[index];
                  return Crypto(crypto: crypto,onTap: (){
                    CryptoPage.navigate(context, crypto);
                  },);
                },
              ),
            );
          case ResponseStatus.Failed:
            return const Text("Failed...");
        }
      },
    );
  }
}
