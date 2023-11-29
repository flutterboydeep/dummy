import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class userData {
  String name;
  int age;
  userData({
    required this.name,
    required this.age,
  });

  userData copyWith({
    String? name,
    int? age,
  }) {
    return userData(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }

  factory userData.fromMap(Map<String, dynamic> map) {
    return userData(
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory userData.fromJson(String source) =>
      userData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'userData(name: $name, age: $age)';

  @override
  bool operator ==(covariant userData other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

class userDataProvider extends StateNotifier<userData> {
  userDataProvider(super.state);

  void updateName(value) {
    state = state.copyWith(name: value);
    // state.name = value;
  }

  void updateAge(value) {
    state = state.copyWith(age: value);
    // state.age = value;
  }
}

//  Here is code of changeNotifier
class userChange extends ChangeNotifier {
  userData user = userData(name: 'NoName ', age: 0);
  void changeName(String n) {
    user = user.copyWith(name: n);
    notifyListeners();
  }

  void changeAge(int a) {
    user = user.copyWith(age: a);
    notifyListeners();
  }
}
