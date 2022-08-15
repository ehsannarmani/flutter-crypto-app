
import 'package:crypto_app/presentation/ui/pages/profile_page.dart';
import 'package:crypto_app/presentation/ui/pages/signup_page.dart';
import 'package:crypto_app/presentation/ui/pages/watch_list_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logic/providers/bottom_bar_provider.dart';
import '../ui_helper/bottom_bar.dart';
import '../ui_helper/theme_switcher.dart';
import 'home/home_page.dart';
import 'market_page.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    BottomBarProvider bottomBarProvider = Provider.of(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar:AppBar(
        title: Text("Crypto",style: textTheme.headline2),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>SignUpPage()),
            );
          }, icon: const Icon(Icons.person_pin)),
          const ThemeSwitcher()
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ) ,
      body: PageView(
        controller: _controller,
        children: [
          HomePage(),
          const MarketPage(),
          const ProfilePage(),
          const WatchListPage()
        ],
        onPageChanged: (index) {
          bottomBarProvider.changeIndex(index);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.currency_exchange, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked,
    );
  }
}
