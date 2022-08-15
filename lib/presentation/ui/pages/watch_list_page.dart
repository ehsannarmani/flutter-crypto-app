import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WatchListPage extends StatelessWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("wath list rebuild");
    return Center(child: Text("WathList Page"),);
  }
}
