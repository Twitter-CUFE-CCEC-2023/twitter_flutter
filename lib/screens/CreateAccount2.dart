// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CreateAccount2 extends StatefulWidget {
  const CreateAccount2({Key? key}) : super(key: key);

  static String route = '/CreateAccount2';

  @override
  State<CreateAccount2> createState() => _CreateAccount2State();
}

class _CreateAccount2State extends State<CreateAccount2> {
  late Map<String, String> data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Container(
      color: Colors.white,
      child: SafeArea(
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
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Text(
                "Create your \naccount",
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 20, 30, 0),
              child: SizedBox(
                  width: 320,
                  child: TextField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: data['name'],
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 88, 85, 85))),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
              child: SizedBox(
                  width: 320,
                  child: TextField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: data['email'],
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 88, 85, 85))),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
              child: SizedBox(
                  width: 320,
                  child: TextField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: data['date'],
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 88, 85, 85))),
                  )),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(35, 60, 30, 0),
                child: Text(
                  "By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalising our services, including ads. Learn more. Others will be able to find you by email or phone number, when provided, unless you choose otherwise here.",
                  style: TextStyle(fontSize: 19),
                  textAlign: TextAlign.justify,
                )),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 45),
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
      )),
    );
  }
}
