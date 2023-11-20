import 'package:dummy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class homepage extends ConsumerWidget {
  void OnSubmitted(WidgetRef ref, value) =>
      ref.read(CounterStateProvider.notifier).update((state) => value);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("I am build in riverpod");
    final name = ref.watch(CounterStateProvider) ?? " ";
    // It is short hands  that if ref.watch(CounterStateProvider)==null ? " ": CounterStateProvider()

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            TextField(
              onSubmitted: (value) {
                OnSubmitted(ref, value);
              },
            ),
            Padding(padding: EdgeInsets.all(15), child: Text(name.toString()))
          ]),
        ),
      ),
    );
  }
}
