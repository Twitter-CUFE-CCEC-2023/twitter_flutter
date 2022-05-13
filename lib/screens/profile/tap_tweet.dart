import 'package:flutter/material.dart';

class TapTweet extends StatefulWidget {
  const TapTweet({Key? key}) : super(key: key);
  static String route = '/TapTweet';
  @override
  State<TapTweet> createState() => _TapTweetState();
}

class _TapTweetState extends State<TapTweet> {
  final usertest tweetData = usertest();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: myAppBar(context),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  tweetbar(screenHeight),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: tweetText(tweetData.content, screenHeight),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: tweetMedia(tweetData.media,
                        screenWidth: screenWidth, screenHeight: screenHeight),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget tweetbar(double screenHeight) {
    return ListTile(
      leading: tweetProfilePicture(tweetData.profile_image_url, screenHeight),
      title: Text(
        tweetData.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "@" + tweetData.username,
        style: const TextStyle(
          color: Color.fromARGB(255, 85, 76, 76),
          fontSize: 15,
        ),
      ),
    );
  }

  Widget tweetText(String? tweetText, double screenHeight) {
    if (tweetText == null) {
      return Container();
    } else {
      return Text(
        tweetText,
        style: TextStyle(
          fontSize: 0.028 * screenHeight, // 15
          color: Colors.black,
        ),
      );
    }
  }

  Widget tweetProfilePicture(String profilePicture, double screenHeight) {
    return CircleAvatar(
      radius: 0.03 * screenHeight, //20
      backgroundImage: profilePicture.isEmpty
          ? null
          : NetworkImage(
              profilePicture,
            ),
    );
  }

  // TODO: Change to list<tweetMedia> later
  Widget tweetMedia(List<String> media,
      {required double screenWidth, required double screenHeight}) {
    if (media.isEmpty) {
      return Container();
    } else if (media.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: oneImage(media[0]),
      );
    } else if (media.length == 2) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: screenWidth / 2 - 11.5, //400
              height: 0.2 * screenHeight,
              child: oneImage(media[0]),
            ), // 140  160
            const SizedBox(
              width: 3,
            ),
            SizedBox(
              height: 0.2 * screenHeight,
              width: screenWidth / 2 - 11.5, //400
              child: oneImage(
                media[1],
              ),
            ), // 140 160
          ],
        ),
      );
    } else if (media.length == 3) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: SizedBox(
          height: 0.3 * screenHeight, //160
          child: Row(
            children: <Widget>[
              SizedBox(
                  width: screenWidth / 2 - 11.5,
                  height: 0.3 * screenHeight,
                  child: oneImage(media[0])), //150 160
              const SizedBox(
                width: 3,
              ),
              SizedBox(
                width: screenWidth / 2 - 11.5,
                height: 0.3 * screenHeight, //160
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        height: 0.15 * screenHeight - 1.5,
                        width: screenWidth / 2 - 11.5,
                        child: oneImage(media[1])), //128 78
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                        height: 0.15 * screenHeight - 1.5,
                        width: screenWidth / 2 - 11.5,
                        child: oneImage(media[2])), // 128 78
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: SizedBox(
          height: 0.3 * screenHeight,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: 0.15 * screenHeight - 1.5,
                      width: screenWidth / 2 - 11.5,
                      child: oneImage(media[0])),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 0.15 * screenHeight - 1.5,
                    width: screenWidth / 2 - 11.5,
                    child: oneImage(media[1]),
                  ),
                ],
              ),
              const SizedBox(
                width: 3,
              ),
              SizedBox(
                height: 0.3 * screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 0.15 * screenHeight - 1.5,
                      width: screenWidth / 2 - 11.5,
                      child: oneImage(media[2]),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 0.15 * screenHeight - 1.5,
                      width: screenWidth / 2 - 11.5,
                      child: oneImage(media[3]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget oneImage(String imageUrl) {
    return Image(
      image: NetworkImage(
        imageUrl,
      ),
      loadingBuilder: ((context, child, Progress) {
        return Progress == null
            ? child
            : const Center(
              heightFactor: 1,
              widthFactor: 1,
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            );
      }),
      fit: BoxFit.cover,
    );
  }
}

myAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    title: const Text(
      "Tweet",
      style: TextStyle(
        fontSize: 18,
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

class testTweet {
  String content =
      "Barcelona have offered cesar azplilcueta a two-Year contract which would see him to earn 11\$ millioin a year";
  int likes_count = 2;
  int retweets_count = 3;
  int quotes_count = 4;
  int replies_count = 5;
  DateTime created_at = DateTime.now();
  bool is_liked = false;
  bool is_retweeted = false;
  bool is_quoted = false;
  bool is_reply = false;
  List<String> media = [
    "https://pbs.twimg.com/media/FRYEbNEWUAASMrR?format=jpg&name=large",
    "https://pbs.twimg.com/media/FRYEaJRXwAEX_Pz?format=jpg&name=4096x4096",
    "https://pbs.twimg.com/media/FRbtqCFXoAEK6uA?format=jpg&name=large",
    "https://pbs.twimg.com/media/FRbtqCWXwAMShGB?format=jpg&name=900x900",
  ];
  //   "id": "627c295863835231d8c687e9",
  // "content": "Testing Post a tweet",
  // "user": {},
  // "likes_count": 2,
  // "retweets_count": 0,
  // "replies_count": 0,
  // "quotes_count": 0,
  // "is_liked": true,
  // "is_retweeted": false,
  // "is_quoted": false,
  // "is_reply": false,
  // "quote_comment": null,
  // "mentions": [],
  // "media": [],
  // "created_at": "2022-05-11T21:23:36.675Z"

}

class usertest extends testTweet {
  String id = "624a4a94c66738f13854b474";
  String name = "zikaaa";
  String username = "amrzaki";
  String profile_image_url =
      "https://media.istockphoto.com/photos/hot-air-balloons-flying-over-the-botan-canyon-in-turkey-picture-id1297349747?b=1&k=20&m=1297349747&s=170667a&w=0&h=oH31fJty_4xWl_JQ4OIQWZKP8C6ji9Mz7L4XmEnbqRU=";
  bool isVerified = false;
}
