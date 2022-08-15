import 'dart:io';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/data_source/base_model.dart';
import '../../../../data/models/crypto_model.dart';
import '../../../../logic/providers/crypto_api_provider.dart';


import '../../../../logic/providers/home_choices_provider.dart';
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
    CryptoApiProvider cryptoApiProvider = Provider.of(context, listen: false);
    cryptoApiProvider.getMarket();
  }

  @override
  Widget build(BuildContext context) {
    CryptoApiProvider cryptoApiProvider = Provider.of(context);
    HomeChoicesProvider homeChoicesProvider = Provider.of(context);
    Future<void> onRefresh()async {
      switch(homeChoicesProvider.selectedChoice){
        case 0:
         await cryptoApiProvider.getMarket(
              forceShowLoading: true,
              market: Market.TopMarketCap
          );
          break;
        case 1:
          await cryptoApiProvider.getMarket(
              forceShowLoading: true,
              market: Market.TopGainers
          );
          break;
        case 2:
          await cryptoApiProvider.getMarket(
              forceShowLoading: true,
              market: Market.TopLosers
          );
          break;
      }
    }
    return Consumer<CryptoApiProvider>(
      builder: (context, provider, child) {
        switch (provider.topMarketCap?.status) {
          case ResponseStatus.Loading: return CryptoShimmer();
          case ResponseStatus.Success:
            return RefreshIndicator(
              onRefresh: onRefresh,
              backgroundColor: Theme.of(context).primaryColorDark,
              color: Colors.white,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: provider
                    .topMarketCap!.data.data.cryptoCurrencyList.length,
                itemBuilder: (context, index) {
                  CryptoCurrencyList crypto = provider.topMarketCap
                      !.data.data.cryptoCurrencyList[index];
                  return Crypto(crypto: crypto);
                },
              ),
            );
          case ResponseStatus.Failed: return const Text("Failed...");
          default: return Container();
        }
      },
    );
  }
}
