import 'package:flutter/cupertino.dart';

class MarketSearchProvider extends ChangeNotifier{
  bool searchOpen = false;
  void toggleSearch(){
    searchOpen = !searchOpen;
    notifyListeners();
  }
}