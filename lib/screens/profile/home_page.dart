import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_flutter/screens/authentication/Icons.dart';
import 'package:twitter_flutter/screens/profile/profile.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter_flutter/screens/profile_management/change_password.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String route = '/HomePage';
  static const String username =
      "Ahmedhgjghjgfhjfghjfghjfghjfghjgfhjgfhjfghjgffghfdghdfghdzkjcflhgbnlkdsjfhglkjdsfhglkdfhgkdljfh";

  static const String tweetTexts =
      "This is a tweetfgklh jdfklg;h jflk;gjh;flk gjhlfkdgjhlfgh jflgkhl kfjgh;sdlkhf jdsfg;hsdklf;gj dsflk jhgsdklf ghdsjlkf hgdfjslk hgdsjklf ghdfjskl hdsjlfk ghsdjklf ghsdjklf ghjdsklf ghsdjlkfg hsdjlkf ghdsjklf jhgsdljkf gljkdf gjhkld;f gjds;lk gdlfjkgh;slk djhdf;klghd l;kfjhg;lsda hfdfl;kjg hsd;fgh;d flkg";
  BottomNavigationBar Bottom(
      {required double height, required double imageMultiplier}) {
    return BottomNavigationBar(
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
      required BuildContext context}) {
    return AppBar(
      elevation: 1,
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
            onTap: () => Navigator.pushNamed(context, UserProfile.route),
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg"))),
      ),
      //IconButton(
      //   onPressed: () => {},
      //
      //   icon: Icon(
      //     Icons.circle,
      //     color: Colors.blue,
      //     size: 0.038 * imageMultiplier * height,
      //   ),
      // ),
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

  Widget userName(String username) {
    return Text(
      username,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  Widget tweetText(String tweetText) {
    return Text(
      tweetText,
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }

  Widget tweetButtons() {
    return Row(
      children: <Widget>[
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeCount: 0,
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.comment,
              color: Colors.grey,
              size: 20,
            );
          },
        ),
        SizedBox(
          width: 30,
        ),
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeCount: 0,
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.retweet,
              color: isLiked ? Colors.green : Colors.grey,
              size: 20,
            );
          },
        ),
        SizedBox(
          width: 30,
        ),
        LikeButton(
          likeCount: 0,
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.solidHeart,
              color: isLiked ? Colors.red : Colors.grey,
              size: 20,
            );
          },
        ),
        SizedBox(
          width: 30,
        ),
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.arrowUpFromBracket,
              color: Colors.grey,
              size: 20,
            );
          },
        ),
      ],
    );
  }

  Widget tweetImage(int count) {
    if (count == 0) {
      return Container();
    } else if (count == 1) {
      return oneImage(
          "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
          12,
          12,
          12,
          12);
    } else if (count == 2) {
      return Container(
        width: 400,
        height: 160,
        child: Row(
          children: <Widget>[
            oneImage(
                "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
                12,
                0,
                12,
                0,
                imageWidth: 140,
                imageHeight: 160),
            SizedBox(
              width: 3,
            ),
            oneImage(
                "https://see.news/wp-content/uploads/2022/02/Huda-El-Mufti-1.jpg",
                0,
                12,
                0,
                12,
                imageWidth: 140,
                imageHeight: 160),
          ],
        ),
      );
    } else if (count == 3) {
      return Container(
        width: 400,
        height: 160,
        child: Row(
          children: <Widget>[
            oneImage(
                "https://see.news/wp-content/uploads/2022/02/Huda-El-Mufti-1.jpg",
                12,
                0,
                12,
                0,
                imageWidth: 150,
                imageHeight: 160),
            SizedBox(
              width: 3,
            ),
            Container(
              width: 128,
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  oneImage(
                      "https://see.news/wp-content/uploads/2022/02/Huda-El-Mufti-1.jpg",
                      0,
                      12,
                      0,
                      0,
                      imageWidth: 128,
                      imageHeight: 78),
                  SizedBox(
                    height: 3,
                  ),
                  oneImage(
                      "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
                      0,
                      0,
                      0,
                      12,
                      imageWidth: 128,
                      imageHeight: 78),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 400,
        height: 160,
        child: Row(
          children: <Widget>[
            Container(
              width: 140,
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  oneImage(
                      "https://see.news/wp-content/uploads/2022/02/Huda-El-Mufti-1.jpg",
                      12,
                      0,
                      0,
                      0,
                      imageWidth: 140,
                      imageHeight: 78),
                  SizedBox(
                    height: 3,
                  ),
                  oneImage(
                      "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
                      0,
                      0,
                      12,
                      0,
                      imageWidth: 140,
                      imageHeight: 78),
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Container(
              width: 140,
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  oneImage(
                      "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
                      0,
                      12,
                      0,
                      0,
                      imageWidth: 140,
                      imageHeight: 78),
                  SizedBox(
                    height: 3,
                  ),
                  oneImage(
                      "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
                      0,
                      0,
                      0,
                      12,
                      imageWidth: 140,
                      imageHeight: 78),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget oneImage(String imageUrl, double topLeftClip, double topRightClip,
      double bottomLeftClip, double bottomRightClip,
      {double? imageWidth, double? imageHeight}) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeftClip),
        topRight: Radius.circular(topRightClip),
        bottomLeft: Radius.circular(bottomLeftClip),
        bottomRight: Radius.circular(bottomRightClip),
      ),
      child: Image(
        image: NetworkImage(
          imageUrl,
        ),
        fit: BoxFit.cover,
        width: imageWidth,
        height: imageHeight,
      ),
    );
  }

  Widget tweet() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                    "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg"),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    userName(username),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                      child: tweetText(tweetTexts),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 15, 0),
                      child: tweetImage(2),
                    ),
                    tweetButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black26,
          thickness: 0.8,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        imageMultiplier[0] = 1;
        imageMultiplier[1] = 1;
        borderRadiusMultiplier = 1;
        fontSizeMultiplier[0] = 1;
        fontSizeMultiplier[1] = 1;
        fontSizeMultiplier[2] = 1;
        fontSizeMultiplier[3] = 1;
      } else {
        imageMultiplier[0] = 1.8;
        imageMultiplier[1] = 1.8;
        borderRadiusMultiplier = 1.4;
        fontSizeMultiplier[0] = 2;
        fontSizeMultiplier[1] = 2;
        fontSizeMultiplier[2] = 2;
        fontSizeMultiplier[3] = 2;
      }
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: logoAppBar(
                height: screenHeight,
                imageMultiplier: imageMultiplier[0],
                context: context),
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
            body: tweet(),
            bottomNavigationBar: Bottom(
                height: screenHeight, imageMultiplier: imageMultiplier[0]),
          ),
        ),
      );
    });
  }
}
