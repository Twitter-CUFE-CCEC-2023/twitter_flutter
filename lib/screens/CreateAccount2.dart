// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CreateAccount2 extends StatelessWidget {
  const CreateAccount2({Key? key}) : super(key: key);

  static String route = '/CreateAccount2';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/twitter_logo.png',
          fit: BoxFit.cover,
          width: 50,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: null,
        ),
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 20),
            child: Text(
              "Create your account",
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(35, 20, 30, 0),
            child: SizedBox(
                width: 320,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 88, 85, 85))),
                )),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
            child: SizedBox(
                width: 320,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Phone number or email address",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 88, 85, 85))),
                )),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
            child: SizedBox(
                width: 320,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Date of birth",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 88, 85, 85))),
                )),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(35, 60, 30, 0),
              child: Text(
                "By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalising our services, including ads. Learn more. Others will be able to find you by email or phone number, when provided, unless you choose otherwise here.",
                style: TextStyle(fontSize: 18),
              )),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 300,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text("Sign Up"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))))),
          )
        ],
      ),
    ));
  }
}
