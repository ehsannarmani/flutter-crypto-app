import 'dart:async';


import 'package:crypto_app/logic/bloc/market/market_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../data/data_source/base_model.dart';
import '../../../data/models/crypto_model.dart';
import '../../../di.dart';
import '../../../logic/bloc/crypto/crypto_bloc.dart';
import '../ui_helper/crypto/crypto.dart';
import '../ui_helper/crypto/crypto_shimmer.dart';
import 'crypto_page.dart';

class CurrencyChoice {
  String currency;
  String avatar;

  CurrencyChoice({required this.currency, required this.avatar});
}

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {


  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MarketBloc marketBloc = BlocProvider.of<MarketBloc>(context);

    marketBloc.add(GetMarketEvent());
    Timer.periodic(const Duration(seconds: 20), (timer) {
      marketBloc.add(GetMarketEvent(refresh: true));
    });
  }



  List<CurrencyChoice> choices = [
    CurrencyChoice(currency: "USD", avatar: "assets/images/currency/usdt.png"),
    CurrencyChoice(currency: "BTC", avatar: "assets/images/currency/btc.png"),
    CurrencyChoice(currency: "ETH", avatar: "assets/images/currency/eth.png"),
  ];



  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        BlocBuilder<MarketBloc,MarketState>(
          buildWhen: (preState,newState){
            return preState.activeChoice != newState.activeChoice;
          },
          builder: (context,state){
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Row(
                children: List.generate(choices.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(
                        choices[index].currency,
                        style: textTheme.headline4,
                      ),
                      avatar: SizedBox(
                        width: 23,
                        height: 23,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            image: AssetImage(choices[index].avatar),
                          ),
                        ),
                      ),
                      selected: index == state.activeChoice,
                      selectedColor: Theme.of(context).primaryColorDark,
                      backgroundColor: Theme.of(context).primaryColorLight,
                      elevation: 3,
                      onSelected: (selected) {
                        if (selected) {
                          BlocProvider.of<MarketBloc>(context).add(UpdateChoiceEvent(index: index));
                        }
                      },
                    ),
                  );
                }),
              ),
            );

          },
        ),
        Expanded(
          child: BlocBuilder<MarketBloc,MarketState>(
            buildWhen: (preState,newState){
              return preState.cryptoData != newState.cryptoData || preState.activeChoice != newState.activeChoice;
            },
            builder: (context,state){
              BaseModel<CryptoModel> cryptoData = state.cryptoData;
              switch (cryptoData.status) {
                case ResponseStatus.Loading:
                  return CryptoShimmer(
                    count: 15,
                  );
                case ResponseStatus.Success:
                  return ListView.builder(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                    cryptoData.data.data.cryptoCurrencyList.length,
                    itemBuilder: (context, index) {
                      CryptoCurrencyList crypto = cryptoData.data.data.cryptoCurrencyList[index];
                      Quotes quote = crypto.quotes.firstWhere((element) =>
                      element.name ==
                          choices[state.activeChoice].currency);
                      return Crypto(
                        crypto: crypto,
                        price: quote.price,
                        percentChange: quote.percentChange24h,
                        pricePrefix:
                        quote.name == "USD" ? "\$" : " ${quote.name}",
                        onTap: (){
                          CryptoPage.navigate(context, crypto);
                        },
                      );
                    },
                  );
                case ResponseStatus.Failed:
                  return Text(cryptoData.message);
                default:
                  return Container();
              }
            },
          ),
        )
      ],
    );
  }

}
