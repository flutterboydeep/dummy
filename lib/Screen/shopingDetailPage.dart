import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class shopingDetail extends StatefulWidget {
  final String picture;
  final String imageTitle;
  final String imageDescription;
  final List<dynamic> image;
  //  shopingDetail(Type string, String? s, {super.key, required String picture});
  shopingDetail({
    super.key,
    required this.picture,
    required this.imageTitle,
    required this.imageDescription,
    // String? imageDescription,

    required this.image,
  });

  @override
  State<shopingDetail> createState() => _shopingDetailState();
}

class _shopingDetailState extends State<shopingDetail> {
  // get picture => null;
  var imageView;
  var imageData = [];
  // var index;
  int selectedIndex = -2;

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 249, 2, 2),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            imageData.removeRange(0, 3);
            widget.image.removeRange(0, 3);
          },
        ),
      ),
      body: Container(
        color: const Color.fromARGB(56, 0, 0, 0).withAlpha(200),
        child: ListView(
          children: [
            Hero(
              tag: 'background',
              child: Image(
                image: imageView == null
                    ? NetworkImage(widget.picture)
                    : NetworkImage(imageView),
              ),
            ),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  children: [
                    TextSpan(text: widget.imageTitle),
                  ]),
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // children: widget.image.asMap().entries.map((entry) {
                children: widget.image.map((imageLink) {
                  final index = imageData.indexOf(imageLink);
                  // final index = entry.key;
                  // final imageLink = entry.value;
                  print("the value of index:  $index");

                  imageData.add(imageLink);
                  return Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: selectedIndex == index ? 3 : 0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )),
                        height: 100,
                        width: 100,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = imageData.indexOf(imageLink);
                              imageView = imageLink;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: NetworkImage(imageLink),
                            ),
                          ),
                        )),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
