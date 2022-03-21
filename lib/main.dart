import 'package:flutter/material.dart';
import 'package:twitter_flutter/constants.dart';
import 'package:twitter_flutter/screens/login.dart';

void main() {
  runApp(
    MaterialApp(
      theme: generalTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginUsername.route,
      routes: {
        LoginUsername.route : (context) => const LoginUsername(),
      }
    ),
  );
}
