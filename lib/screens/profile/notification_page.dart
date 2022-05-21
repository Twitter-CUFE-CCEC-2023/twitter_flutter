import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/profile/search_page2.dart';
import 'package:twitter_flutter/screens/utility_screens/home_side_bar.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/widgets/profile/logged_FAB_actions.dart';
import 'package:twitter_flutter/screens/starting_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  static String route = '/NotificationPage';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late UserModel userData;




  AppBar logoAppBar(
      {required double height,
        required double imageMultiplier,
        required BuildContext context,
        required String imageUrl}) {
    return AppBar(
        elevation: 0,
        bottom: TabBar(

          indicatorWeight: 3  ,
          indicatorColor: Colors.lightBlue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.blueGrey,
          labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          tabs: [


            Tab(text: 'All',),
            Tab(text: 'Mentions',),
          ],),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_sharp,
              color: Colors.blue,
              size: 0.038 * imageMultiplier * height,
            ),
            onPressed: () => {},
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () => scaffoldKey.currentState?.openDrawer(),
            child: SizedBox(
              width: 20,
              height: 20,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child:ClipRRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Message(message: 'Notification', fontSize: 20, colors: Colors.black)

                    )))));
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];

    return DefaultTabController(
        length: 2,
        child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                key: scaffoldKey,
                drawer: HomeSideBar(),
                appBar: logoAppBar(
                  height: screenHeight,
                  imageMultiplier: imageMultiplier[0],
                  context: context,
                  imageUrl: (userData.profile_image_url != "")
                      ? userData.profile_image_url
                      : "https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png",
                ),
                backgroundColor: Colors.white,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      builder: (context) {
                        return GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 0.97 * MediaQuery.of(context).size.height,
                              color: Color(0xDFFFFFFF),
                              child: FABActions(),
                            ));
                      },
                      context: context,
                      backgroundColor: Colors.white24,
                      isScrollControlled: true,
                      isDismissible: true,


                    );
                  },
                  child: Icon(Icons.add),
                ),
                body: Column(),

              ),
            )));
  }
}
