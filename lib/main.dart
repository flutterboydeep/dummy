import 'package:dummy/Screen/showDetailPage.dart';
import 'package:dummy/Screen/userLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const mainpage());
}

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<StatefulWidget> createState() => _mainpage();
}

class _mainpage extends State<mainpage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Somethings is Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("i am in Waiting");
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print("all is done");
          return MaterialApp(
            home: const showdetailpage(),
            title: "learn FireStore",
            theme: ThemeData(primarySwatch: Colors.cyan),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
