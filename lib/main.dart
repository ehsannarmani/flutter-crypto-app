
import 'package:crypto_app/presentation/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'logic/providers/banner_api_provider.dart';
import 'logic/providers/bottom_bar_provider.dart';
import 'logic/providers/crypto_api_provider.dart';
import 'logic/providers/home_choices_provider.dart';
import 'logic/providers/market_choices_provider.dart';
import 'logic/providers/market_page_provider.dart';
import 'logic/providers/market_search_provider.dart';
import 'logic/providers/theme_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      ChangeNotifierProvider(create: (context)=>BottomBarProvider()),
      ChangeNotifierProvider(create: (context)=>CryptoApiProvider()),
      ChangeNotifierProvider(create: (context)=>BannerApiProvider()),
      ChangeNotifierProvider(create: (context)=>HomeChoicesProvider()),
      ChangeNotifierProvider(create: (context)=>MarketPageProvider()),
      ChangeNotifierProvider(create: (context)=>MarketChoicesProvider()),
      ChangeNotifierProvider(create: (context)=>MarketSearchProvider()),
    ],
    child: const App(),
  ));
}





