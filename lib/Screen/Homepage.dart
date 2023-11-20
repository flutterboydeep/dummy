import 'package:dummy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:provider/provider.dart';

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final watchName = ref.watch(readSimpleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
      ),
      body: Container(child: Consumer(
        builder: (context, ref, child) {
          final watchName = ref.watch(readSimpleProvider);
          return Text(watchName);
        },
      )),
    );
  }
}
