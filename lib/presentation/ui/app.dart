import 'package:crypto_app/logic/bloc/app/app_bloc.dart';
import 'package:crypto_app/presentation/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  void applyTheme() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool? darkMode = sharedPreferences.getBool(Constants.DARK_MODE_ENABLED);

    // if user not saved light mode or dark mode , default mode is dark
    darkMode ??= true;
    BlocProvider.of<AppBloc>(context).add(UpdateAppThemeEvent(darkMode: darkMode));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    applyTheme();
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<AppBloc,AppState>(
      buildWhen: (preState,newState){
        return preState.darkModeEnabled != newState.darkModeEnabled;
      },
      builder: (context,state){
        return MaterialApp(
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: state.darkModeEnabled ?  ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home:MainPage(),
        );
      },
    );
  }
}

