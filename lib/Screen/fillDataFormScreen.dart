import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class fillDataFormScreen extends StatefulWidget {
  const fillDataFormScreen({super.key});

  @override
  State<StatefulWidget> createState() => _fillDataFormScreen();
}

class _fillDataFormScreen extends State<fillDataFormScreen> {
  bool eye = true;
  var icon = const Icon(Icons.visibility_off);

  var namectrl = TextEditingController();
  var noctrl = TextEditingController();
  var passctrl = TextEditingController();

  var name;
  var number;
  var password;

  final _addFormkey = GlobalKey<FormState>();
  @override
  void dispose() {
    namectrl.dispose();
    noctrl.dispose();
    passctrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Member Screen"),
      ),
      body: Container(
        child: Form(
          key: _addFormkey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
            child: Container(
              child: ListView(
                children: [
                  TextFormField(
                      controller: namectrl,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
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
                      controller: noctrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter your mobile number min 6 digit",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
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
                      controller: passctrl,
                      obscureText: eye,
                      decoration: InputDecoration(
                        suffixIcon: eye
                            ? IconButton(
                                onPressed: () {
                                  eye = false;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.visibility_off),
                              )
                            : IconButton(
                                onPressed: () {
                                  eye = true;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.visibility)),
                        hintText: "Enter your Password",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
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
                        } else if (!isStrongPass(value)) {
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
                            name = namectrl.text.trim();
                            number = noctrl.text.trim();
                            password = passctrl.text.trim();
                            addUser();
                          }
                        },
                        child: const Text("Save"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          reset();
                        },
                        child: const Text("reset"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void reset() {
    namectrl.clear();
    noctrl.clear();
    passctrl.clear();
  }

  bool isStrongPass(String pass) {
    final upperCase = RegExp(r'[A-Z]');
    final lowerCase = RegExp(r'[a-z]');
    final num = RegExp(r'[0-9]');
//  final hasSpecialCharacters =
//  RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?~\\]');
    return upperCase.hasMatch(pass) &&
        lowerCase.hasMatch(pass) &&
        num.hasMatch(pass);
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection("students");
  Future addUser() async {
    reset();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 0, 102, 255),
        duration: Duration(milliseconds: 500),
        content: Text("user add successfully",
            style:
                TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)))));
    await students.add(
        {"name": name, "number": number, "password": password}).then((value) {
      Navigator.of(context).pop();
      // Navigator.pop(
      //     context, MaterialPageRoute(builder: (context) => showdetailpage()));
    });
  }
}
