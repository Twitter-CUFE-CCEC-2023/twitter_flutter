import 'package:flutter/material.dart';
import 'package:twitter_flutter/screens/firstscreen.dart';
import 'package:twitter_flutter/screens/secondscreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: FirstScreen.route,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        FirstScreen.route: (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        SecondScreen.route: (context) => const SecondScreen(),
      },
    ),
  );
}
