import 'package:flutter/material.dart';
import 'package:twitter_flutter/screens/firstscreen.dart';
import 'package:twitter_flutter/screens/secondscreen.dart';
import 'package:twitter_flutter/screens/startingpage.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: StartingPage.route,
      routes: {
        // When navigating to the starting page
        StartingPage.route: (context) => const StartingPage(),
        // When navigating to the "/" route, build the FirstScreen widget.
        FirstScreen.route: (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        SecondScreen.route: (context) => const SecondScreen(),
      },
    ),
  );
}
