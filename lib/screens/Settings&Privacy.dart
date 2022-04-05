// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  static String route = '/Settings';

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
            title: Column(
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Settings",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "@AccountName", //CHANGE LATER
                    style: TextStyle(
                        color: Color.fromARGB(255, 116, 104, 104),
                        fontSize: 15),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 15, top: 20),
            child: ListView(
              children: [
                MyBar(
                    Icons.person_outlined,
                    "Your Account",
                    "See infromation about your account, download an archive of your data or learn about your account deactivation options.",
                    "/YourAccount",
                    context),
                MyBar(
                    Icons.https,
                    "Security and account access",
                    "Manage your account's secuity and keep track of your account's usage, including apps that you have connected to your account.",
                    "/second",
                    context),
                MyBar(
                    Icons.monetization_on,
                    "Monetisation",
                    "See how you can make money on Twitter and manage your monetisation options. , ",
                    "/second",
                    context),
                MyBar(
                    Icons.privacy_tip,
                    "Privacy and safty",
                    "Manage what infromation you see and share on Twitter.",
                    "/second",
                    context),
                MyBar(
                    Icons.notifications_none,
                    "Notifications",
                    "Select the kinds of notification you get your activities,interests and recommendations.",
                    "/second",
                    context),
                MyBar(
                    Icons.accessibility_new_outlined,
                    "Accessibility, display and languages",
                    "Manage how Twitter contect is displayed to you.",
                    "/second",
                    context),
                MyBar(
                    Icons.more_horiz_rounded,
                    "Additional resources",
                    "Check out other places for helpful infromation to learn more about twitter products and services.",
                    "/second",
                    context),
                MyBar(
                    Icons.visibility_rounded, "Proxy", "", "/second", context),
              ],
            ),
          )),
    );
  }
}
