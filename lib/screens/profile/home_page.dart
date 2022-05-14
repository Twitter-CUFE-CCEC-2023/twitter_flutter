import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweet_cubit.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/models/objects/mediaModel.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/authentication/Icons.dart';
import 'package:twitter_flutter/screens/utility_screens/home_side_bar.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/widgets/profile/logged_FAB_actions.dart';
import 'package:twitter_flutter/screens/starting_page.dart';
import 'package:twitter_flutter/widgets/tweet.dart';
import '../../blocs/tweetsManagement/tweet_cubit.dart';
import '../../blocs/tweetsManagement/tweet_cubit.dart';
import '../../blocs/tweetsManagement/tweets_managment_bloc.dart';
import '../../blocs/tweetsManagement/tweets_managment_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String route = '/HomePage';

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
    late List<TweetWidget> tweetsList = [];

    var tweet_Cubit = context.watch<tweetCubit>();

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
              child: BlocListener<TweetsManagementBloc, TweetsManagementStates>(
                listenWhen: (previous, current) =>
                    current is SuccessPostingTweet ||
                    current is FailurePostingTweet,
                listener: (context, state) {
                  if (state is SuccessPostingTweet) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Failed to post tweet"),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (state is FailurePostingTweet) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Tweet posted successfully"),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    await tweet_Cubit.Refresh(
                        access_token: bloc.access_token,
                        count: 3,
                        page: tweet_Cubit.pageNumber);
                    tweet_Cubit.pageNumber++;
                  },
                  child: BlocConsumer<tweetCubit, TweetsManagementStates>(
                      buildWhen: (previous, current) =>
                          current is! TweetsRefreshLoadingState,
                      listener: (context, state) {
                        if (state is TweetsFetchingFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is TweetsIntialState) {
                          tweet_Cubit.onInit(
                              access_token: bloc.access_token,
                              count: 10,
                              page: tweet_Cubit.pageNumber);
                          tweet_Cubit.pageNumber++;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TweetsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is TweetsFetchingSuccess) {
                          for (var tweet in tweet_Cubit.homeList) {
                            tweetsList.insert(0, TweetWidget(tweetData: tweet));
                          }
                        }
                        return ListView.builder(
                          reverse: true,
                          itemCount: tweetsList.length,
                          itemBuilder: (context, index) {
                            return tweetsList[index];
                          },
                        );
                      }),
                ),
              ),
            ),
            bottomNavigationBar: Bottom(
                height: screenHeight, imageMultiplier: imageMultiplier[0]),
          ),
        ));
  }
}
