import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/starting_page.dart';
import 'package:twitter_flutter/screens/authentication/login_password.dart';
import 'package:twitter_flutter/screens/authentication/login_username.dart';
import 'package:twitter_flutter/screens/create_account/create_account_1.dart';
import 'package:twitter_flutter/screens/create_account/create_account_3.dart';
import 'package:twitter_flutter/screens/create_account/create_account_2.dart';
import 'package:twitter_flutter/screens/create_account/create_account_4.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';
import 'package:twitter_flutter/screens/profile_management/settings_and_privacy.dart';
import 'package:twitter_flutter/screens/profile_management/your_account.dart';
import 'package:twitter_flutter/screens/profile/profile.dart';
import 'package:twitter_flutter/screens/profile/edit_profile.dart';
import 'package:twitter_flutter/screens/profile_management/change_password.dart';
import 'package:twitter_flutter/screens/profile/home_page.dart';

void main() {
  // To set the status bar to be transparent and text in status bar to be dark
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark),
  );
  runApp(
    /*DevicePreview(
    enabled: true,
    tools: const [...DevicePreview.defaultTools],
    builder: (context) =>*/
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: generalTheme,
      useInheritedMediaQuery: true,
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: StartingPage.route,
      routes: {
        // When navigating to the starting page
        StartingPage.route: (context) => const StartingPage(),
        ChangePassword.route: (context) => const ChangePassword(),
        LoginUsername.route: (context) => const LoginUsername(),
        LoginPassword.route: (context) => const LoginPassword(),
        CreateAccount1.route: (context) => const CreateAccount1(),
        CreateAccount2.route: (context) => const CreateAccount2(),
        CreateAccount3.route: (context) => const CreateAccount3(),
        YourAccount.route: (context) => const YourAccount(),
        Settings.route: (context) => const Settings(),
        TermsOfService.route: (context) => const TermsOfService(),
        CreateAccount4.route: (context) => const CreateAccount4(),
        UserProfile.route: (context) => const UserProfile(),
        EditProfile.route: (context) => const EditProfile(),
        HomePage.route: (context) => const HomePage(),
      },
    ),
    //),
  );
}
