import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/models/crypto_model.dart';
import '../../../utils/formatter.dart';

class Crypto extends StatelessWidget {
  CryptoCurrencyList crypto;
  double? price;
  double? percentChange;
  String? pricePrefix;
  Crypto({Key? key, required this.crypto,this.price,this.percentChange,this.pricePrefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var finalPercent = percentChange ?? crypto.quotes.last.percentChange24h;
    var finalPrice = price ?? crypto.quotes.last.price;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Theme.of(context).highlightColor,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "https://s2.coinmarketcap.com/static/img/coins/128x128/${crypto.id}.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Formatter.limitText(crypto.name, 10),
                              style: textTheme.headline4,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(crypto.symbol, style: textTheme.subtitle2),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 80,
                      height: 50,
                      child: SvgPicture.network(
                        "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/${crypto.id}.svg",
                        color: finalPercent! < 0
                            ? Colors.red[400]
                            : Colors.green[400],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Formatter.formatPrice(finalPrice!)+ (pricePrefix ?? " \$"),
                          style: textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 5),
                          decoration: BoxDecoration(
                              color: finalPercent < 0
                                  ? Colors.red
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(3)),
                          child: Row(
                            children: [
                              Text(
                                double.parse(finalPercent.toString()).toStringAsFixed(2) + "%",
                                style: textTheme.headline5
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Icon(
                                finalPercent < 0
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                size: 12,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
