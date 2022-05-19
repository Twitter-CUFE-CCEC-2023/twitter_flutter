import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/profile/pre_edit_profile.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/likes.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/media.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/tweets.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/tweets_and_replies.dart';
import 'package:twitter_flutter/screens/starting_page.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/widgets/profile/logged_FAB_actions.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import '../utility_screens/opened_image.dart';

class UserProfile extends StatefulWidget  {
  const UserProfile({Key? key}) : super(key: key);
  static const route = "/userProfile";

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserModel userData;
  late SharedPreferences pref;

  Future<void> _faildAuthentication(context) async {
    await Future.delayed(Duration(seconds: 0)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, StartingPage.route, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    var userBloc = context.watch<UserManagementBloc>();

    if (userBloc.state is LoginSuccessState ||
        userBloc.state is VerificationSuccessState) {
      userData = userBloc.userdata;
    } else {
      return FutureBuilder(
          builder: (context, _) {
            return Container(
              color: Colors.lightBlue,
            );
          },
          future: _faildAuthentication(context));
    }
    var orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
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
                          onPressed: () =>
                              Navigator.pushNamed(context, PreEditProfile.route),
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
                    birthday: userData.birth_date.day,
                    birthmonth: DateFormat('MMMM')
                        .format(DateTime(0, userData.birth_date.month)),
                    birthyear: userData.birth_date.year,
                    followers: userData.followers_count,
                    following: userData.following_count,
                    joinMonth: DateFormat('MMMM')
                        .format(DateTime(0, userData.created_at.month)),
                    joinYear: userData.created_at.year,
                  )),
                ),
              ),

              showSliverAppBar(),

              SliverFillRemaining(
                hasScrollBody: true,
                child: Scaffold(
                  body: TabBarView(
                    children: [Tweets(userdata: userBloc.userdata,), TweetsAndReplies(userdata: userData), Media(userdata: userData), Likes(userdata: userData,)],
                  ),
                ),
              ),
            ],
          ),
        ),
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
        _buildCoverPhoto(
            context: context,
            imageUrl: coverImageURL,
            shrinkOffset: shrinkOffset),
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
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

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
          onTap: () => profileImageURL.toString().isNotEmpty
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OpenedImage(imageURL: profileImageURL)))
              : Navigator.pushNamed(context, PreEditProfile.route),
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
                  onBackgroundImageError: (obj, stackTrace) => CircleAvatar(
                    radius: profileImageSize(context, 7.5, shrinkOffset, 35),
                    backgroundColor: Colors.lightBlue,
                  ),
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
      child: imageUrl.toString().isNotEmpty
          ? GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OpenedImage(imageURL: imageUrl))),
              child: Image.network(
                imageUrl,
                loadingBuilder: (context, image, loadingProgress) {
                  if (loadingProgress == null) {
                    return image;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightBlue,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (context, object, stackTrace) => Container(
                  color: Colors.lightBlue,
                ),
                fit: BoxFit.cover,
              ),
            )
          : GestureDetector(
              onTap: () => Navigator.pushNamed(context, PreEditProfile.route),
              child: Container(
                color: Colors.lightBlue,
              ),
            ),
    );
  }
}

//test
SliverAppBar showSliverAppBar() {
  return SliverAppBar(
    leading: Icon(null),
    leadingWidth: 0,
    backgroundColor: Colors.white,
    floating: false,
    pinned: true,
    snap: false,
    toolbarHeight: 50,
    title: TabBar(
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
              style: TextStyle(color: Colors.black ),
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
  );
}

