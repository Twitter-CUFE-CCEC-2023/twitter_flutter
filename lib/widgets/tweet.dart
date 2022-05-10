import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/objects/mediaModel.dart';
import '../models/objects/tweet.dart';

class Tweet {
  late TweetModel tweetData;

  Tweet({required this.tweetData});

  Widget drawTweet(
      {required String userProfilePicture,
      required String user_Name,
      required int imageCount,
      required int CommentCount,
      required int retweetCount,
      required int likeCount,
      required double screenWidth,
      required double screenHeight,
      required bool is_liked,
      required bool is_retweeted,
      required bool is_quoted,
      String? tweet_Text,
      required List<MediaModel> media}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            tweetProfilePicture(userProfilePicture, screenHeight),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    userName(user_Name, screenHeight),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 13, 0),
                      child: tweetText(tweet_Text, screenHeight),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 13, 0),
                        child: tweetMedia(media,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight)),
                    tweetButtons(
                        like_count: likeCount,
                        commentCount: CommentCount,
                        retweetCount: retweetCount,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        is_liked: is_liked,
                        is_quoted: is_quoted,
                        is_retweeted: is_retweeted),
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

  Widget tweetImage(int count,
      {required double screenWidth,
      required double screenHeight,
      String? imageOne,
      String? imageTwo,
      String? imageThree,
      String? imageFour}) {
    if (count == 0) {
      return Container();
    } else if (count == 1) {
      return oneImage(
          imageOne ?? "",
          0.01536 * screenHeight,
          0.01536 * screenHeight,
          0.01536 * screenHeight,
          0.01536 * screenHeight); // 12,12,12,12
    } else if (count == 2) {
      return Container(
        width: 1.019 * screenWidth, //400
        height: 0.205 * screenHeight, //160
        child: Row(
          children: <Widget>[
            oneImage(imageOne ?? "", 0.01536 * screenHeight, 0,
                0.01536 * screenHeight, 0,
                imageWidth: 0.356 * screenWidth,
                imageHeight: 0.205 * screenHeight), // 140  160
            const SizedBox(
              width: 3,
            ),
            oneImage(imageTwo ?? "", 0, 0.01536 * screenHeight, 0,
                0.01536 * screenHeight,
                imageWidth: 0.356 * screenWidth,
                imageHeight: 0.205 * screenHeight), // 140 160
          ],
        ),
      );
    } else if (count == 3) {
      return Container(
        width: 1.019 * screenWidth, //400
        height: 0.205 * screenHeight, //160
        child: Row(
          children: <Widget>[
            oneImage(imageOne ?? "", 0.01536 * screenHeight, 0,
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
                  oneImage(imageTwo ?? "", 0, 0.01536 * screenHeight, 0, 0,
                      imageWidth: 0.326 * screenWidth,
                      imageHeight: 0.0999 * screenHeight), //128 78
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(imageThree ?? "", 0, 0, 0, 0.01536 * screenHeight,
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
                  oneImage(imageOne ?? "", 0.01536 * screenHeight, 0, 0, 0,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(imageTwo ?? "", 0, 0, 0.01536 * screenHeight, 0,
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
                  oneImage(imageThree ?? "", 0, 0.01536 * screenHeight, 0, 0,
                      imageWidth: 0.356 * screenWidth,
                      imageHeight: 0.0999 * screenHeight),
                  const SizedBox(
                    height: 3,
                  ),
                  oneImage(imageFour ?? "", 0, 0, 0, 0.01536 * screenHeight,
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
        backgroundImage: NetworkImage(
          profilePicture,
        ),
      ),
    );
  }
}
