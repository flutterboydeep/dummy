import 'package:dummy/Screen/faviroteItems.dart';
import 'package:flutter/material.dart';

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
  List<String> like = [];
  var storeLike = [];

  var imageView;
  var imageData = [];
  var currentHeroImage = "";
  var fillLikeIcon = Icon(
    Icons.favorite,
    color: Colors.red,
    size: 40,
  );
  var borderLikeIcon = Icon(
    Icons.favorite_border,
    size: 40,
    color: Colors.red,
  );
  // var index;
  int selectedIndex = -2;
  // var favIcon = Icon(Icons.favorite_border, color: Colors.red, size: 40);
  var isFav = false;
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
            print(" On pop time Like items are is = $like");
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  like.length > 0
                      ? CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black,
                          child: Text("${like.length}"))
                      : Icon(Icons.star),
                  IconButton(
                      onPressed: () {
                        for (int i = 0; i < like.length; i++) {
                          storeLike.add(like[i]);
                        }
                        print("Like items are is = $like");
                        print("StoreLike items are is = $storeLike");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    faviroteItems(favItems: like)));
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30,
                      )),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: const Color.fromARGB(56, 0, 0, 0).withAlpha(200),
        child: ListView(
          children: [
            Hero(
              tag: imageView == null
                  ? currentHeroImage = widget.picture
                  : currentHeroImage = imageView,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  // imageView == null
                  //     ? currentHeroImage = widget.picture
                  //     : currentHeroImage = imageView,
                  Image(
                    image: imageView == null
                        ? NetworkImage(widget.picture)
                        : NetworkImage(imageView),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: isFav == false
                        ? IconButton(
                            onPressed: () {
                              if (like.isEmpty) {
                                like.add(currentHeroImage);

                                isFav = true;
                              } else {
                                if (like.contains(currentHeroImage)) {
                                  // borderLikeIcon=Icon(Icons.favorite);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              "This product is in favirote list")));

                                  isFav = false;
                                  setState(() {});
                                } else {
                                  like.add(currentHeroImage);

                                  isFav = true;
                                  setState(() {});
                                }
                              }

                              setState(() {});
                            },
                            icon: borderLikeIcon,
                          )
                        : IconButton(
                            onPressed: () {
                              // if (!like.contains(currentHeroImage)) {
                              //   isFav = false;
                              // }
                              like.remove(currentHeroImage);
                              isFav = false;

                              setState(() {});
                            },
                            icon: fillLikeIcon,
                          ),
                  ),
                ],
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
                  // print("the value of index:  $index");
                  // print("the value of Selectedindex:  $selectedIndex");

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
                              if (like.contains(currentHeroImage)) {
                                isFav = false;
                              }
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
