
import 'package:crypto_app/di.dart';
import 'package:crypto_app/presentation/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/app/app_bloc.dart';
import 'logic/bloc/home/home_bloc.dart';
import 'logic/bloc/market/market_bloc.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  // init get it locator
  setup();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_)=>locator<HomeBloc>(),),
      BlocProvider(create: (_)=>locator<MarketBloc>(),),
      BlocProvider(create: (_)=>locator<AppBloc>(),),
    ],
    child: const App(),
  ));
}





