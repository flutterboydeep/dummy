import 'dart:async';

import 'package:flutter/material.dart';

Stream<int> fatchNumber() {
  return Stream.periodic(
    Duration(seconds: 1),
    (num) => num,
  ).take(10);
}
