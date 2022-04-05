// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';

class YourAccount extends StatelessWidget {
  const YourAccount({Key? key}) : super(key: key);
  static String route = '/YourAccount';

  static Padding MyBar(IconData MyIcon, String Text1, String Text2,
      String NextPage, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, NextPage),
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
              child: Icon(
                MyIcon,
                color: const Color.fromARGB(255, 95, 76, 76),
                size: 30,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Text1,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    Text2,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 143, 119, 119),
                        fontSize: 15),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your account",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "@username", //CHANGE LATTER
                  style: TextStyle(
                      color: Color.fromARGB(255, 116, 104, 104), fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 15, bottom: 30),
              child: const Text(
                "See infromation about your account, download an archive of your data or learn about your account deactivation options.",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 95, 110, 100),
                ),
              ),
            ),
            MyBar(Icons.person_outlined, "Account Infromation", "see info",
                "/second", context),
            MyBar(Icons.https_outlined, "Change your password",
                "Change your password at any time", "/second", context),
            MyBar(
                Icons.download_outlined,
                "Download an archive of your data",
                "Get insights into the type of infromation stored for your account",
                "/second",
                context),
            MyBar(
                Icons.heart_broken_outlined,
                "Deavtivate your account",
                "find out how can you deavtivate your account",
                "/second",
                context)
          ],
        ),
      ),
    );
  }
}
