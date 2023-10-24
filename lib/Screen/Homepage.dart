import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // hitApi();
    super.initState();
  }

  var datamap = {};
  List doneDataList = [];

  Future hitApi() async {
    http.Response responce;
    responce =
        // await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));
        await http.get(Uri.parse(
            "https://webhook.site/d63ee272-ee2d-4242-8e59-da895b8f9161"));

    if (responce.statusCode == 200) {
      setState(() {
        doneDataList = jsonDecode(responce.body);
        // print(doneDataList);
      });
    }
  }

  // allitem() {
  //   for (var a = 0; a < 3; a++) {
  //     for (var i = 0; i < doneDataList[a]['images'].length; i++) {
  //       Image(
  //         fit: BoxFit.fill,
  //         image: NetworkImage(doneDataList[a]['images'][i]),
  //       );
  //     }
  //   }
  // }

  List<Widget> imageWidgets = [];
  showImage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(

          // surfaceTintColor: Colors.black,
          ),
      appBar: AppBar(
        // toolbarHeight: 70,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Color.fromARGB(131, 78, 74, 74),
        title: Text("Homepage"),
      ),
      body: Container(
        child: FutureBuilder(
            future: hitApi(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("No Data found"));
              } else if (snapshot.data == ConnectionState.waiting) {
                return Center(
                    child: CupertinoActivityIndicator(
                  color: Color.fromARGB(255, 0, 34, 255),
                  radius: 24,
                ));
              }

              // ignore: unnecessary_null_comparison
              return doneDataList.isEmpty
                  ? Center(child: CupertinoActivityIndicator())
                  : GridView.builder(
                      itemCount: doneDataList.length * 3,

                      itemBuilder: (context, index) {
                        int dataIndex = index ~/ 3;
                        int imageIndex = index % 3;
                        print(index);

                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                doneDataList[dataIndex]['images'][imageIndex]),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 30,
                      ),
                      // itemCount: doneDataList.length*3,
                    );
            }),
      ),
    );
  }
}
