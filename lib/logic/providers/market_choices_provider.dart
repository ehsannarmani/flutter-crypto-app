import 'package:flutter/cupertino.dart';

class MarketChoicesProvider extends ChangeNotifier{
  int activeChoice = 0;

  void active(int index){
    activeChoice = index;
    notifyListeners();
  }
}