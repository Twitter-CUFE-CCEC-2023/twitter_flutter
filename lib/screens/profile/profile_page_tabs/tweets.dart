import 'package:flutter/material.dart';
import '../tweets_widget.dart';
class Tweets extends StatefulWidget {
  const Tweets({Key? key}) : super(key: key);

  @override
  State<Tweets> createState() => _TweetsState();
}

class _TweetsState extends State<Tweets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListView(
        children: [
          tweet(
            userProfilePicture:
            "https://www.washingtonpost.com/rf/image_1484w/2010-2019/WashingtonPost/2017/03/28/Local-Politics/Images/Supreme_Court_Gorsuch_Moments_22084-70c71-0668.jpg?t=20170517",
            user_Name: "Johnny",
            imageCount: 0,
            CommentCount: 2,
            retweetCount: 4,
            likeCount: 7,
            tweet_Text: "Hello guys, How are you?",
          ),
          tweet(
              userProfilePicture:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQmyyuPaZzRHAIpnCtIWLhyIoghmcPu3dZxQ&usqp=CAU",
              user_Name: "Activation",
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
    );
  }
}
