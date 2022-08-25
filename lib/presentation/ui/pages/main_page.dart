
import 'package:crypto_app/logic/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../ui_helper/bottom_bar.dart';
import '../ui_helper/theme_switcher.dart';
import 'home/home_page.dart';
import 'market_page.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar:AppBar(
        title: Text("Crypto",style: textTheme.headline2),
        actions: const [ThemeSwitcher()],
        iconTheme: const IconThemeData(color: Colors.white),
      ) ,
      body: PageView(
        controller: _controller,
        children: [
          HomePage(),
          const MarketPage(),
        ],
        onPageChanged: (index) {
          BlocProvider.of<AppBloc>(context).add(UpdateBottomBarEvent(index));
        },

      ),
      bottomNavigationBar: BottomBar(
        onTap: (index) {
          _controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut
          );
        },
      ),
    );
  }
}
