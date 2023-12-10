import 'dart:convert';

import 'package:dummy/Screen/class.dart';
import 'package:flutter/material.dart';

import 'package:dummy/Screen/Homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final readSimpleProvider = Provider((ref) {
  return 'Hello Deepanshu sir';
});

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: mainpage()));
}

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<StatefulWidget> createState() => _mainpage();
}

class _mainpage extends State<mainpage> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          hintColor: Colors.red,
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 18, color: Colors.black),
            titleMedium: TextStyle(fontSize: 18, color: Colors.black),
            titleSmall: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        home: homepage());
  }
}
