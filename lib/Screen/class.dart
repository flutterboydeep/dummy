// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<userNotifier, user>(
    (ref) => userNotifier(user(name: "", age: 0)));

class user {
  final String name;
  final int age;

  user({
    required this.name,
    required this.age,
  });

  user copyWith({
    String? name,
    int? age,
  }) {
    return user(
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

  factory user.fromMap(Map<String, dynamic> map) {
    return user(
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory user.fromJson(String source) =>
      user.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'user(name: $name, age: $age)';

  @override
  bool operator ==(covariant user other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

class userNotifier extends StateNotifier<user> {
  userNotifier(super.state);

  void updateName(String n) {
    state = state.copyWith(name: n);
  }

  void updateAge(int a) {
    state = state.copyWith(age: a);
  }
}
