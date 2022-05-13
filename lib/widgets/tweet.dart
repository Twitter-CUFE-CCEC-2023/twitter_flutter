import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import '../../models/objects/mediaModel.dart';
import '../blocs/userManagement/user_management_bloc.dart';
import '../models/objects/tweet.dart';

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
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            tweetProfilePicture(
                widget.tweetData.user.profile_image_url, screenHeight),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    userName(widget.tweetData.user.username, screenHeight),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 13, 0),
                      child: tweetText(widget.tweetData.content, screenHeight),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 13, 0),
                        child: tweetMedia(widget.tweetData.media,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight)),
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
              print("like");
              tweetBloc.add(LikeButtonPressed(access_token: userBloc.access_token  , tweet_id: widget.tweetData.id, isLiked: widget.tweetData.is_liked));
            widget.tweetData.is_liked = !widget.tweetData.is_liked;
            widget.tweetData.likes_count = widget.tweetData.is_liked
                ? widget.tweetData.likes_count + 1
                : widget.tweetData.likes_count - 1;
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
  Widget tweetMedia(List<MediaModel> media,
      {required double screenWidth, required double screenHeight}) {
    if (media.isEmpty) {
      return Container();
    } else if (media.length == 1) {
      return oneImage(
          media[0].path,
          0.01536 * screenHeight,
          0.01536 * screenHeight,
          0.01536 * screenHeight,
          0.01536 * screenHeight);
    } else if (media.length == 2) {
      return Container(
        width: 1.019 * screenWidth, //400
        height: 0.205 * screenHeight, //160
        child: Row(
          children: <Widget>[
            oneImage(media[0].path, 0.01536 * screenHeight, 0,
                0.01536 * screenHeight, 0,
                imageWidth: 0.356 * screenWidth,
                imageHeight: 0.205 * screenHeight), // 140  160
            const SizedBox(
              width: 3,
            ),
            oneImage(media[1].path, 0, 0.01536 * screenHeight, 0,
                0.01536 * screenHeight,
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
            oneImage(media[0].path, 0.01536 * screenHeight, 0,
                0.01536 * screenHeight, 0,
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
                  oneImage(media[1].path, 0, 0.01536 * screenHeight, 0, 0,
                      imageWidth: 0.326 * screenWidth,
                      imageHeight: 0.0999 * screenHeight), //128 78
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(media[2].path, 0, 0, 0, 0.01536 * screenHeight,
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
                  oneImage(media[0].path, 0.01536 * screenHeight, 0, 0, 0,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(media[1].path, 0, 0, 0.01536 * screenHeight, 0,
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
                  oneImage(media[2].path, 0, 0.01536 * screenHeight, 0, 0,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(media[3].path, 0, 0, 0, 0.01536 * screenHeight,
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
  }

  Widget tweetProfilePicture(String profilePicture, double screenHeight) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: CircleAvatar(
        radius: 0.0358 * screenHeight, //20
        backgroundImage: profilePicture.isEmpty
            ? null
            : NetworkImage(
                profilePicture,
              ),
      ),
    );
  }
}
