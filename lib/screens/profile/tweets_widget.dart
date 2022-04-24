import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class tweetModel {
  late String userProfileImage;
  late String userName;
  late int imageCount;
  late int CommentCount;
  late int retweetCount;
  late int likeCount;
  String? tweet_Text;

  String? imageOne;
  String? imageTwo;
  String? imageThree;
  String? imageFour;

  tweetModel({
    required this.userProfileImage,
    required this.userName,
    required this.imageCount,
    required this.CommentCount,
    required this.retweetCount,
    required this.likeCount,
    this.tweet_Text,
    this.imageOne,
    this.imageTwo,
    this.imageThree,
    this.imageFour,
  });
}

List<tweetModel> tweets = [
  tweetModel(
      userProfileImage:
          "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
      userName: "huda el mufti",
      imageCount: 1,
      imageOne:
          "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
      CommentCount: 1,
      likeCount: 1,
      retweetCount: 1),
];

Widget tweet(
    {required String userProfilePicture,
    required String user_Name,
    required int imageCount,
    required int CommentCount,
    required int retweetCount,
    required int likeCount,
    String? tweet_Text,
    String? imageOne,
    String? imageTwo,
    String? imageThree,
    String? imageFour}) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          tweetProfilePicture(userProfilePicture),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  userName(user_Name),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                    child: tweetText(tweet_Text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 15, 0),
                    child: tweetImage(imageCount,
                        imageOne: imageOne,
                        imageTwo: imageTwo,
                        imageThree: imageThree,
                        imageFour: imageFour),
                  ),
                  tweetButtons(
                      like_count: likeCount,
                      commentCount: CommentCount,
                      retweetCount: retweetCount),
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

Widget userName(String username) {
  return Text(
    username,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 20,
    ),
  );
}

Widget tweetText(String? tweetText) {
  if (tweetText == null) {
    return Container();
  } else {
    return Text(
      tweetText,
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
    );
  }
}

Widget tweetButtons(
    {required int like_count,
    required int retweetCount,
    required int commentCount}) {
  return Row(
    children: <Widget>[
      LikeButton(
        animationDuration: const Duration(milliseconds: 0),
        likeCount: commentCount,
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
        likeCount: retweetCount,
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
        likeCount: like_count,
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

Widget tweetImage(int count,
    {String? imageOne,
    String? imageTwo,
    String? imageThree,
    String? imageFour}) {
  if (count == 0) {
    return Container();
  } else if (count == 1) {
    return oneImage(imageOne ?? "", 12, 12, 12, 12);
  } else if (count == 2) {
    return Container(
      width: 400,
      height: 160,
      child: Row(
        children: <Widget>[
          oneImage(imageOne ?? "", 12, 0, 12, 0,
              imageWidth: 140, imageHeight: 160),
          SizedBox(
            width: 3,
          ),
          oneImage(imageTwo ?? "", 0, 12, 0, 12,
              imageWidth: 140, imageHeight: 160),
        ],
      ),
    );
  } else if (count == 3) {
    return Container(
      width: 400,
      height: 160,
      child: Row(
        children: <Widget>[
          oneImage(imageOne ?? "", 12, 0, 12, 0,
              imageWidth: 150, imageHeight: 160),
          SizedBox(
            width: 3,
          ),
          Container(
            width: 128,
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                oneImage(imageTwo ?? "", 0, 12, 0, 0,
                    imageWidth: 128, imageHeight: 78),
                SizedBox(
                  height: 3,
                ),
                oneImage(imageThree ?? "", 0, 0, 0, 12,
                    imageWidth: 128, imageHeight: 78),
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
                oneImage(imageOne ?? "", 12, 0, 0, 0,
                    imageWidth: 140, imageHeight: 78),
                SizedBox(
                  height: 3,
                ),
                oneImage(imageTwo ?? "", 0, 0, 12, 0,
                    imageWidth: 140, imageHeight: 78),
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
                oneImage(imageThree ?? "", 0, 12, 0, 0,
                    imageWidth: 140, imageHeight: 78),
                SizedBox(
                  height: 3,
                ),
                oneImage(imageFour ?? "", 0, 0, 0, 12,
                    imageWidth: 140, imageHeight: 78),
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

Widget tweetProfilePicture(String profilePicture) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
    child: CircleAvatar(
      radius: 28,
      backgroundImage: NetworkImage(
        profilePicture,
      ),
    ),
  );
}
