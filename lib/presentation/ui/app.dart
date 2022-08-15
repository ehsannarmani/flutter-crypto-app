import 'package:crypto_app/presentation/ui/pages/main_page.dart';
import 'package:crypto_app/presentation/ui/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logic/providers/theme_provider.dart';
import '../utils/constants.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,provider,child){
        return MaterialApp(
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: provider.isDarkMode ?  ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                SharedPreferences pref = snapshot.data!;
                if(pref.getBool(Constants.USER_LOGGED_IN) ?? false){
                  return MainPage();
                }else{
                  return SignUpPage();
                }
              }else{
                return Scaffold();
              }
            },
          ),
        );
      },
    );
  }
}

