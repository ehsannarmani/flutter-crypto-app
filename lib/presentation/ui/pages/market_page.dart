import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../data/data_source/base_model.dart';
import '../../../data/models/crypto_model.dart';
import '../../../logic/providers/market_choices_provider.dart';
import '../../../logic/providers/market_page_provider.dart';
import '../ui_helper/crypto/crypto.dart';
import '../ui_helper/crypto/crypto_shimmer.dart';

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

    MarketPageProvider provider = Provider.of(context, listen: false);
    provider.getMarketCap();

    
    Timer.periodic(const Duration(seconds: 20), (timer) {
      provider.getMarketCap();
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
        Consumer<MarketChoicesProvider>(
          builder: (context, provider, child) {
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
                      selected: index == provider.activeChoice,
                      selectedColor: Theme.of(context).primaryColorDark,
                      backgroundColor: Theme.of(context).primaryColorLight,
                      elevation: 3,
                      onSelected: (selected) {
                        if (selected) {
                          provider.active(index);
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
          child: Consumer<MarketChoicesProvider>(
            builder: (context, choiceProvider, child) {
              return Consumer<MarketPageProvider>(
                builder: (context, provider, child) {
                  switch (provider.data?.status) {
                    case ResponseStatus.Loading:
                      return CryptoShimmer(
                        count: 15,
                      );
                    case ResponseStatus.Success:
                      return ListView.builder(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            provider.data!.data.data.cryptoCurrencyList.length,
                        itemBuilder: (context, index) {
                          CryptoCurrencyList crypto = provider
                              .data!.data.data.cryptoCurrencyList[index];
                          Quotes quote = crypto.quotes.firstWhere((element) =>
                              element.name ==
                              choices[choiceProvider.activeChoice].currency);
                          return Crypto(
                            crypto: crypto,
                            price: quote.price,
                            percentChange: quote.percentChange24h,
                            pricePrefix:
                                quote.name == "USD" ? "\$" : " ${quote.name}",
                          );
                        },
                      );
                    case ResponseStatus.Failed:
                      return Text(provider.data!.message);
                    default:
                      return Container();
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}
