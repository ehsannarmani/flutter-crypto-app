import 'package:crypto_app/logic/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return  BlocBuilder<AppBloc,AppState>(
      buildWhen: (preState,newState){
        return preState.darkModeEnabled != newState.darkModeEnabled;
      },
      builder: (context,state){
        var icon = state.darkModeEnabled ? Icons.sunny : Icons.nightlight_round;
        return IconButton(
            onPressed: (){
              BlocProvider.of<AppBloc>(context).add(UpdateAppThemeEvent());
            },
            icon: Icon(icon)
        );
      },
    );
  }
}
