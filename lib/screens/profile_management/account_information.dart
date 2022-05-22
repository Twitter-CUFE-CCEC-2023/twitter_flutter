// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';
import '../../blocs/userManagement/user_management_bloc.dart';
import '../../blocs/userManagement/user_management_states.dart';
import '../../widgets/authentication/constants.dart';
import '../starting_page.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);
  static String route = '/Account';

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late UserModel userData;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        fontSizeMultiplier[0] = 1;
      } else {
        fontSizeMultiplier[0] = 2;
      }
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
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Column(
                  children: [
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Account",
                        style: TextStyle(color: Colors.black,fontSize:  0.0252* fontSizeMultiplier[0] * screenHeight,),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "@" + userData.username.toString(),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 116, 104, 104),
                            fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight),
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
              body: SingleChildScrollView(
                child: Container(
                    color: Colors.blueGrey.shade50,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text('  Login and security',
                                style: TextStyle(
                                    fontSize: 0.0252* fontSizeMultiplier[0] * screenHeight,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            color: Colors.white,
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  buildItem1("Username", context,
                                      Text2: "@" + userData.username.toString(),font2: 0.0192 * fontSizeMultiplier[0] * screenHeight,font1: 0.0212* fontSizeMultiplier[0] * screenHeight,
                                      route: "/Followers"),
                                  buildItem1("Phone", context,
                                      Text2: 'Add', route: "/VerifyPassword",font2:0.0192 * fontSizeMultiplier[0] * screenHeight,font1: 0.0212* fontSizeMultiplier[0] * screenHeight),
                                  buildItem1("Email", context,
                                      Text2: userData.email,font2:0.0192 * fontSizeMultiplier[0] * screenHeight,font1:0.0212* fontSizeMultiplier[0] * screenHeight ,
                                      route: "/VerifyPassword2"),
                                  buildItem1("Password", context,font1: 0.0212* fontSizeMultiplier[0] * screenHeight,
                                      route: "/ChangePassword"),
                                  buildItem1(
                                    "Security",
                                    //TODO: Add Security page
                                    context,font1: 0.0212* fontSizeMultiplier[0] * screenHeight
                                  ),
                                  buildItem1(
                                    "Verification request", context,font1: 0.0212* fontSizeMultiplier[0] * screenHeight
                                    //TODO: Add Verification request page
                                  )
                                ],
                              ).toList(),
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 10),
                            child: Text('  Data and permissions',
                                style: TextStyle(
                                    fontSize: 0.0252* fontSizeMultiplier[0] * screenHeight,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            color: Colors.white,
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  buildItem2(
                                      "Country",
                                      context,
                                      "Egypt\n\nSelect country you live in. ",
                                      'Learn more',font1: 0.0212* fontSizeMultiplier[0] * screenHeight,font2: 0.0192* fontSizeMultiplier[0] * screenHeight,
                                      route: '/ChangeCountry'),
                                  buildItem1(
                                    "Your Twitter data",
                                    context,font1: 0.0212* fontSizeMultiplier[0] * screenHeight,
                                    //TODO: Add Your Twitter data page
                                  ),
                                  buildItem1(
                                    "Apps and sessions",
                                    context,font1: 0.0212* fontSizeMultiplier[0] * screenHeight,
                                    //TODO: Add Apps and sessions page
                                  ),
                                ],
                              ).toList(),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            child:
                                buildItem1('Deactivate your account',
                                  context,font1: 0.0212* fontSizeMultiplier[0] * screenHeight,
                                  //TODO: Add Deactivate your account page
                                ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            child: buildItem1('Log out',
                                context,font1: 0.0212* fontSizeMultiplier[0] * screenHeight,
                                color: Colors.red),
                          ),
                          Container(
                            height: 10,
                          )
                        ])),
              )),
        ));
  }
    );}}

Widget buildItem1(String Text1, BuildContext context,
    {String? Text2, String? route, Color? color,double? font1, double? font2}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 0),
    child: ListTile(
      focusColor: Colors.blue,
      title: Text(
        Text1,
        style: TextStyle(fontSize: font1, color: color),
      ),
      subtitle: (Text2 != null)
          ? Text(
              Text2,
              style:  TextStyle(
                  color: Color.fromARGB(255, 143, 119, 119), fontSize: font2),
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

Widget buildItem2(
    String Text1, BuildContext context, String Text2, String Text3,
    {String? route, Color? color, double? font2, double? font1}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 0),
    child: ListTile(
      title: Text(
        Text1,
        style: TextStyle(fontSize: font1, color: color),
      ),
      subtitle: Text.rich(
        TextSpan(
          text: Text2,
          style: TextStyle(fontSize: font2),
          children: <TextSpan>[
            TextSpan(
                text: Text3, style: const TextStyle(color: Colors.blueAccent),recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(
                  context,
                  TermsOfService.route,
                  arguments: WebViewArgs('https://help.twitter.com/en/managing-your-account/how-to-change-country-settings'),);

              },)
          ],
        ),
      ),
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
    ),
  );
}
