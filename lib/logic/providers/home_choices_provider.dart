import 'package:flutter/cupertino.dart';

class HomeChoicesProvider extends ChangeNotifier{
  int selectedChoice = 0;
  void selectChoice(int index){
    selectedChoice = index;
    notifyListeners();
  }
}