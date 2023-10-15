import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class userLogin extends StatefulWidget {
  const userLogin({super.key});

  @override
  State<userLogin> createState() => _userLoginState();
}

class _userLoginState extends State<userLogin> {
  @override
  void initState() {
    super.initState();
  }

  var email;
  var password;
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("hello"),
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 300),
              const Text(
                "Sign in",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(width: 1.5, color: Colors.black)),
                child: Form(
                  key: formkey,
                  child: Column(children: [
                    Row(children: [
                      Padding(
                          padding: EdgeInsets.only(right: 20, left: 30),
                          child: Icon(Icons.email)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: TextFormField(
                            controller: emailCtrl,
                          ),
                        ),
                      ),
                    ]),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 30, right: 20),
                    //   child: Icon(Icons.email),
                    // ),

                    // Icon(Icons.email),
                    // SizedBox(width: 10),
                    // TextField(),

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Icon(Icons.lock),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: TextFormField(
                              controller: passCtrl,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    email = emailCtrl.text.trim();
                    password = passCtrl.text.trim();
                    signup();
                  },
                  child: Text("Saved"))
            ],
          ),
        ),
      ),
    );
  }

  void signup() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("user singning"))),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Week passowrd")));
      } else if (e.code == "email-already-in-use") {
        print("This email already use in");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("this email already use")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 175, 76, 87),
            content: Text("$e this type of error"),
          ),
        );
      }
    }
  }
}
