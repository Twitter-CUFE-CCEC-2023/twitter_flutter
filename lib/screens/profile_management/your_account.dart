// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/screens/profile_management/change_password.dart';
import 'package:twitter_flutter/screens/utility_screens/home_side_bar.dart';

import '../../blocs/userManagement/user_management_bloc.dart';
import '../../blocs/userManagement/user_management_states.dart';
import '../../models/objects/user.dart';
import '../starting_page.dart';
import 'change_password.dart';

class YourAccount extends StatefulWidget {
  const YourAccount({Key? key}) : super(key: key);
  static String route = '/YourAccount';

  @override
  State<YourAccount> createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  late UserModel userData;
  @override
  Widget build(BuildContext context) {
    var state = context.watch<UserManagementBloc>().state;

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
          drawer: HomeSideBar(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your account",
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
          ),
          body: ListView(
            children: [
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, right: 15, bottom: 30),
                child: const Text(
                  "See infromation about your account, download an archive of your data or learn about your account deactivation options.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 95, 110, 100),
                  ),
                ),
              ),
              //TODO: Add account infromation root to the function call
              buildItem(Icons.person_outlined, "Account Infromation", context,
                  Text2:
                      "see infomation about your account, download an archive of your data or learn about your account deactivation options."),
              buildItem(Icons.https_outlined, "Change your password", context,
                  Text2: "Change your password at any time",route: ChangePassword.route),
              buildItem(Icons.download_outlined,
                  "Download an archive of your data", context,
                  Text2:
                      "Get insights into the type of infromation stored for your account"),
              buildItem(Icons.heart_broken_outlined, "Deavtivate your account",
                  context,
                  Text2: "find out how can you deavtivate your account")
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildItem(IconData myIcon, String Text1, BuildContext context,
    {String? Text2, String? route}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            myIcon,
            color: const Color.fromARGB(255, 95, 76, 76),
            size: 30,
          ),
        ],
      ),
      title: Text(
        Text1,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: (Text2 != null)
          ? Text(
              Text2,
              style: const TextStyle(
                  color: Color.fromARGB(255, 143, 119, 119), fontSize: 14.5),
            )
          : null,
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
    ),
  );
}
