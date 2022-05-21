import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:twitter_flutter/blocs/cubit/followmanagement_cubit.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/likes.dart';

import '../../models/objects/user.dart';

import '../../utils/Web Services/tweets_management_requests.dart';

class TapTweet extends StatefulWidget {
  const TapTweet({Key? key}) : super(key: key);
  static String route = '/TapTweet';

  @override
  State<TapTweet> createState() => _TapTweetState();
}

class _TapTweetState extends State<TapTweet> {
  late ReplyTweetModel tweetData;
  bool isbuild = false;

  late Future<List<ReplyTweetModel>> comments;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    tweetData = ModalRoute.of(context)?.settings.arguments as ReplyTweetModel;

    int likesCount = tweetData.likes_count;

    // TODO: implent replies count and retweets count
    int retweetsCount = tweetData.retweets_count;
    // ignore: unused_local_variable
    int repliesCount = tweetData.replies_count;

    log("Likes Count $likesCount repliesCount $repliesCount retweetsCount $retweetsCount");
    // log(tweetData.is_reply.toString());
    // log(tweetData.toString());
    UserManagementBloc userBloc = context.read<UserManagementBloc>();
    // log(userBloc.access_token);
    // log(userBloc.userdata.username.toString());
    // log(userBloc.userdata.followers_count.toString());

    // log(userBloc.userdata.username.toString());
    log(userBloc.access_token);
    log(tweetData.id.toString());

    TweetsManagementRepository rep = TweetsManagementRepository(
        tweetsManagementRequests: TweetsManagementRequests());
    // rep.RetweetATweet(
    //     access_token: userBloc.access_token, tweetID: tweetData.id);

    FollowmanagementCubit followQubit = context.read<FollowmanagementCubit>();

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocListener<TweetsManagementBloc, TweetsManagementStates>(
          listener: (context, state) {
            if (state is TweetDeleteLoading) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Delete Request Send"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is TweetDeleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 1),
                ),
              );
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  if (ModalRoute.of(context)?.settings.name == "/TapTweet") {
                    Navigator.of(context).pop();
                  }
                },
              );
            } else if (state is TweetDeleteFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 2),
                ),
              );
            }

            if (state is RetweetLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Request Send"),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is RetweetSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Retweeted Successfuly"),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is RetweetFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is UnRetweetSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("UnRetweeted Successfuly"),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is UnRetweetFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: Scaffold(
            appBar: myAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BlocBuilder<FollowmanagementCubit, FollowmanagementState>(
                    //   builder: (context, state) {
                    //     if (state is FollowmanagementInitial)
                    //       followQubit.onInit(
                    //           access_token: userBloc.access_token,
                    //           username: userBloc.userdata.username,
                    //           count: 10,
                    //           page: 1);
                    //     if (state is Loading)
                    //       return Text("Loading");
                    //     else if (state is GetFollowingSucess &&
                    //         state is GetFollowingSucess) {
                    //       List<UserModel> data = followQubit.following;
                    //       List<UserModel> data2 = followQubit.followers;
                    //       // log("following ${data.length}");
                    //       // log("followers ${data2.length}");

                    //       return Container();
                    //     } else
                    //       return Text("NO DATA");
                    //   },
                    // ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    tweetbar(screenHeight, context, userBloc, tweetData),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: tweetText(tweetData.content, screenHeight),
                    ),
                    Padding(
                      padding: tweetData.media.isEmpty
                          ? const EdgeInsets.only()
                          : const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                      child: tweetMedia(tweetData.media,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          margin: 15),
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
                              tweetData.retweets_count != 0)
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: tweetButtons(
                        tweet: tweetData,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                    ),
                    const Divider(thickness: 1),
                    if (tweetData.replies_count != 0) Comments(rep, userBloc),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<ReplyTweetModel>> Comments(
      TweetsManagementRepository rep, UserManagementBloc userBloc) {
    if (!isbuild) {
      log("building");
      comments = rep.getTweetRepliesByID(
          access_token: userBloc.access_token, tweetID: tweetData.id);
    }
    return FutureBuilder(
        future: comments,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('${snapshot.error}'),
            //     duration: const Duration(seconds: 2),
            //   ),
            // );
            log("error");
            return Container();
          }
          if (snapshot.hasData) {
            isbuild = true;
            List<ReplyTweetModel> data = snapshot.data;
            // List tweet = snapshot.data;
            if (data.length == 0) return Container();
            return CommentItem(data);
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  ListView CommentItem(List<ReplyTweetModel> data) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          double screenHeight = MediaQuery.of(context).size.height;
          double screenWidth = MediaQuery.of(context).size.width;
          var date = DateFormat("d MMM").format(data[index].created_at);
          return InkWell(
            onTap: () => Navigator.pushNamed(context, "/TapTweet",
                arguments: data[index]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: tweetProfilePicture(
                          data[index].user.profile_image_url, 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                data[index].user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " @" + data[index].user.username,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 85, 76, 76),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "  • " + date,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 85, 76, 76),
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Text(
                            data[index].content,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 85, 76, 76),
                              fontSize: 17,
                            ),
                          ),
                          if (data[index].media.length != 0)
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          tweetMedia(data[index].media,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              margin: 42),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          tweetButtons(
                            tweet: data[index],
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 1)
              ],
            ),
          );
        });
  }

  Widget tweetbar(double screenHeight, BuildContext context,
      UserManagementBloc userBloc, ReplyTweetModel tweet) {
    return ListTile(
      trailing: InkWell(
        child: Icon(Icons.menu_outlined),
        onTap: () {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              )),
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    if (userBloc.userdata.id == tweet.user.id)
                      InkWell(
                        onTap: () {
                          TweetsManagementBloc tweetsBloc =
                              context.read<TweetsManagementBloc>();
                          tweetsBloc.add(
                            DeleteTweetButtonPressed(
                              access_token: userBloc.access_token,
                              tweet_id: tweetData.id,
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text("Delete Tweet"),
                        ),
                      )
                  ],
                );
              });
        },
      ),
      leading: tweetProfilePicture(tweetData.user.profile_image_url, 30),
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
        if (tweetData.replies_count != 0)
          Row(
            children: [
              Text(
                tweetData.replies_count.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                " Replies   ",
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
    required double screenHeight,
    required double screenWidth,
    required ReplyTweetModel tweet,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //replies
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeCount: tweet.replies_count,
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
        //retweet
        LikeButton(
          animationDuration: const Duration(milliseconds: 0),
          likeCount: tweet.retweets_count,
          isLiked: tweet.is_retweeted,
          onTap: (f) {
            var tweetBloc = context.read<TweetsManagementBloc>();
            var userBloc = context.read<UserManagementBloc>();
            tweetBloc.add(RetweetButtonPressed(
                access_token: userBloc.access_token,
                tweet_id: tweet.id,
                is_retweeted: tweet.is_retweeted));
            tweet.is_retweeted = !tweet.is_retweeted;
            setState(() {
              tweet.retweets_count = tweet.is_retweeted
                  ? tweet.retweets_count + 1
                  : tweet.retweets_count - 1;
            });
            return Future.value(tweet.is_retweeted);
          },
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
        //likes
        LikeButton(
          onTap: (f) {
            var tweetBloc = context.read<TweetsManagementBloc>();
            var userBloc = context.read<UserManagementBloc>();
            tweetBloc.add(LikeButtonPressed(
                access_token: userBloc.access_token,
                tweet_id: tweet.id,
                isLiked: tweet.is_liked));
            tweet.is_liked = !tweet.is_liked;
            setState(() {
              tweet.likes_count = tweet.is_liked
                  ? tweet.likes_count + 1
                  : tweet.likes_count - 1;
            });
            return Future.value(tweet.is_liked);
          },
          likeCount: tweet.likes_count,
          isLiked: tweet.is_liked,
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
        //share
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

  Widget tweetProfilePicture(String profilePicture, double radius) {
    return CircleAvatar(
      radius: radius, //20
      backgroundImage: profilePicture.isEmpty
          ? null
          : NetworkImage(
              profilePicture,
            ),
    );
  }

  Widget tweetMedia(List<String> media,
      {required double screenWidth,
      required double screenHeight,
      required double margin}) {
    double gap = margin;
    if (media.isEmpty) {
      return Container();
    } else if (media.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: SizedBox(
            width: screenWidth - (gap * 2), //400
            child: oneImage(media[0])),
      );
    } else if (media.length == 2) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * screenHeight)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: screenWidth / 2 - (1.5 + gap), //400
              height: 0.2 * screenHeight,
              child: oneImage(media[0]),
            ), // 140  160
            const SizedBox(
              width: 3,
            ),
            SizedBox(
              height: 0.2 * screenHeight,
              width: screenWidth / 2 - (1.5 + gap), //400
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
                  width: screenWidth / 2 - (1.5 + gap),
                  height: 0.3 * screenHeight,
                  child: oneImage(media[0])), //150 160
              const SizedBox(
                width: 3,
              ),
              SizedBox(
                width: screenWidth / 2 - (1.5 + gap),
                height: 0.3 * screenHeight, //160
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        height: 0.15 * screenHeight - 1.5,
                        width: screenWidth / 2 - (1.5 + gap),
                        child: oneImage(media[1])), //128 78
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                        height: 0.15 * screenHeight - 1.5,
                        width: screenWidth / 2 - (1.5 + gap),
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
                      width: screenWidth / 2 - (1.5 + gap),
                      child: oneImage(media[0])),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 0.15 * screenHeight - 1.5,
                    width: screenWidth / 2 - (1.5 + gap),
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
                      width: screenWidth / 2 - (1.5 + gap),
                      child: oneImage(media[2]),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 0.15 * screenHeight - 1.5,
                      width: screenWidth / 2 - (1.5 + gap),
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
  DetailScreen({Key? key, @required this.imageUrl}) : super(key: key);
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 45),
        child: Center(
          child: Image.network(
            imageUrl.toString(),
          ),
        ),
      ),
    );
  }
}
