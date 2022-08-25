
import 'package:flutter/material.dart';
import '../../ui_helper/crypto/crypto_market.dart';
import 'helper/home_banners.dart';
import 'helper/home_choices.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const HomeBanners(),
          const SizedBox(height: 20),
          HomeChoices(),
          const Expanded(
            child: CryptoMarket(),
          )
        ],
      ),
    );
  }
}
