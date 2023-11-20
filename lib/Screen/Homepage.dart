import 'package:dummy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final CounterStateProvider = StateProvider<int>((ref) {
  return 0;
});

class homepage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("I am build in riverpod");
    final CountProvider = ref.watch(CounterStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
      ),
      body: Container(
        child: Center(
          child: Text(
            CountProvider.toString(),
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(CounterStateProvider.notifier).state++;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
