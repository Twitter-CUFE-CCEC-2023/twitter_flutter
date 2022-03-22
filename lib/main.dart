import 'package:flutter/material.dart';
import 'package:twitter_flutter/constants.dart';
import 'package:twitter_flutter/screens/authentication/loginPassword.dart';
import 'package:twitter_flutter/screens/authentication/loginUsername.dart';

void main() {
  runApp(
    MaterialApp(
      theme: generalTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginUsername.ROUTE,
      routes: {
        LoginUsername.ROUTE : (context) => const LoginUsername(),
        LoginPassword.ROUTE : (context) => const LoginPassword(),
      }
    ),
  );
}
