import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class updateDataForm extends StatefulWidget {
  final String userId;
  updateDataForm({super.key, required this.userId});

  @override
  State<StatefulWidget> createState() => uupdateDataForm();
}

class uupdateDataForm extends State<updateDataForm> {
  bool eye = true;
  var icon = const Icon(Icons.visibility_off);

  final _addFormkey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update detail Screen"),
      ),
      body: Container(
        child: Form(
          key: _addFormkey,
          //  Start getting spacific data by id
          child: FutureBuilder<DocumentSnapshot<Map>>(
              future: FirebaseFirestore.instance
                  .collection("students")
                  .doc(widget.userId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text("something went wrong in update page"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CupertinoActivityIndicator(
                    radius: 25,
                    color: Color.fromARGB(255, 38, 0, 255),
                  ));
                }
                var data = snapshot.data!.data();

                var name = data!['name'];

                var number = data['number'];
                var password = data['password'];
                //  End: spacific data by id
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 20, right: 20, bottom: 30),
                  child: Container(
                    child: ListView(
                      children: [
                        TextFormField(
                            initialValue: name,
                            autofocus: false,
                            onChanged: (value) {
                              name = value;
                            },
                            // controller: namectrl,
                            decoration: InputDecoration(
                              // hintText: "Enter your name",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Name';
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            initialValue: number,
                            onChanged: (value) {
                              number = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // hintText: "Enter your mobile number min 6 digit",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Mobile Number';
                              } else if (value.length <= 5) {
                                return ' length should be greater then 6';
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            initialValue: password,
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: eye,
                            decoration: InputDecoration(
                              suffixIcon: eye ? closeEye() : openEye(),

                              // hintText: "Enter your Password",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              } else if (value.length <= 3) {
                                return 'Password length should be greater then 3';
                              } else if (isStrongPass(value) == false) {
                                return "Weak Password";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_addFormkey.currentState!.validate()) {
                                  updateData(
                                      widget.userId, name, number, password);
                                }
                              },
                              child: const Text("Update"),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("reset"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  bool isStrongPass(String pass) {
    final upperCase = RegExp(r'[A-Z]');
    final lowerCase = RegExp(r'[a-z]');
    final num = RegExp(r'[0-9]');
    if (upperCase.hasMatch(pass) &&
        lowerCase.hasMatch(pass) &&
        num.hasMatch(pass)) {
      return true;
    }
    return false;
    // return upperCase.hasMatch(pass) &&
    //     lowerCase.hasMatch(pass) &&
    //     num.hasMatch(pass);
  }

  closeEye() {
    return IconButton(
      onPressed: () {
        eye = false;
        setState(() {});
      },
      icon: const Icon(Icons.visibility_off),
    );
  }

  openEye() {
    return IconButton(
        onPressed: () {
          eye = true;
          setState(() {});
        },
        icon: const Icon(Icons.visibility));
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> updateData(id, name, number, password) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$name User updated Successfully"),
      duration: Duration(milliseconds: 500),
    ));
    await students.doc(id).update(
        {'name': name, 'number': number, 'password': password}).then((value) {
      Navigator.pop(context);
    }).catchError((onError) {
      Text('failed due to $onError');
    });
  }
}
