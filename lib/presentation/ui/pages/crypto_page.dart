import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/data/data_source/base_model.dart';
import 'package:crypto_app/data/models/crypto_model.dart';
import 'package:crypto_app/logic/bloc/app/app_bloc.dart';
import 'package:crypto_app/logic/bloc/crypto/crypto_bloc.dart';
import 'package:crypto_app/logic/bloc/market/market_bloc.dart';
import 'package:crypto_app/presentation/ui/ui_helper/candle_chart.dart';
import 'package:crypto_app/presentation/ui/ui_helper/price_chart.dart';
import 'package:crypto_app/presentation/utils/constants.dart';
import 'package:crypto_app/presentation/utils/formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/candle_model.dart';

class CryptoPage extends StatefulWidget {
  CryptoCurrencyList crypto;

  CryptoPage({Key? key, required this.crypto}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();

  static void navigate(context, crypto) {
    Navigator.push(
        context,
        PageTransition(
            child: CryptoPage(
              crypto: crypto,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 300)));
  }

  static void navigateReplacement(context, crypto) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: CryptoPage(
              crypto: crypto,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 300)));
  }
}

class NoGrowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _CryptoPageState extends State<CryptoPage> {
  List<String> chartTimeframes = ["1H", "4H", "1D", "1W", "1M"];
  bool bookmarked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CryptoBloc>(context)
        .add(GetCandlesEvent(symbol: widget.crypto.symbol));
    BlocProvider.of<CryptoBloc>(context)
        .add(GetPricesEvent(id: widget.crypto.id));
    BlocProvider.of<CryptoBloc>(context).add(GetCryptoEvent());
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    BlocProvider.of<CryptoBloc>(context).add(ClearEvent());
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).focusColor),
        title: Text(
          "Statistic",
          style: textTheme.bodyText1!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(.2),
        elevation: 0,
        actions: [
          StatefulBuilder(
            builder: (context,setState){
              return FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  bool bookmarkedInFuture = false;
                  if (snapshot.hasData) {
                    SharedPreferences data = snapshot.data!;
                    List<String> bookmarkList =
                    (data.getString("bookmarks") ?? "").split(",");
                    if (bookmarkList.contains(widget.crypto.id.toString())) {
                      bookmarkedInFuture = true;
                    }
                  }
                  return IconButton(
                      onPressed: () {
                        if (snapshot.hasData) {
                          SharedPreferences data = snapshot.data!;
                          List<String> bookmarkList =
                          (data.getString(Constants.BOOKMARKS) ?? "").split(",");
                          if (!bookmarkList.contains(widget.crypto.id.toString())) {
                            bookmarkList.add(widget.crypto.id.toString());
                            setState((){
                              bookmarked = true;
                            });
                          }else{
                            bookmarkList.remove(widget.crypto.id.toString());
                            setState((){
                              bookmarked = false;
                            });
                          }
                          data.setString(Constants.BOOKMARKS, bookmarkList.join(","));
                        }
                      },
                      icon: Icon(bookmarked || bookmarkedInFuture ? Icons.bookmark : Icons.bookmark_border)
                  );
                },
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<AppBloc, AppState>(
            buildWhen: (preState, newState) {
              return preState.darkModeEnabled != newState.darkModeEnabled;
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image(
                  image: AssetImage(
                      "assets/images/${state.darkModeEnabled ? "bg-dark" : "bg-light"}.png"),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          ScrollConfiguration(
            behavior: NoGrowBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "https://s2.coinmarketcap.com/static/img/coins/128x128/${widget.crypto.id}.png"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.crypto.name,
                                style: textTheme.headline3,
                              ),
                              Text(
                                widget.crypto.symbol,
                                style:
                                    textTheme.subtitle2?.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    widget.crypto.quotes.last
                                                .percentChange24h! >
                                            0
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: widget.crypto.quotes.last
                                                .percentChange24h! >
                                            0
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  Text(
                                    "\$" +
                                        Formatter.formatPrice(
                                            widget.crypto.quotes.last.price!),
                                    style: textTheme.headline3,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                widget.crypto.quotes.last.percentChange24h!
                                        .toStringAsFixed(2) +
                                    "%",
                                style:
                                    textTheme.subtitle2?.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<CryptoBloc, CryptoState>(
                      buildWhen: (preState, newState) {
                        return preState.chartType != newState.chartType ||
                            preState.timeframeIndex != newState.timeframeIndex;
                      },
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedToggleSwitch<int>.rolling(
                              height: 35,
                              indicatorSize: const Size(40, double.infinity),
                              indicatorColor:
                                  const Color.fromRGBO(19, 174, 140, 1),
                              borderColor:
                                  const Color.fromRGBO(19, 174, 140, 1),
                              minTouchTargetSize: 30,
                              borderRadius: BorderRadius.circular(6),
                              indicatorBorderRadius: BorderRadius.circular(0),
                              borderWidth: 1,
                              current: state.timeframeIndex,
                              values: List.generate(
                                  chartTimeframes.length, (index) => index),
                              onChanged: (i) {
                                BlocProvider.of<CryptoBloc>(context).add(
                                    GetCandlesEvent(
                                        symbol: widget.crypto.symbol,
                                        interval: chartTimeframes[i]));
                                if (chartTimeframes[i] != "4H") {
                                  BlocProvider.of<CryptoBloc>(context).add(
                                      GetPricesEvent(
                                          id: widget.crypto.id,
                                          range: chartTimeframes[i]));
                                }
                                BlocProvider.of<CryptoBloc>(context)
                                    .add(UpdateTimeFrameEvent(i));
                              },
                              iconBuilder:
                                  (int value, Size iconSize, bool foreground) {
                                Color color = value == state.timeframeIndex
                                    ? Colors.white
                                    : Colors.black;
                                bool darkTheme = context
                                    .watch<AppBloc>()
                                    .state
                                    .darkModeEnabled;
                                if (darkTheme) color = Colors.white;
                                return Center(
                                  child: Text(
                                    chartTimeframes[value],
                                    style: textTheme.headline5!
                                        .copyWith(color: color),
                                  ),
                                );
                              },
                            ),
                            AnimatedToggleSwitch<int>.rolling(
                              height: 35,
                              indicatorSize: const Size(40, double.infinity),
                              indicatorColor:
                                  const Color.fromRGBO(19, 174, 140, 1),
                              borderColor:
                                  const Color.fromRGBO(19, 174, 140, 1),
                              minTouchTargetSize: 30,
                              borderRadius: BorderRadius.circular(6),
                              indicatorBorderRadius: BorderRadius.circular(0),
                              borderWidth: 1,
                              current: state.chartType,
                              values: const [
                                0,
                                1,
                              ],
                              onChanged: (i) {
                                BlocProvider.of<CryptoBloc>(context)
                                    .add(UpdateChartType(i));
                              },
                              iconBuilder:
                                  (int value, Size iconSize, bool foreground) {
                                Color color = value == state.chartType
                                    ? Colors.white
                                    : Colors.black;
                                bool darkTheme = context
                                    .watch<AppBloc>()
                                    .state
                                    .darkModeEnabled;
                                if (darkTheme) color = Colors.white;
                                switch (value) {
                                  case 0:
                                    return Icon(
                                      Icons.candlestick_chart,
                                      size: 20,
                                      color: color,
                                    );
                                  default:
                                    return Icon(
                                      Icons.show_chart,
                                      size: 15,
                                      color: color,
                                    );
                                }
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<CryptoBloc, CryptoState>(
                    buildWhen: (preState, newState) {
                      return preState.candleData != newState.candleData ||
                          preState.chartType != newState.chartType ||
                          preState.priceData != newState.priceData;
                    },
                    builder: (context, state) {
                      var candleData = state.candleData;
                      var priceData = state.priceData;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AnimatedCrossFade(
                          firstChild: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                          ),
                          secondChild: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: AnimatedCrossFade(
                              firstChild:
                                  candleData.status == ResponseStatus.Success
                                      ? CandleChart(candles: candleData.data)
                                      : Container(),
                              secondChild: priceData.status ==
                                      ResponseStatus.Success
                                  ? (chartTimeframes[state.timeframeIndex] ==
                                          "4H"
                                      ? Padding(
                                          child: Center(
                                            child: Text(
                                              "Price chart not available in 4H timeframe",
                                              style: textTheme.bodyText1!
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                        )
                                      : PriceChart(
                                          prices: priceData.data,
                                          price:
                                              widget.crypto.quotes.last.price!,
                                        ))
                                  : Container(),
                              crossFadeState: state.chartType == 0
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(milliseconds: 500),
                            ),
                          ),
                          crossFadeState:
                              candleData.status == ResponseStatus.Loading ||
                                      priceData.status == ResponseStatus.Loading
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 700),
                        ),
                      );
                    },
                    listenWhen: (preState, newState) {
                      return preState.candleData != newState.candleData ||
                          preState.chartType != newState.chartType;
                    },
                    listener: (context, state) {
                      if (state.candleData.status == ResponseStatus.Failed) {
                        BlocProvider.of<CryptoBloc>(context)
                            .add(UpdateChartType(1));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(7)),
                      child: BlocBuilder<CryptoBloc, CryptoState>(
                        builder: (context, state) {
                          Color dividerColor = Colors.white.withOpacity(.3);
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Price",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            "\$" +
                                                Formatter.formatPrice(widget
                                                    .crypto.quotes.last.price!),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "High 24H",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            "\$" +
                                                Formatter.formatPrice(
                                                    widget.crypto.high24h),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Low 24H",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            "\$" +
                                                Formatter.formatPrice(
                                                    widget.crypto.low24h!),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: dividerColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Vol 24H",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            Formatter.formatNumber(widget
                                                .crypto.quotes.last.volume24h),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Vol 7D",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            Formatter.formatNumber(widget
                                                .crypto.quotes.last.volume7d),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Vol 30D",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            Formatter.formatNumber(widget
                                                .crypto.quotes.last.volume30d),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: dividerColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Percent 1H",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.quotes.last
                                                    .percentChange1h!
                                                    .toStringAsFixed(2) +
                                                "%",
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Percent 24H",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.quotes.last
                                                    .percentChange24h!
                                                    .toStringAsFixed(2) +
                                                "%",
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Percent 7D",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.quotes.last
                                                    .percentChange7d!
                                                    .toStringAsFixed(2) +
                                                "%",
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: dividerColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Percent 30D",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.quotes.last
                                                    .percentChange30d!
                                                    .toStringAsFixed(2) +
                                                "%",
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Percent 60D",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.quotes.last
                                                    .percentChange60d!
                                                    .toStringAsFixed(2) +
                                                "%",
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Percent 90D",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.quotes.last
                                                    .percentChange90d!
                                                    .toStringAsFixed(2) +
                                                "%",
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: dividerColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Max Supply",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            Formatter.formatNumber(
                                                widget.crypto.maxSupply),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Supply",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            Formatter.formatNumber(
                                                widget.crypto.totalSupply),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Market Cap",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            "\$" +
                                                Formatter.formatNumber(widget
                                                    .crypto
                                                    .quotes
                                                    .last
                                                    .marketCap!),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: dividerColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "USDT Dominance",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.quotes.last.dominance
                                                .toString(),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Atl",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.atl
                                                .toStringAsFixed(2),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Ath",
                                            style: textTheme.headline5,
                                          ),
                                          Text(
                                            widget.crypto.ath
                                                .toStringAsFixed(2),
                                            style: textTheme.headline5,
                                          )
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "People Also Watch:",
                      style: textTheme.bodyText1!.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      height: 160,
                      child: BlocBuilder<CryptoBloc, CryptoState>(
                          buildWhen: (preState, newState) {
                        return preState.cryptoData != newState.cryptoData;
                      }, builder: (context, state) {
                        switch (state.cryptoData.status) {
                          case ResponseStatus.Loading:
                            return const Text("Loading");
                          case ResponseStatus.Success:
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.cryptoData.data.data
                                  .cryptoCurrencyList.length,
                              itemBuilder: (context, index) {
                                CryptoCurrencyList item = state.cryptoData.data
                                    .data.cryptoCurrencyList[index];
                                return SizedBox(
                                  width: 180,
                                  child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    color: Theme.of(context).highlightColor,
                                    child: InkWell(
                                      onTap: () {
                                        CryptoPage.navigateReplacement(
                                            context, item);
                                      },
                                      radius: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 35,
                                                  height: 35,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://s2.coinmarketcap.com/static/img/coins/128x128/${item.id}.png"),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Formatter.limitText(
                                                          item.name, 10),
                                                      style:
                                                          textTheme.headline3,
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "\$" +
                                                          Formatter.formatPrice(
                                                              item.quotes.last
                                                                  .price!),
                                                      style:
                                                          textTheme.headline4,
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: item
                                                                      .quotes
                                                                      .last
                                                                      .percentChange24h! <
                                                                  0
                                                              ? Colors.red
                                                              : Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3)),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 3,
                                                          vertical: 1),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            item.quotes.last
                                                                        .percentChange24h! <
                                                                    0
                                                                ? Icons
                                                                    .arrow_drop_down
                                                                : Icons
                                                                    .arrow_drop_up,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            item.quotes.last
                                                                    .percentChange24h!
                                                                    .toStringAsFixed(
                                                                        2) +
                                                                "%",
                                                            style: textTheme
                                                                .headline5,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 50,
                                              child: SvgPicture.network(
                                                "https://s3.coinmarketcap.com/generated/sparklines/web/7d/2781/${item.id}.svg",
                                                color: item.quotes.last
                                                            .percentChange24h! <
                                                        0
                                                    ? Colors.red[400]
                                                    : Colors.green[400],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          case ResponseStatus.Failed:
                            return Container();
                        }
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
