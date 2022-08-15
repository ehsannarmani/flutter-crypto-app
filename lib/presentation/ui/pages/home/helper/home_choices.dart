
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../logic/providers/crypto_api_provider.dart';
import '../../../../../logic/providers/home_choices_provider.dart';
import '../../../ui_helper/theme_switcher.dart';

class ChoiceData {
  int id;
  String title;
  IconData icon;

  ChoiceData({required this.id, required this.title, required this.icon});
}

class HomeChoices extends StatelessWidget {
  HomeChoices({Key? key,this.onSelected}) : super(key: key);
  Function? onSelected;
  List<ChoiceData> data = [
    ChoiceData(id: 1, title: "Top MarketCaps", icon: Icons.arrow_upward),
    ChoiceData(id: 2, title: "Top Gainers", icon: Icons.show_chart),
    ChoiceData(id: 3, title: "Top Losers", icon: Icons.waterfall_chart),
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    CryptoApiProvider cryptoApiProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Consumer<HomeChoicesProvider>(
            builder: (context, provider, child) {
              return Wrap(
                spacing: 10,
                children: List.generate(data.length, (index) {
                  return ChoiceChip(
                    label: Text(
                      data[index].title,
                      style: textTheme.headline5,
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                    avatar: Icon(
                      data[index].icon,
                      size: 18,
                      color: Colors.white,
                    ),
                    elevation: 3,
                    selected: provider.selectedChoice == index,
                    selectedColor: Theme.of(context).primaryColorDark,
                    onSelected: (selected) {
                      if (selected) {
                        provider.selectChoice(index);
                        switch(index){
                          case 0:
                            cryptoApiProvider.getMarket(
                                forceShowLoading: true,
                                market: Market.TopMarketCap
                            );
                            break;
                          case 1:
                            cryptoApiProvider.getMarket(
                                forceShowLoading: true,
                                market: Market.TopGainers
                            );
                            break;
                          case 2:
                            cryptoApiProvider.getMarket(
                                forceShowLoading: true,
                                market: Market.TopLosers
                            );
                            break;
                        }
                        if (onSelected != null) {
                          onSelected!(index);
                        }
                      }
                    },
                    backgroundColor: Theme.of(context).primaryColorLight,
                  );
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
