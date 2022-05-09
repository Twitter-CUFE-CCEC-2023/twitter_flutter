import 'package:flutter/material.dart';
import '../tweets_widget.dart';

class Media extends StatefulWidget {
  const Media({Key? key}) : super(key: key);

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: ListView(
        children: [
          //   tweet(
          //       userProfilePicture:
          //           "https://www.howfamous.is/celebrity/chris-hemsworth/200/220.jpg?lang=en",
          //       user_Name: "Chris",
          //       screenHeight: screenHeight,
          //       screenWidth: screenWidth,
          //       imageCount: 1,
          //       CommentCount: 300,
          //       retweetCount: 40,
          //       likeCount: 77,
          //       tweet_Text: "Stay tuned for the new thor movie!",
          //       imageOne:
          //           "https://m.media-amazon.com/images/I/81xPLSOkvJL._SS500_.jpg"),
          //
        ],
      ),
    );
  }
}
