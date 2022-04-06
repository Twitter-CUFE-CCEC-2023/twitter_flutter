import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_flutter/constants.dart';
import 'package:twitter_flutter/screens/changepassword.dart';
import 'package:twitter_flutter/screens/startingpage.dart';
import 'package:twitter_flutter/screens/authentication/loginPassword.dart';
import 'package:twitter_flutter/screens/authentication/loginUsername.dart';
import 'package:twitter_flutter/screens/createaccount3.dart';
import 'package:twitter_flutter/screens/authentication/HomePage.dart';

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
     DevicePreview(
    enabled: true,
    tools: const [...DevicePreview.defaultTools],
    builder: (context) =>
      MaterialApp(
    theme: generalTheme,
    useInheritedMediaQuery: true,
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: changepassword.route,
    routes: {
      // When navigating to the starting page
      changepassword.route: (context) => ChangePassword(),
      LoginUsername.route: (context) => const LoginUsername(),
      LoginPassword.route: (context) => const LoginPassword(),
    },
    ),
  ));
}
