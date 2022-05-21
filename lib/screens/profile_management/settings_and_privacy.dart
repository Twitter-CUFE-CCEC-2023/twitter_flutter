// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/profile_management/your_account.dart';
import 'package:twitter_flutter/screens/profile_management/account_information.dart';
import '../../blocs/userManagement/user_management_bloc.dart';
import '../../blocs/userManagement/user_management_states.dart';
import '../starting_page.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static String route = '/Settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late UserModel userData;
  @override
  Widget build(BuildContext context) {
    var state = context.watch<UserManagementBloc>().state;
    //TODO: Add other states 
    if (state is LoginSuccessState) {
      userData = state.userdata;
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, StartingPage.route, (route) => false);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Settings",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "@" + userData.username.toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 116, 104, 104),
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(right: 15, top: 20),
              child: ListView(
                children: [
                  buildItem(Icons.person_outlined, "Your Account", context,
                      Text2:
                          "See infromation about your account, download an archive of your data or learn about your account deactivation options.",
                      route: "/YourAccount"),
                  buildItem(Icons.https, "Security and account access", context,
                      Text2:
                          "Manage your account's secuity and keep track of your account's usage, including apps that you have connected to your account."),
                  buildItem(Icons.monetization_on, "Monetisation", context,
                      Text2:
                          "See how you can make money on Twitter and manage your monetisation options. , "),
                  buildItem(Icons.privacy_tip, "Privacy and safty", context,
                      Text2:
                          "Manage what infromation you see and share on Twitter."),
                  buildItem(Icons.notifications_none, "Notifications", context,
                      Text2:
                          "Select the kinds of notification you get your activities,interests and recommendations."),
                  buildItem(Icons.accessibility_new_outlined,
                      "Accessibility, display and languages", context,
                      Text2: "Manage how Twitter contect is displayed to you."),
                  buildItem(
                      Icons.more_horiz_rounded, "Additional resources", context,
                      Text2:
                          "Check out other places for helpful infromation to learn more about twitter products and services."),
                  buildItem(Icons.visibility_rounded, "Proxy", context),
                ],
              ),
            )),
      ),
    );
  }
}
