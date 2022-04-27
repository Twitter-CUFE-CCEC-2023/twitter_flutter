import 'package:flutter/material.dart';
import '../tweets_widget.dart';

class TweetsAndReplies extends StatefulWidget {
  const TweetsAndReplies({Key? key}) : super(key: key);

  @override
  State<TweetsAndReplies> createState() => _TweetsAndRepliesState();
}

class _TweetsAndRepliesState extends State<TweetsAndReplies> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        child: ListView(
      children: <Widget>[
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
            imageTwo: "https://i.ytimg.com/vi/f3UZ0v1icmQ/maxresdefault.jpg",
            imageThree: "https://i.ytimg.com/vi/HvKbsCowLVU/maxresdefault.jpg"),
      ],
    ));
  }
}
