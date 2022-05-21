import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/authentication/Icons.dart';
import 'package:twitter_flutter/screens/profile/home_page.dart';
import 'package:twitter_flutter/screens/profile/notification_page.dart';
import 'package:twitter_flutter/screens/profile/search_page.dart';
import 'package:twitter_flutter/screens/utility_screens/home_side_bar.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/screens/starting_page.dart';

class PreHomePage extends StatefulWidget {
  const PreHomePage({Key? key}) : super(key: key);
  static String route = '/PreHomePage';

  @override
  State<PreHomePage> createState() => _PreHomePageState();
}

class _PreHomePageState extends State<PreHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late UserModel userData;
  int _currentIndex =0;

  List<Widget> _widgetOptions=<Widget>[
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SearchPage(),


  ];
  BottomNavigationBar Bottom(
      {required double height, required double imageMultiplier}) {
    return BottomNavigationBar(
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
      onTap: _changeItem,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.download,
              size: 0.033 * imageMultiplier * height,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(
            MyFlutterApp.saved,
            size: 0.033 * imageMultiplier * height,
            color: Colors.black,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.home,
              size: 0.033 * imageMultiplier * height,
              color: Colors.black,
            ),
            backgroundColor: Colors.black,
            label: 'Notification'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.mail_outline,
              size: 0.033 * imageMultiplier * height,
              color: Colors.black,
            ),
            backgroundColor: Colors.black,
            label: 'Messages'),
      ],
    );
  }


  void _changeItem(int value){
    setState(() {
      _currentIndex = value;
    });
  }

  Widget Message(
      {required String message,
        required double fontSize,
        required Color colors}) {
    return AutoSizeText(
      message,
      style: TextStyle(fontSize: fontSize, color: colors),
    );
  }

  Future<void> _faildAuthentication(context) async {
    await Future.delayed(Duration(seconds: 0)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, StartingPage.route, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<UserManagementBloc>();

    if (bloc.state is LoginSuccessState ||
        bloc.state is VerificationSuccessState) {
      userData = bloc.userdata;
    } else {
      return FutureBuilder(
          builder: (context, _) {
            return Container(
              color: Colors.lightBlue,
            );
          },
          future: _faildAuthentication(context));

      //TODO:Log the user out in case of the state is not login success or the access token is expired
    }
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: HomeSideBar(),
            backgroundColor: Colors.white,
            body: _widgetOptions.elementAt(_currentIndex),
            bottomNavigationBar: Bottom(
                height: screenHeight, imageMultiplier: imageMultiplier[0]),
          ),
        ));
  }
}
