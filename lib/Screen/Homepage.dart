import 'dart:convert';
import 'dart:ui';

import 'package:dummy/Screen/shopingDetailPage.dart';
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
        Uri.parse("https://webhook.site/8fe2b457-0dc0-4f0c-8793-b95421394a24"));
    // Uri.parse("https://webhook.site/8f28bca0-c0ff-42ec-9ea7-5e717b97a074"));
    // await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));
    var data = jsonDecode(responce.body.toString());
    if (doneDataList.isEmpty) {
      for (Map<String, dynamic> i in data) {
        doneDataList.add(DartModel.fromJson(i));
      }
    }

    if (responce.statusCode == 200) {
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

  var listIdx = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: Drawer(

          // surfaceTintColor: Colors.black,
          ),
      appBar: AppBar(
        flexibleSpace: ClipRRect(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        )),
        // toolbarHeight: 70,
        // scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.black.withAlpha(200),
        centerTitle: true,
        title: Text("Homepage",
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
      ),
      body: Container(
        color: Colors.black.withAlpha(200),
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
                      color: Color.fromARGB(255, 0, 255, 195),
                      radius: 30,
                    ))
                  : GridView.builder(
                      itemCount: doneDataList.length,

                      itemBuilder: (context, index) {
                        // imagesArrey();

                        // var imageIndex = index % 3;
                        return Stack(
                          children: [
                            Container(
                                color: Color.fromARGB(198, 100, 96, 98),
                                // height: 220,
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         width: 1.5, color: Colors.black)),
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: 'background_${index}',
                                      child: InkWell(
                                        onTap: () {
                                          for (int i = 0;
                                              i <
                                                  doneDataList[index]
                                                      .images!
                                                      .length;
                                              i++) {
                                            print(i);
                                            imageUrl.add(
                                                doneDataList[index].images![i]);
                                          }
                                          // imagesArrey();
                                          print(imageUrl);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      shopingDetail(
                                                        picture:
                                                            doneDataList[index]
                                                                .category!
                                                                .image
                                                                .toString(),
                                                        imageTitle:
                                                            doneDataList[index]
                                                                .title
                                                                .toString(),
                                                        imageDescription:
                                                            doneDataList[index]
                                                                .description
                                                                .toString(),
                                                        image: imageUrl,
                                                      )));
                                        },
                                        child: Image(
                                          height: 170,
                                          width: 160,
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                              // doneDataList[index].images.first
                                              doneDataList[index]
                                                  .category!
                                                  .image
                                                  .toString()),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              backgroundColor: Colors.black),
                                          children: [
                                            TextSpan(text: "₹ "),
                                            TextSpan(
                                                text: doneDataList[index]
                                                    .price
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.red)),
                                          ]),
                                    ),

                                    // Text(doneDataList[index].price.toString(),style: TextStyle(fontSize: 25,color:Colors.red),),
                                  ],
                                )),
                            Positioned(
                                left: 40,
                                child: Text(doneDataList[index].id.toString(),
                                    style: TextStyle(fontSize: 20)))
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
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 220,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 25,
                      ),

                      // itemCount: doneDataList.length*3,
                    );
            }),
      ),
    );
  }

  var imageUrl = [];

  // void imagesArrey() {
  //   for (var i = 0; i < doneDataList.length; i++) {
  //     for (var j = 0; j < doneDataList[i].images!.length;) {
  //       imageUrl[j] = doneDataList[i].images![j];
  //     }
  //   }
  // }
}
