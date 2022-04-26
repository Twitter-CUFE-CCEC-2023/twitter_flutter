import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/profile/tweets_widget.dart';
import 'package:twitter_flutter/screens/authentication/Icons.dart';
import 'package:twitter_flutter/screens/profile/profile.dart';

import 'package:twitter_flutter/screens/profile_management/change_password.dart';
import 'package:twitter_flutter/screens/utility_screens/home_side_bar.dart';

import '../../blocs/loginStates/login_bloc.dart';
import '../../blocs/loginStates/login_states.dart';
import '../../widgets/profile/logged_FAB_actions.dart';
import '../starting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String route = '/HomePage';
  static const String username =
      "Ahmedhgjghjgfhjfghjfghjfghjfghjgfhjgfhjfghjgffghfdghdfghdzkjcflhgbnlkdsjfhglkjdsfhglkdfhgkdljfh";

  static const String tweetTexts =
      "This is a tweetfgklh jdfklg;h jflk;gjh;flk gjhlfkdgjhlfgh jflgkhl kfjgh;sdlkhf jdsfg;hsdklf;gj dsflk jhgsdklf ghdsjlkf hgdfjslk hgdsjklf ghdfjskl hdsjlfk ghsdjklf ghsdjklf ghjdsklf ghsdjlkfg hsdjlkf ghdsjklf jhgsdljkf gljkdf gjhkld;f gjds;lk gdlfjkgh;slk djhdf;klghd l;kfjhg;lsda hfdfl;kjg hsd;fgh;d flkg";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late UserModel userData;
  BottomNavigationBar Bottom(
      {required double height, required double imageMultiplier}) {
    return BottomNavigationBar(
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
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
            label: 'Search'),
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

  AppBar logoAppBar(
      {required double height,
      required double imageMultiplier,
      required BuildContext context,
      required String imageUrl}) {
    return AppBar(
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.star_border,
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
      title: Image.asset(
        'assets/images/bluetwitterlogo64.png',
        width: 0.083 * imageMultiplier * height, // 65
        height: 0.083 * imageMultiplier * height, // 65
        cacheHeight: 70,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginBloc>().state;

    if (state is LoginSuccessState) {
      userData = state.userdata;
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, StartingPage.route, (route) => false);
      //TODO:Log the user out in case of the state is not login success or the access token is expired
    }

    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    print(screenHeight);
    print(screenWidth);
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        imageMultiplier[0] = 1;

        fontSizeMultiplier[0] = 1;
      } else {
        imageMultiplier[0] = 1.8;

        fontSizeMultiplier[0] = 2;
      }

      return Container(
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
                  isDismissible: true,
                  isScrollControlled: true,
                );
              },
              child: Icon(Icons.add),
            ),
            body: GestureDetector(
              onPanUpdate: ((details) {
                if (details.delta.dx > 5) {
                  scaffoldKey.currentState?.openDrawer();
                }
              }),
              child: ListView(
                children: [
                  tweet(
                    userProfilePicture:
                        "https://www.washingtonpost.com/rf/image_1484w/2010-2019/WashingtonPost/2017/03/28/Local-Politics/Images/Supreme_Court_Gorsuch_Moments_22084-70c71-0668.jpg?t=20170517",
                    user_Name: "Johnny",
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    imageCount: 0,
                    CommentCount: 2,
                    retweetCount: 4,
                    likeCount: 7,
                    tweet_Text: "Hello guys, How are you?",
                  ),
                  tweet(
                      userProfilePicture:
                          "https://www.howfamous.is/celebrity/chris-hemsworth/200/220.jpg?lang=en",
                      user_Name: "Chris",
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imageCount: 1,
                      CommentCount: 300,
                      retweetCount: 40,
                      likeCount: 77,
                      tweet_Text: "Stay tuned for the new thor movie!",
                      imageOne:
                          "https://m.media-amazon.com/images/I/81xPLSOkvJL._SS500_.jpg"),
                  tweet(
                      userProfilePicture:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOAAggR0b98DcebtjSUaSn8yMSQAhoOrRdRA&usqp=CAU",
                      user_Name: "Thomas brush",
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imageCount: 2,
                      CommentCount: 60,
                      retweetCount: 20,
                      likeCount: 34,
                      imageOne:
                          "https://www.giantbomb.com/a/uploads/scale_small/8/87790/3005649-box_ps.png",
                      imageTwo:
                          "https://assets-prd.ignimgs.com/2020/07/06/neversong-button-fin-1594055577425.jpg"),
                  tweet(
                      userProfilePicture:
                          "https://yt3.ggpht.com/ytc/AKedOLRTZPbxwPklr6CPZy4TcMNwLAgxdoJ2gyOXbq2fXw=s900-c-k-c0x00ffffff-no-rj",
                      user_Name: "My Name is Mohamed Ahmed Mohamed",
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imageCount: 3,
                      CommentCount: 10,
                      retweetCount: 30,
                      likeCount: 23,
                      tweet_Text: "Check out my newest videos",
                      imageOne:
                          "https://i.ytimg.com/vi/kfWfMvA0heY/hqdefault.jpg?sqp=-oaymwEjCPYBEIoBSFryq4qpAxUIARUAAAAAGAElAADIQj0AgKJDeAE=&rs=AOn4CLBgf-z5Mh91YfdsjSg_afubvzJtXQ",
                      imageTwo:
                          "https://i.ytimg.com/vi/f3UZ0v1icmQ/maxresdefault.jpg",
                      imageThree:
                          "https://i.ytimg.com/vi/HvKbsCowLVU/maxresdefault.jpg"),
                  tweet(
                      userProfilePicture:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQmyyuPaZzRHAIpnCtIWLhyIoghmcPu3dZxQ&usqp=CAU",
                      user_Name: "Activation",
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imageCount: 4,
                      CommentCount: 20,
                      retweetCount: 40,
                      likeCount: 200,
                      tweet_Text:
                          "Check out the newest mapes in the game (new enemies added, new characters, and new guns)",
                      imageOne:
                          "https://cdn.vox-cdn.com/thumbor/v4CFyRhEvWB9Ct_YeP8tEH0i2xo=/0x0:1920x1080/1200x800/filters:focal(381x260:687x566)/cdn.vox-cdn.com/uploads/chorus_image/image/68764501/FirebaseZ2.0.jpg",
                      imageTwo:
                          "https://imageio.forbes.com/specials-images/imageserve/60e7537510a61c82e917781b/BOCW-Zombies-Story-So-Far-TOUT/960x0.jpg?fit=bounds&format=jpg&width=960",
                      imageThree:
                          "https://gamingintel.com/wp-content/uploads/2020/11/Black-Ops-Cold-War-New-Map-Vietnam-Zombies.jpg",
                      imageFour:
                          "https://charlieintel.com/wp-content/uploads/2021/06/mauer-der-toten-1.jpg"),
                  tweet(
                    userProfilePicture:
                        "https://pbs.twimg.com/media/E9gpNWsXEAYir33.jpg",
                    user_Name: "Maged Alosali",
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    tweet_Text: "Check the new gif",
                    imageCount: 1,
                    CommentCount: 2,
                    retweetCount: 3,
                    likeCount: 4,
                    imageOne:
                        "https://c.tenor.com/EWiHVwPUEOoAAAAC/coxa-among-us.gif",
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Bottom(
                height: screenHeight, imageMultiplier: imageMultiplier[0]),
          ),
        ),
      );
    });
  }
}
