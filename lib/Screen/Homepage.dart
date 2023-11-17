import 'package:dummy/provider/countProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  State<StatefulWidget> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final InProvider = Provider.of<CountProvider>(context, listen: false);

    print("build function run");

    return Scaffold(
      appBar: AppBar(title: Text("Provider Using Count Example")),
      body: Container(
        child: Center(
          child: Consumer<CountProvider>(
            builder: (context, value, child) {
              return Text(
                value.number.toString(),
                style: TextStyle(fontSize: 25),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: [IconButton(onPressed: () {}, icon: Icon(Icons.home))],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          InProvider.setNum();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
