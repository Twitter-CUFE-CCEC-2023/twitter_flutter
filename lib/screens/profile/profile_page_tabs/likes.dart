import 'package:flutter/material.dart';
import '../tweets_widget.dart';

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        child: ListView(
      children: [
        //   tweet(
        //       userProfilePicture:
        //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQmyyuPaZzRHAIpnCtIWLhyIoghmcPu3dZxQ&usqp=CAU",
        //       user_Name: "Activation",
        //       screenHeight: screenHeight,
        //       screenWidth: screenWidth,
        //       imageCount: 4,
        //       CommentCount: 20,
        //       retweetCount: 40,
        //       likeCount: 200,
        //       tweet_Text:
        //           "Check out the newest mapes in the game (new enemies added, new characters, and new guns)",
        //       imageOne:
        //           "https://cdn.vox-cdn.com/thumbor/v4CFyRhEvWB9Ct_YeP8tEH0i2xo=/0x0:1920x1080/1200x800/filters:focal(381x260:687x566)/cdn.vox-cdn.com/uploads/chorus_image/image/68764501/FirebaseZ2.0.jpg",
        //       imageTwo:
        //           "https://imageio.forbes.com/specials-images/imageserve/60e7537510a61c82e917781b/BOCW-Zombies-Story-So-Far-TOUT/960x0.jpg?fit=bounds&format=jpg&width=960",
        //       imageThree:
        //           "https://gamingintel.com/wp-content/uploads/2020/11/Black-Ops-Cold-War-New-Map-Vietnam-Zombies.jpg",
        //       imageFour:
        //           "https://charlieintel.com/wp-content/uploads/2021/06/mauer-der-toten-1.jpg"),
        //
      ],
    ));
  }
}
