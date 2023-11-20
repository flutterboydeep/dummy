import 'package:dummy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:provider/provider.dart';

class homepage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchName = ref.watch(readSimpleProvider);
    // final sliderProvider = Provider.of<multiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
        actions: [],
      ),
      body: Container(
        child: Text(watchName),
      ),
    );
  }
}
