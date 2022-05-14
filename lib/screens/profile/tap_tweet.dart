import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/likes.dart';

class TapTweet extends StatefulWidget {
  const TapTweet({Key? key}) : super(key: key);
  static String route = '/TapTweet';

  @override
  State<TapTweet> createState() => _TapTweetState();
}

class _TapTweetState extends State<TapTweet> {
  late ReplyTweetModel tweetData;
  List<String> media = [
    "https://pbs.twimg.com/media/FRYEbNEWUAASMrR?format=jpg&name=large",
    "https://pbs.twimg.com/media/FRYEaJRXwAEX_Pz?format=jpg&name=4096x4096",
    "https://pbs.twimg.com/media/FRbtqCFXoAEK6uA?format=jpg&name=large",
    // "https://pbs.twimg.com/media/FRbtqCWXwAMShGB?format=jpg&name=900x900",
  ];
  @override
  Widget build(BuildContext context) {
    tweetData = ModalRoute.of(context)?.settings.arguments as ReplyTweetModel;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int likesCount = tweetData.likes_count;

    // TODO: implent replies count and retweets count
    // ignore: unused_local_variable
    int retweetsCount = tweetData.retweets_count;
    // ignore: unused_local_variable
    int repliesCount = tweetData.replies_count;
    log("Likes Count $likesCount ${tweetData.likes_count}");
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: tweetText(tweetData.content, screenHeight),
                  ),
                  // TODO: REMOVE HARDCODED

                  Padding(
                    padding: media.isEmpty
                        ? const EdgeInsets.only()
                        : const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                    child: tweetMedia(media,
                        screenWidth: screenWidth, screenHeight: screenHeight),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: tweetdate(),
                  ),
                  const Divider(thickness: 1),

                  Padding(
                    padding: (likesCount != 0 ||
                            tweetData.replies_count != 0 ||
                            tweetData.replies_count != 0)
                        ? const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8)
                        : const EdgeInsets.all(0),
                    child: retweetLikeCount(),
                  ),
                  if (likesCount != 0 ||
                      tweetData.replies_count != 0 ||
                      tweetData.replies_count != 0)
                    const Divider(thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: tweetButtons(
                      like_count: tweetData.likes_count,
                      retweetCount: tweetData.retweets_count,
                      commentCount: tweetData.replies_count,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      is_liked: tweetData.is_liked,
                      is_retweeted: tweetData.is_retweeted,
                      is_quoted: tweetData.is_quoted,
                    ),
                  ),
                  const Divider(thickness: 1),
                ]),
          ),
        ),
      ),
    );
  }

  Widget tweetbar(double screenHeight) {
    return ListTile(
      leading:
          tweetProfilePicture(tweetData.user.profile_image_url, screenHeight),
      title: Text(
        tweetData.user.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "@" + tweetData.user.username,
        style: const TextStyle(
          color: Color.fromARGB(255, 85, 76, 76),
          fontSize: 15,
        ),
      ),
    );
  }

  Widget retweetLikeCount() {
    return Row(
      children: [
        if (tweetData.retweets_count != 0)
          Row(
            children: [
              Text(
                tweetData.retweets_count.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                " Retweets   ",
                style: TextStyle(
                  color: Color.fromARGB(255, 85, 76, 76),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        if (tweetData.quotes_count != 0)
          Row(
            children: [
              Text(
                tweetData.quotes_count.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                " Quoute Tweet   ",
                style: TextStyle(
                  color: Color.fromARGB(255, 85, 76, 76),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        if (tweetData.likes_count != 0)
          Row(
            children: [
              Text(
                tweetData.likes_count.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                " Likes",
                style: TextStyle(
                  color: Color.fromARGB(255, 85, 76, 76),
                  fontSize: 15,
                ),
              ),
            ],
          )
      ],
    );
  }

  Widget tweetButtons({
    required int like_count,
    required int retweetCount,
    required int commentCount,
    required double screenHeight,
    required double screenWidth,
    required bool is_liked,
    required bool is_retweeted,
    required bool is_quoted,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeCount: commentCount,
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.comment,
              color: Colors.grey,
              size: 0.0256 * screenHeight,
            );
          },
        ),
        SizedBox(
          width: 0.0764 * screenWidth,
        ),
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeCount: retweetCount,
          isLiked: is_retweeted,
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.retweet,
              color: isLiked ? Colors.green : Colors.grey,
              size: 0.0256 * screenHeight,
            );
          },
        ),
        SizedBox(
          width: 0.0764 * screenWidth,
        ),
        LikeButton(
          onTap: (f) {
            var tweetBloc = context.read<TweetsManagementBloc>();
            var userBloc = context.read<UserManagementBloc>();
            tweetBloc.add(LikeButtonPressed(
                access_token: userBloc.access_token,
                tweet_id: tweetData.id,
                isLiked: tweetData.is_liked));
            tweetData.is_liked = !tweetData.is_liked;
            tweetData.likes_count = tweetData.is_liked
                ? tweetData.likes_count + 1
                : tweetData.likes_count - 1;
            setState(() {
              like_count = tweetData.likes_count;
            });

            return Future.value(tweetData.is_liked);
          },
          likeCount: like_count,
          isLiked: is_liked,
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.solidHeart,
              color: isLiked ? Colors.red : Colors.grey,
              size: 0.0256 * screenHeight,
            );
          },
        ),
        SizedBox(
          width: 0.0764 * screenWidth,
        ),
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeBuilder: (bool isLiked) {
            return Icon(
              FontAwesomeIcons.arrowUpFromBracket,
              color: Colors.grey,
              size: 0.0256 * screenHeight,
            );
          },
        ),
      ],
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

  Widget tweetdate() {
    var date = DateFormat("h:mm a • d MMM y").format(tweetData.created_at);
    return Row(
      children: [
        Text(
          date,
          style: const TextStyle(
            color: Color.fromARGB(255, 85, 76, 76),
            fontSize: 15,
          ),
        ),
      ],
    );
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

  Widget tweetMedia(List<String> media,
      {required double screenWidth, required double screenHeight}) {
    double margin = 15;
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
              width: screenWidth / 2 - (1.5 + margin), //400
              height: 0.2 * screenHeight,
              child: oneImage(media[0]),
            ), // 140  160
            const SizedBox(
              width: 3,
            ),
            SizedBox(
              height: 0.2 * screenHeight,
              width: screenWidth / 2 - (1.5 + margin), //400
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
                  width: screenWidth / 2 - (1.5 + margin),
                  height: 0.3 * screenHeight,
                  child: oneImage(media[0])), //150 160
              const SizedBox(
                width: 3,
              ),
              SizedBox(
                width: screenWidth / 2 - (1.5 + margin),
                height: 0.3 * screenHeight, //160
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        height: 0.15 * screenHeight - 1.5,
                        width: screenWidth / 2 - (1.5 + margin),
                        child: oneImage(media[1])), //128 78
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                        height: 0.15 * screenHeight - 1.5,
                        width: screenWidth / 2 - (1.5 + margin),
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
                      width: screenWidth / 2 - (1.5 + margin),
                      child: oneImage(media[0])),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 0.15 * screenHeight - 1.5,
                    width: screenWidth / 2 - (1.5 + margin),
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
                      width: screenWidth / 2 - (1.5 + margin),
                      child: oneImage(media[2]),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 0.15 * screenHeight - 1.5,
                      width: screenWidth / 2 - (1.5 + margin),
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
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
        return DetailScreen(imageUrl: imageUrl);
      })),
      child: Image(
        image: NetworkImage(
          imageUrl,
        ),
        loadingBuilder: ((context, child, progress) {
          return progress == null
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
      ),
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

class DetailScreen extends StatelessWidget {
  late String? imageUrl;
  DetailScreen({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        child: Center(
          child: Image.network(
            imageUrl.toString(),
          ),
        ),
        // onTap: () {
        //   Navigator.pop(context);
        // },
      ),
    );
  }
}
