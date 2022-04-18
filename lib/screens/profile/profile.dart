import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/blocs/loginStates/login_states.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/likes.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/media.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/tweets.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/tweets_and_replies.dart';
import 'package:twitter_flutter/screens/starting_page.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';

import '../../blocs/loginStates/login_bloc.dart';
import '../utility_screens/opened_image.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  static const route = "/userProfile";

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserModel userData;
  late SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginBloc>().state;

    if (state is LoginSuccessState) {
      userData = state.userdata;
    } else {
      Navigator.pushNamedAndRemoveUntil(context, StartingPage.route, (route) => false);
      //TODO:Log the user out in case of the state is not login success
    }
    var orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  coverImageURL: userData.cover_image_url,
                  profileImageURL: userData.profile_image_url,
                  name: userData.name,
                  tweetCount: userData.tweets_count,
                  expandedHeight: orientation == Orientation.portrait
                      ? 0.35 * width
                      : 0.625 * height),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(top: 3),
                color: Colors.white,
                child: SizedBox(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        child: const Text("Edit Profile"),
                        style: outlinedButtonsStyle,
                        onPressed: () => print("Edit Profile Pressed"),
                      ),
                    ],
                  ),
                )),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: SizedBox(
                    child: _buildUserData(
                  name: userData.name,
                  username: userData.username,
                  birthday: 5,
                  birthmonth: "July",
                  birthyear: 1993,
                  followers: userData.followers_count,
                  following: userData.following_count,
                  joinMonth: DateFormat('MMMM')
                      .format(DateTime(0, userData.created_at.month)),
                  joinYear: userData.created_at.year,
                )),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: TabBar(
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    tabs: [
                      Tab(
                          child: Text(
                        "Tweets",
                        style: TextStyle(color: Colors.black),
                      )),
                      Tab(
                          child: Text(
                        "Tweets & replies",
                        style: TextStyle(color: Colors.black),
                      )),
                      Tab(
                          child: Text(
                        "Media",
                        style: TextStyle(color: Colors.black),
                      )),
                      Tab(
                          child: Text(
                        "Likes",
                        style: TextStyle(color: Colors.black),
                      )),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                    elevation: 5,
                    backgroundColor: Colors.lightBlue,
                  ),
                  body: TabBarView(
                    children: [Tweets(), TweetsAndReplies(), Media(), Likes()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildUserData(
      {required name,
      required username,
      required birthday,
      required birthmonth,
      required birthyear,
      required joinMonth,
      required joinYear,
      required following,
      required followers}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text("@$username"),
          SizedBox(
            height: 17,
          ),
          Row(
            children: [
              Icon(
                Icons.bedroom_baby_outlined,
                color: Colors.black45,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Born $birthday  $birthmonth  $birthyear",
                style: TextStyle(color: Colors.black45),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.date_range_outlined,
                color: Colors.black45,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Joined  $joinMonth  $joinYear",
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "$following",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                " Following",
                style: TextStyle(color: Colors.black45),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "$followers",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                " Followers",
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final coverImageURL;
  final profileImageURL;
  final name;
  final tweetCount;

  MySliverAppBar(
      {required this.expandedHeight,
      required this.coverImageURL,
      required this.profileImageURL,
      required this.name,
      required this.tweetCount});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        _buildCoverPhoto(
            context: context,
            imageUrl: coverImageURL,
            shrinkOffset: shrinkOffset),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            left: 13),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.search_outlined, color: Colors.white),
            right: 60),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            right: 13),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            left: 13,
            callback: () => Navigator.pop(context)),
        _buildAppbarText(
            //username
            username: name,
            screenWidth: width,
            shrinkOffset: shrinkOffset,
            fontSize: 20,
            top: 10),
        _buildAppbarText(
            //tweet Count
            username: "$tweetCount Tweets",
            screenWidth: width,
            shrinkOffset: shrinkOffset,
            fontSize: 15,
            top: 35),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.search_outlined, color: Colors.white),
            right: 60,
            callback: () => print("Search Pressed")),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            right: 13,
            callback: () => print("Menu Pressed")),
        _buildProfilePhoto(
            imageUrl: profileImageURL,
            screenWidth: width,
            shrinkOffset: shrinkOffset,
            context: context),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;
  @override
  double get minExtent => kToolbarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  double profileImageSize(BuildContext context, double opacityFactor,
      double shrinkOffset, double maxSize,
      {bool sized = false}) {
    var orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return (((orientation == Orientation.portrait ? width : height) /
                    opacityFactor >
                maxSize)
            ? maxSize
            : (orientation == Orientation.portrait ? width : height) /
                opacityFactor) *
        (sized ? (1 - shrinkOffset / expandedHeight) : 1);
  }

  Widget _buildBarIcon(
      {double? left,
      double? right,
      required double top,
      required Icon icon,
      void Function()? callback}) {
    return Positioned(
        left: left,
        right: right,
        top: top,
        child: GestureDetector(
          onTap: callback,
          child: CircleAvatar(
              backgroundColor: Colors.black45, radius: 15, child: icon),
        ));
  }

  Widget _buildAppbarText(
      {required String username,
      required double screenWidth,
      required double shrinkOffset,
      required double top,
      required double fontSize}) {
    return Positioned(
        left: screenWidth / 5,
        top: top,
        child: Opacity(
          opacity: shrinkOffset / expandedHeight > 0.8 ? 1 : 0,
          child: Text(
            username,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
            ),
          ),
        ));
  }

  Widget _buildProfilePhoto(
      {required String imageUrl,
      required screenWidth,
      required double shrinkOffset,
      required BuildContext context}) {
    return Positioned(
      top: expandedHeight / 2 - shrinkOffset,
      left: screenWidth / 25,
      child: Opacity(
        opacity: (1 - shrinkOffset / expandedHeight),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OpenedImage(imageURL: profileImageURL))),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              height: expandedHeight,
              width:
                  profileImageSize(context, 3.5, shrinkOffset, 76, sized: true),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: profileImageSize(context, 7.5, shrinkOffset, 35),
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverPhoto(
      {required BuildContext context,
      required String imageUrl,
      required double shrinkOffset}) {
    return Opacity(
      opacity: 1 - shrinkOffset / expandedHeight,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEditProfileButton(
      {required screenWidth,
      required double shrinkOffset,
      required BuildContext context}) {
    return Positioned(
      top: expandedHeight / 1 - shrinkOffset,
      right: screenWidth / 25,
      child: OutlinedButton(
        child: const Text("Edit Profile"),
        style: outlinedButtonsStyle,
        onPressed: () => print("Edit Profile Pressed"),
      ),
    );
  }
}
