import 'package:flutter/material.dart';

class multiProvider with ChangeNotifier {
  var _sliderValue = 1.0;
  double get sliderValue {
    return _sliderValue;
  }

  void ChangeSlider(double val) {
    _sliderValue = val;
    notifyListeners();
  }
}
