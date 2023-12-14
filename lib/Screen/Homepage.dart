import 'dart:convert';
import 'dart:developer';

import 'package:dummy/Screen/class.dart';
import 'package:dummy/Screen/homepage.dart';
import 'package:dummy/Screen/steamFetchData.dart';
import 'package:dummy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stream = StreamProvider((ref) {
  return fatchNumber();
});

class homepage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(stream).when(
          data: (data) {
            print('I am reRun again');
            return Scaffold(
              appBar: AppBar(
                title: Text("futureProvier in Riverpod"),
              ),
              body: Container(
                child: Center(
                  child: Text(
                    data.toString(),
                    style: TextStyle(fontSize: 35),
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
