// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateAccount1 extends StatelessWidget {
  const CreateAccount1({Key? key}) : super(key: key);

  static String route = '/CreateAccount1';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            // IMPORTANT: Fix assets issue
            'assets/twitter_logo.png',
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
              padding: EdgeInsets.fromLTRB(35, 150, 30, 0),
              child: SizedBox(
                  width: 320,
                  child: TextField(
                    maxLength: 50,
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
                    decoration: InputDecoration(
                        hintText: "Phone number or email address",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 88, 85, 85))),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 30, 0),
              child: SizedBox(
                  width: 320,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1950, 1, 1),
                          maxTime: DateTime.now(),
                          currentTime: DateTime.now(),
                          locale: LocaleType.en);
                    },
                    decoration: const InputDecoration(
                        hintText: "Date of birth",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 88, 85, 85))),
                  )),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(250, 180, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/CreateAccount2');
                  },
                  child: const Text("next"),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0))))),
            )
          ],
        ),
      ),
    );
  }
}
