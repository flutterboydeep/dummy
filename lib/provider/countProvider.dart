import 'package:flutter/material.dart';

class CountProvider with ChangeNotifier {
  int num = 0;
  int get number => num;
  void setNum() {
    num++;
    notifyListeners();
  }
}
