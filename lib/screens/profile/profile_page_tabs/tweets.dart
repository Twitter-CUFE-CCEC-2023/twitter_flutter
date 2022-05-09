import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsStates/tweets_managment_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsStates/tweets_managment_states.dart';
import 'package:twitter_flutter/blocs/tweetsStates/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import '../../../models/objects/tweet.dart';
import '../tweets_widget.dart';

class Tweets extends StatefulWidget {
  const Tweets({Key? key}) : super(key: key);

  @override
  State<Tweets> createState() => _TweetsState();
}

class _TweetsState extends State<Tweets> {
  @override
  Widget build(BuildContext context) {
    var userbloc = context.read<UserManagementBloc>();
    var tweetbloc = context.read<TweetsManagementBloc>();
    tweetbloc.add(UserProfileTweetsTabOpen(username: userbloc.userdata.username,access_token: userbloc.access_token));
    return BlocConsumer<TweetsManagementBloc, TweetsManagementStates>(
        builder: (context, state) {
      if (state is TweetsLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SuccessLoadingUserProfileTweetsTab) {
        var user = userbloc.userdata;
        double ScreenWidth = MediaQuery.of(context).size.width;
        double ScreenHeight = MediaQuery.of(context).size.height;
        List<Widget> tweetsList = [];
        for (TweetModel currentTweet
            in tweetbloc.LoggedUserTweetsWithoutReplies) {
          tweetsList.add(tweet(
            screenWidth: ScreenWidth,
            screenHeight: ScreenHeight,
            CommentCount: currentTweet.replies_count,
            imageCount: currentTweet.media.length,
            likeCount: currentTweet.likes_count,
            retweetCount: currentTweet.retweets_count,
            user_Name: user.username,
            userProfilePicture: user.profile_image_url,
            tweet_Text: currentTweet.content,
          ));
        }
        return ListView(
          children: tweetsList,
        );
      } else
        return Container();
    }, listener: (context, state) {
      if (state is FailureLoadingUserProfileTweetsTab) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
          ),
        );
      }
    });
  }
}
