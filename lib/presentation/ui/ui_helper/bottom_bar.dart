import 'package:crypto_app/logic/bloc/app/app_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatelessWidget {
  var onTap;

  BottomBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (preState, newState) {
        return preState.bottomBarIndex != newState.bottomBarIndex;
      },
      builder: (context, state) {
        return CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).primaryColorDark,
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.bar_chart,
              color: Colors.white,
            ),
            Icon(
              Icons.bookmark,
              color: Colors.white,
            )
          ],
          index: state.bottomBarIndex,
          letIndexChange: (index) {
            onTap(index);

            return false;
          },
        );
      },
    );
  }
}
