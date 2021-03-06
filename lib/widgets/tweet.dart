import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/models/objects/mediaModel.dart';
import 'package:twitter_flutter/blocs/profileTabs/tweets_tab_cubit.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/media.dart';

class TweetWidget extends StatefulWidget {
  late ReplyTweetModel tweetData;
  TweetWidget({Key? key, required this.tweetData}) : super(key: key);
  @override
  State<TweetWidget> createState() => _TweetWidgetState();
}

class _TweetWidgetState extends State<TweetWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/TapTweet",
          arguments: widget.tweetData),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name == "/userProfile" ||
                      ModalRoute.of(context)!.settings.name ==
                          "/VisitedUserProfile") return;
                  if (widget.tweetData.user.id ==
                      context.read<UserManagementBloc>().userdata.id) {
                    Navigator.pushNamed(context, "/userProfile");
                  } else {
                    Navigator.pushNamed(context, "/VisitedUserProfile",
                        arguments: widget.tweetData.user);
                  }
                },
                child: tweetProfilePicture(
                    widget.tweetData.user.profile_image_url, screenHeight),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      userName(widget.tweetData.user.username, screenHeight),
                      Padding(
                        padding: widget.tweetData.content.isEmpty
                            ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
                            : const EdgeInsets.fromLTRB(0, 5, 13, 0),
                        child:
                            tweetText(widget.tweetData.content, screenHeight),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 13, 0),
                          child: tweetMedia(widget.tweetData.media,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              gif: widget.tweetData.gif)),
                      tweetButtons(
                        like_count: widget.tweetData.likes_count,
                        commentCount: widget.tweetData.quotes_count,
                        retweetCount: widget.tweetData.retweets_count,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        is_liked: widget.tweetData.is_liked,
                        is_quoted: widget.tweetData.is_quoted,
                        is_retweeted: widget.tweetData.is_retweeted,
                      ),
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
      ),
    );
  }

  Widget userName(String username, double screenHeight) {
    return Text(
      username,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 0.0256 * screenHeight, // 20
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
          fontSize: 0.0192 * screenHeight, // 15
          color: Colors.black,
        ),
      );
    }
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
      children: <Widget>[
        //replies
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeCount: widget.tweetData.replies_count,
          onTap: (f) {
            Navigator.pushNamed(context, "/PostReply",
                arguments: widget.tweetData.id);
            return Future.value();
          },
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
            var tweetsTabCubit = context.read<TweetsTabCubit>();
            var tweetBloc = context.read<TweetsManagementBloc>();
            var userBloc = context.read<UserManagementBloc>();
            print("like");
            tweetBloc.add(LikeButtonPressed(
                access_token: userBloc.access_token,
                tweet_id: widget.tweetData.id,
                isLiked: widget.tweetData.is_liked));
            widget.tweetData.is_liked = !widget.tweetData.is_liked;
            widget.tweetData.likes_count = widget.tweetData.is_liked
                ? widget.tweetData.likes_count + 1
                : widget.tweetData.likes_count - 1;
            tweetsTabCubit.updateTweet(
                tweet_id: widget.tweetData.id,
                Action: "like",
                username: widget.tweetData.user.username);
            return Future.value(widget.tweetData.is_liked);
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

// TODO: add condition for image and videos
  /* Widget tweetMedia(List<String> media,
      {required double screenWidth, required double screenHeight}) {
    if (media.isEmpty) {
      return Container();
    } else if (media.length == 1) {
      return oneImage(media[0], 0.01536 * screenHeight, 0.01536 * screenHeight,
          0.01536 * screenHeight, 0.01536 * screenHeight);
    } else if (media.length == 2) {
      return Container(
        width: 1.019 * screenWidth, //400
        height: 0.205 * screenHeight, //160
        child: Row(
          children: <Widget>[
            oneImage(
                media[0], 0.01536 * screenHeight, 0, 0.01536 * screenHeight, 0,
                imageWidth: 0.356 * screenWidth,
                imageHeight: 0.205 * screenHeight), // 140  160
            const SizedBox(
              width: 3,
            ),
            oneImage(
                media[1], 0, 0.01536 * screenHeight, 0, 0.01536 * screenHeight,
                imageWidth: 0.356 * screenWidth,
                imageHeight: 0.205 * screenHeight), // 140 160
          ],
        ),
      );
    } else if (media.length == 3) {
      return Container(
        width: 1.019 * screenWidth, //400
        height: 0.205 * screenHeight, //160
        child: Row(
          children: <Widget>[
            oneImage(
                media[0], 0.01536 * screenHeight, 0, 0.01536 * screenHeight, 0,
                imageWidth: 0.382 * screenWidth,
                imageHeight: 0.205 * screenHeight), //150 160
            const SizedBox(
              width: 3,
            ),
            Container(
              width: 0.326 * screenWidth, //128
              height: 0.205 * screenHeight, //160
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  oneImage(media[1], 0, 0.01536 * screenHeight, 0, 0,
                      imageWidth: 0.326 * screenWidth,
                      imageHeight: 0.0999 * screenHeight), //128 78
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(media[2], 0, 0, 0, 0.01536 * screenHeight,
                      imageWidth: 0.326 * screenWidth,
                      imageHeight: 0.0999 * screenHeight), // 128 78
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 1.019 * screenWidth,
        height: 0.205 * screenHeight,
        child: Row(
          children: <Widget>[
            Container(
              width: 0.356 * screenWidth,
              height: 0.205 * screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  oneImage(media[0], 0.01536 * screenHeight, 0, 0, 0,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(media[1], 0, 0, 0.01536 * screenHeight, 0,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
                ],
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Container(
              width: 0.356 * screenWidth,
              height: 0.205 * screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  oneImage(media[2], 0, 0.01536 * screenHeight, 0, 0,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(media[3], 0, 0, 0, 0.01536 * screenHeight,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
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
  }*/

  Widget tweetProfilePicture(String profilePicture, double screenHeight) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: CircleAvatar(
        // radius: 0.0358 * screenHeight, //20
        radius: 25, //20
        backgroundImage: profilePicture.isEmpty
            ? null
            : NetworkImage(
                profilePicture,
              ),
      ),
    );
  }

  Widget tweetMedia(List<String> media,
      {required double screenWidth,
      required double screenHeight,
      String? gif}) {
    double margin = 47; //52.6
    double screenHeightMultiplier = screenHeight * 0.205;

    if (media.isEmpty) {
      return Container();
    } else if (media.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: SizedBox(width: screenWidth - margin, child: oneImage(media[0])),
      );
    } else if (media.length == 2) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: screenWidth / 2 - (1.5 + margin), //400
              height: screenHeightMultiplier,
              child: oneImage(media[0]),
            ), // 140  160
            const SizedBox(
              width: 3,
            ),
            SizedBox(
              height: screenHeightMultiplier,
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
          height: screenHeightMultiplier, //160
          child: Row(
            children: <Widget>[
              SizedBox(
                  width: screenWidth / 2 - (1.5 + margin),
                  height: screenHeightMultiplier,
                  child: oneImage(media[0])), //150 160
              const SizedBox(
                width: 3,
              ),
              SizedBox(
                width: screenWidth / 2 - (1.5 + margin),
                height: screenHeightMultiplier, //160
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        height: screenHeightMultiplier / 2 - 1.5,
                        width: screenWidth / 2 - (1.5 + margin),
                        child: oneImage(media[1])), //128 78
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                        height: screenHeightMultiplier / 2 - 1.5,
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
          height: screenHeightMultiplier,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: screenHeightMultiplier / 2 - 1.5,
                      width: screenWidth / 2 - (1.5 + margin),
                      child: oneImage(media[0])),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: screenHeightMultiplier / 2 - 1.5,
                    width: screenWidth / 2 - (1.5 + margin),
                    child: oneImage(media[1]),
                  ),
                ],
              ),
              const SizedBox(
                width: 3,
              ),
              SizedBox(
                height: screenHeightMultiplier,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: screenHeightMultiplier / 2 - 1.5,
                      width: screenWidth / 2 - (1.5 + margin),
                      child: oneImage(media[2]),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: screenHeightMultiplier / 2 - 1.5,
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

class DetailScreen extends StatelessWidget {
  late String? imageUrl;
  DetailScreen({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: Center(
            child: Image.network(
              imageUrl.toString(),
            ),
          ),
        ),
      ),
    );
  }
}

// Future<double> get_imagewidth(String url) async {
//   var img = await rootBundle.load(url);
//   var decodedImage = await decodeImageFromList(img.buffer.asUint8List());
//   double imgHeight = decodedImage.height as double;
//   return imgHeight;
// }
