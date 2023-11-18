import 'package:dummy/Screen/showFav.dart';
import 'package:dummy/provider/favoriteItemProvider.dart';
// import 'package:dummy/provider/countProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    // final sliderProvider = Provider.of<multiProvider>(context, listen: false);
    final favoriteproviderObj =
        Provider.of<favoriteProvider>(context, listen: false);
    print("build function ");
    // print(favList);

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowFav(
                              favData: favoriteproviderObj.favList,
                            )));
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            print("I am running function");
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 16,
                shadowColor: Color.fromARGB(255, 9, 63, 156),
                color: Color.fromARGB(255, 139, 139, 139),
                child: Consumer<favoriteProvider>(
                    builder: (context, value, child) {
                  return ListTile(
                    onTap: () {
                      if (value.favList.contains(index)) {
                        value.removeData(index);
                        // value.favList.remove(index);
                      } else {
                        // value.favList.add(index);
                        value.addData(index);
                      }
                    },
                    leading: Text("Items $index"),
                    trailing: IconButton(
                      icon: value.favList.contains(index)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  );
                }),
              ),
            );
          },
          itemCount: 40,
          itemExtent: 100,
        ),
      ),
    );
  }
}
