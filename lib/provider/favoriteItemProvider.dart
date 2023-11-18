import 'package:flutter/material.dart';

class favoriteProvider with ChangeNotifier {
  List<dynamic> _favList = [];
  List<dynamic> get favList => _favList;

  void addData(int value) {
    _favList.add(value);
    notifyListeners();
  }

  void removeData(int value) {
    _favList.remove(value);
    notifyListeners();
  }
}
