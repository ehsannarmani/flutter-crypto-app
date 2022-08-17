
import 'package:crypto_app/logic/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    HomeBloc homeBloc = BlocProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          BlocBuilder<HomeBloc,HomeState>(
            buildWhen: (preState,newState){
              return preState.marketTypeChoiceIndex != newState.marketTypeChoiceIndex;
            },
            builder: (context,state){
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
                    selected: state.marketTypeChoiceIndex == index,
                    selectedColor: Theme.of(context).primaryColorDark,
                    onSelected: (selected) {
                      if (selected) {
                        homeBloc.add(ChangeMarketTypeEvent(index: index));
                        switch(index){
                          case 0:
                            homeBloc.add(GetMarketEvent(market: Market.TopMarketCap));
                            break;
                          case 1:
                            homeBloc.add(GetMarketEvent(market: Market.TopGainers));
                            break;
                          case 2:
                            homeBloc.add(GetMarketEvent(market: Market.TopLosers));
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
