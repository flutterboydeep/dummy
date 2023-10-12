import 'package:dummy/Screen/fillDataFormScreen.dart';
import 'package:dummy/Screen/updateDataFormScreen.dart';
import 'package:flutter/material.dart';

class showdetailpage extends StatefulWidget {
  const showdetailpage({super.key});

  @override
  State<showdetailpage> createState() => _showdetailpageState();
}

class _showdetailpageState extends State<showdetailpage> {
  @override
  Widget build(BuildContext context) {
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
                      builder: (context) => const fillDataFormScreen()),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(children: [
              TableCell(
                  child: Container(
                child: const Text("Deep Panwar",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                alignment: Alignment.center,
                height: 40,
              )),
              TableCell(
                  child: Container(
                child: Center(child: Text("6398311")),
              )),
              TableCell(child: Container(child: Center(child: Text("000000")))),
              TableCell(
                  child: Container(
                      child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => updateDataForm()));
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        notify();
                      },
                      icon: Icon(Icons.delete, color: Colors.red))
                ],
              ))),
            ])
          ],
        ),
      ),
    );
  }

  void notify() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Are you sure to delete your detail"),
              content: Text("😲"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 106, 255)))),
                TextButton(
                    onPressed: () {},
                    child:
                        const Text("Okk", style: TextStyle(color: Colors.red)))
              ],
              contentPadding: EdgeInsets.only(left: 150),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              icon: const Icon(Icons.delete));
        });
  }
}
