import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_flutter/constants.dart';
import 'package:twitter_flutter/screens/startingpage.dart';
import 'package:twitter_flutter/screens/authentication/loginPassword.dart';
import 'package:twitter_flutter/screens/authentication/loginUsername.dart';
import 'package:twitter_flutter/screens/CreateAccount1.dart';
import 'package:twitter_flutter/screens/CreateAccount2.dart';
import 'package:twitter_flutter/screens/Settings&Privacy.dart';
import 'package:twitter_flutter/screens/YourAccount.dart';

void main() {
  // To set the status bar to be transparent and text in status bar to be dark
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(
      /*DevicePreview(
    enabled: true,
    tools: const [...DevicePreview.defaultTools],
    builder: (context) => */
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: generalTheme,
        useInheritedMediaQuery: true,
        initialRoute: StartingPage.route,
        routes: {
          StartingPage.route: (context) => const StartingPage(),
          LoginUsername.route: (context) => const LoginUsername(),
          LoginPassword.route: (context) => const LoginPassword(),
          CreateAccount1.route: (context) => const CreateAccount1(),
          CreateAccount2.route: (context) => const CreateAccount2(),
          YourAccount.route: (context) => const YourAccount(),
          Settings.route: (context) => const Settings()
        },
    //),
  ));
}
