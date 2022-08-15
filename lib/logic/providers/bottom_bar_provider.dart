import 'package:flutter/cupertino.dart';

class BottomBarProvider extends ChangeNotifier{
  int index = 0;
  void changeIndex(int newIndex){
    index = newIndex;
    notifyListeners();
  }
}