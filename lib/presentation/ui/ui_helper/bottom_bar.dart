import 'package:crypto_app/logic/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatelessWidget {
  var onTap;


  BottomBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AppBloc,AppState>(
      buildWhen: (preState,newState){
        return preState.bottomBarIndex != newState.bottomBarIndex;
      },
      builder: (context,state){
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          color: Theme.of(context).primaryColorDark,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          onTap(0);
                        },
                        icon: const Icon(Icons.home_rounded),
                        color: state.bottomBarIndex == 0 ? Colors.white : Colors.white60,
                      ),
                      IconButton(
                        onPressed: () {
                          onTap(1);
                        },
                        icon: const Icon(Icons.bar_chart),
                        color: state.bottomBarIndex == 1 ? Colors.white : Colors.white60,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          onTap(2);
                        },
                        icon: const Icon(Icons.person),
                        color: state.bottomBarIndex == 2 ? Colors.white : Colors.white60,
                      ),
                      IconButton(
                        onPressed: () {
                          onTap(3);
                        },
                        icon: const Icon(Icons.bookmark),
                        color:state.bottomBarIndex == 3 ? Colors.white : Colors.white60,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );

      },
    );
  }
}
