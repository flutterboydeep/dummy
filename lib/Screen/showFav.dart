import 'package:flutter/material.dart';

class ShowFav extends StatefulWidget {
  final List<dynamic> favData;

  ShowFav({super.key, required this.favData});

  @override
  State<ShowFav> createState() => _ShowFavState();
}

class _ShowFavState extends State<ShowFav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Items"),
      ),
      body: Container(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(15.0),
            child: Card(
              color: Color.fromARGB(255, 159, 159, 159),
              child: ListTile(
                leading: Text("items ${widget.favData[index]}"),
                trailing: Icon(Icons.favorite,
                    color: const Color.fromARGB(255, 255, 17, 0)),
              ),
            ),
          );
        },
        itemExtent: 100,
        itemCount: widget.favData.length,
      )),
    );
  }
}
