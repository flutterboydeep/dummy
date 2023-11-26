import 'package:dummy/Screen/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final CounterStateProvider = StateProvider<int>((ref) {
  return 0;
});

class homepage extends ConsumerWidget {
  void submit(value, WidgetRef ref) {
    ref.read(userProvider.notifier).updateName(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("I am build in riverpod");
    final userInfo = ref.watch(userProvider);
    // final CountProvider = ref.watch(CounterStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
      ),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onSubmitted: (val) {
                submit(val, ref);
              },
              decoration: InputDecoration(
                  hintText: "Enter your name", helperText: "Enter your name"),
            ),
            TextField(
              onSubmitted: (value) {
                ref.read(userProvider.notifier).updateAge(int.parse(value));
              },
              decoration: InputDecoration(
                  hintText: "Enter your name", helperText: "Enter your name"),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(userInfo.name),
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(border: Border.all(width: 3)),
                ),
                Container(
                  child: Text(userInfo.age.toString()),
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(border: Border.all(width: 3)),
                )
              ],
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.send),
      ),
    );
  }
}
