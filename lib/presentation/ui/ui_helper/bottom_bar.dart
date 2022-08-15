import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logic/providers/bottom_bar_provider.dart';


class BottomBar extends StatelessWidget {
  var onTap;


  BottomBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<BottomBarProvider>(
      builder: (context, provider, child) {
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
                        color: provider.index == 0 ? Colors.white : Colors.white60,
                      ),
                      IconButton(
                        onPressed: () {
                          onTap(1);
                        },
                        icon: const Icon(Icons.bar_chart),
                        color: provider.index == 1 ? Colors.white : Colors.white60,
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
                        color: provider.index == 2 ? Colors.white : Colors.white60,
                      ),
                      IconButton(
                        onPressed: () {
                          onTap(3);
                        },
                        icon: const Icon(Icons.bookmark),
                        color:provider.index == 3 ? Colors.white : Colors.white60,
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
