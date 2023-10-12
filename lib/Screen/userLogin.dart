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

  @override
  void dispose() {
    super.dispose();
  }

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
                          child: TextFormField(),
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
                            child: TextFormField(),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
