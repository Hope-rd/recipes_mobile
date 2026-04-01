
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier{
  int _currentIndex = 0;

  int get currentIdex => _currentIndex;

  void changeIdex(int index){
   _currentIndex = index;
    notifyListeners();
  }

}