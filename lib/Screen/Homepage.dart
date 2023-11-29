import 'package:dummy/Screen/class.dart';
import 'package:dummy/Screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userChangeProvider = ChangeNotifierProvider<userChange>((ref) {
  return userChange();
});

class homepage extends ConsumerWidget {
  void submit(value, WidgetRef ref) {
    ref.read(userChangeProvider).changeName(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("I am build in riverpod");

    final showData = ref.watch(userChangeProvider).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
      ),
      body: Container(
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
                ref.read(userChangeProvider).changeAge(int.parse(value));
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
                  child: Text(showData.name),
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(border: Border.all(width: 3)),
                ),
                Container(
                  child: Text(showData.age.toString()),
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(border: Border.all(width: 4)),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.read(countProvider.notifier).increament();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
