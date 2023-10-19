import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dummy/Screen/fillDataFormScreen.dart';
import 'package:dummy/Screen/updateDataFormScreen.dart';
import 'package:flutter/material.dart';

class showdetailpage extends StatefulWidget {
  const showdetailpage({super.key});

  @override
  State<showdetailpage> createState() => sshowdetailpageState();
}

var username = "";

class sshowdetailpageState extends State<showdetailpage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("somethings went Wrong in Stream builder");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // if (snapshot.data!.docs.isEmpty) {
          //   return Center(child: Text("NO data found"));
          // }

          //   // var userdata = snapshot.data!.docs[1]['from'];
          //   // print(userdata);
          //   return Text(snapshot.data!.docs[0]['age']);
          // }
          // children: snapshot.data!.docs
          //   .map((DocumentSnapshot document) {
          //     Map<String, dynamic> data =
          //         document.data()! as Map<String, dynamic>;
          //     return ListTile(
          var userdata = [];

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map maped = document.data()! as Map;
            maped['id'] = document.id;
            print(maped); // here id key create in map with document id

            userdata.add(maped);
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text("Details page"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => fillDataFormScreen()),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 193, 17, 252))),
                    child: const Text(
                      "Add User",
                      style: TextStyle(color: Colors.white),
                      selectionColor: Color.fromARGB(255, 27, 136, 27),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  // 3: IntrinsicColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(width: 1.5, color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          alignment: Alignment.center,
                          height: 50,
                          child: const Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          alignment: Alignment.center,
                          height: 50,
                          child: const Text(
                            "Number",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          alignment: Alignment.center,
                          height: 50,
                          child: const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: const Color.fromARGB(255, 105, 240, 175),
                          alignment: Alignment.center,
                          height: 50,
                          child: const Text(
                            "Action",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (int i = 0; i < userdata.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                          child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(userdata[i]['name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        alignment: Alignment.center,
                        height: 40,
                      )),
                      TableCell(
                          child: Container(
                        child: Center(child: Text(userdata[i]['number'])),
                      )),
                      TableCell(
                          child: Container(
                              child: Center(
                                  child: Text(userdata[i]['password'])))),
                      TableCell(
                          child: Container(
                              child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => updateDataForm(
                                            userId: userdata[i]['id'])));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text(
                                              "Are you sure to delete your detail"),
                                          content: Text("😲"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            0,
                                                            106,
                                                            255)))),
                                            TextButton(
                                                onPressed: () {
                                                  username = snapshot
                                                      .data!.docs[i]['name'];
                                                  deleteUser(userdata[i]['id']);
                                                },
                                                child: const Text("Okk",
                                                    style: TextStyle(
                                                        color: Colors.red)))
                                          ],
                                          contentPadding:
                                              EdgeInsets.only(left: 150),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          icon: const Icon(Icons.delete));
                                    });
                              },
                              icon: Icon(Icons.delete, color: Colors.red))
                        ],
                      ))),
                    ])
                  ]
                ],
              ),
            ),
          );
        });
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection("students");
  Future<void> deleteUser(id) async {
    print("user deleted $id");
    Navigator.of(context).pop();
    await students.doc(id).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$username user succesfully deleted",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Colors.green,
      ));
    });
  }
}
