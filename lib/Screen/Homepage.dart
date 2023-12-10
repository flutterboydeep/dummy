import 'dart:convert';
import 'dart:developer';

import 'package:dummy/Screen/class.dart';
import 'package:dummy/Screen/homepage.dart';
import 'package:dummy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final fatchData = FutureProvider<List<userData>>((ref) async {
  return fatchUserData();
});
Future<List<userData>> fatchUserData() async {
  final response = await http
      .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments"));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map<userData>((data) {
      return userData.fromMap(data);
    }).toList();
  } else {
    throw Exception("fail to load data");
  }
}

class homepage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fatchData).when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: Text("futureProvier in Riverpod"),
              ),
              body: Container(
                child: Center(
                  child: Column(
                    children: data.map((e) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Text(e.id.toString())),
                        title: Text(e.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
          error: (error, StackTrace) {
            print(error.toString());
            log(error.toString());
            return Scaffold(
              body: Center(
                child: Text("This type of error : " + error.toString()),
              ),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
