import 'package:flutter/material.dart';
import 'package:twitter_flutter/screens/CreateAccount1.dart';
import 'package:twitter_flutter/screens/CreateAccount2.dart';
import 'package:twitter_flutter/screens/Settings&Privacy.dart';
import 'package:twitter_flutter/screens/YourAccount.dart';
import 'package:twitter_flutter/screens/firstscreen.dart';
import 'package:twitter_flutter/screens/secondscreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: Settings.route,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        FirstScreen.route: (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        SecondScreen.route: (context) => const SecondScreen(),

        CreateAccount1.route: ((context) => const CreateAccount1()),
        CreateAccount2.route: ((context) => const CreateAccount2()),
        Settings.route: ((context) => const Settings()),
        YourAccount.route: ((context) => const YourAccount()),
      },
    ),
  );
}
