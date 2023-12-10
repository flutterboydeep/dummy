// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

class userData {
  String name;
  int id;
  userData({
    required this.name,
    required this.id,
  });

  userData copyWith({
    String? name,
    int? id,
  }) {
    return userData(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory userData.fromMap(Map<String, dynamic> map) {
    return userData(
      name: map['name'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory userData.fromJson(String source) =>
      userData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'userData(name: $name, id: $id)';

  @override
  bool operator ==(covariant userData other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
