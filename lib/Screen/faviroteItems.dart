import 'package:flutter/material.dart';

class faviroteItems extends StatefulWidget {
  final List<dynamic> favItems;
  faviroteItems({
    super.key,
    required this.favItems,
  });

  @override
  State<faviroteItems> createState() => _faviroteItems();
}

class _faviroteItems extends State<faviroteItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Favirote Items")),
        body: Container(
          color: Color.fromARGB(255, 116, 114, 114),
          child: widget.favItems.isEmpty
              ? Center(
                  child: Text("No any favirote Item",
                      style: TextStyle(color: Colors.white)))
              : ListView(
                  children: widget.favItems.map((e) {
                    print("favirate image is = $e");

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 200,
                        child: Card(
                          color: Color.fromARGB(172, 28, 27, 27),
                          elevation: 16,
                          shadowColor: Colors.black,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3,
                                    color: Color.fromARGB(255, 251, 251, 251))),
                            child: ListTile(
                              title: Container(
                                height: 130,
                                width: 70,
                                child: CircleAvatar(
                                    radius: 200,
                                    backgroundImage: NetworkImage(e),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 33, 243, 215),
                                              width: 3)),
                                    )),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 90, top: 5),
                                child: Text("50",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white)),
                              ),
                              trailing: Icon(
                                Icons.favorite,
                                size: 30,
                                color: Colors.red[800],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ));
  }
}
