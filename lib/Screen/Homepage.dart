import 'dart:convert';

import 'package:dummy/models/Api_models_In_Dart.dart';
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
  List<DartModel> doneDataList = [];

  Future hitApi() async {
    http.Response responce;
    responce = await http.get(
        Uri.parse("https://webhook.site/8f28bca0-c0ff-42ec-9ea7-5e717b97a074"));
    // await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));
    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        doneDataList.add(DartModel.fromJson(i));
      }
      return doneDataList;
    }
    return doneDataList;
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

  String imageUrl = '';

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
                  ? Center(
                      child: CupertinoActivityIndicator(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      radius: 30,
                    ))
                  : GridView.builder(
                      itemCount: doneDataList.length,

                      itemBuilder: (context, index) {
                        var imageIndex = index % 3;
                        return Stack(
                          children: [
                            Image(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(
                                  // doneDataList[index].images.first
                                  doneDataList[index].images![imageIndex]),
                            ),
                            Text(doneDataList[index].id.toString())
                          ],
                        );

                        // Image(
                        //   image: NetworkImage(doneDataList[index].images![1]),
                        // ),
                        // Image(
                        //   image: NetworkImage(doneDataList[index].images![2]),
                        // ),
                      },

                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                      ),

                      // itemCount: doneDataList.length*3,
                    );
            }),
      ),
    );
  }
}
