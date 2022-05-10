import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import '../../../models/objects/tweet.dart';
import 'package:twitter_flutter/widgets/tweet.dart';

class Tweets extends StatefulWidget {
  const Tweets({Key? key}) : super(key: key);

  @override
  State<Tweets> createState() => _TweetsState();
}

class _TweetsState extends State<Tweets> {
  List<Widget> tweetsList = [];
  @override
  Widget build(BuildContext context) {
    var userbloc = context.read<UserManagementBloc>();
    var tweetbloc = context.read<TweetsManagementBloc>();
    tweetbloc.add(UserProfileTweetsTabOpen(
        username: userbloc.userdata.username,
        access_token: userbloc.access_token));

    return BlocConsumer<TweetsManagementBloc, TweetsManagementStates>(
        builder: (context, state) {
      if (state is TweetsLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SuccessLoadingUserProfileTweetsTab) {
        var user = userbloc.userdata;
        for (TweetModel currentTweet
            in tweetbloc.LoggedUserTweetsWithoutReplies) {
          tweetsList.add(TweetWidget(
            tweetData: ReplyTweetModel.copy(currentTweet, user),
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
