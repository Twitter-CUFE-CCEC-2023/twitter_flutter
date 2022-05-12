import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/tweetsManagement/tweets_management_events.dart';
import '../../../blocs/tweetsManagement/tweets_managment_bloc.dart';
import '../../../blocs/tweetsManagement/tweets_managment_states.dart';
import '../../../blocs/userManagement/user_management_bloc.dart';
import '../../../models/objects/tweet.dart';
import '../../../widgets/tweet.dart';

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  List<Widget> tweetsList = [];
  @override
  Widget build(BuildContext context) {

    var userbloc = context.read<UserManagementBloc>();
    var tweetbloc = context.read<TweetsManagementBloc>();

    //if(tweetbloc.LoggedUserLikedTweets.isEmpty){
      //tweetbloc.LoggedUserLikedTweets.clear();
      tweetbloc.add(UserProfileLikedTweetsTabOpen(
          username: userbloc.userdata.username,
          access_token: userbloc.access_token));
    //}

    return BlocConsumer<TweetsManagementBloc, TweetsManagementStates>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is TweetsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SuccessLoadingUserProfileLikedTweetsTab) {
          for (ReplyTweetModel currentTweet
          in tweetbloc.LoggedUserLikedTweets) {
            tweetsList.add(TweetWidget(
              tweetData: currentTweet,
            ));
          }
          if (tweetsList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text('Like Some Tweets', style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 40),),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: Text(
                      "Tap the heart on any Tweet to show it some love. when you do, it'll show up here.",
                      style: TextStyle(fontSize: 20, color: Colors.grey,),
                      textAlign: TextAlign.left,),
                  ),
                ],
              ),
            );
          }
          return ListView(
            children: tweetsList,
          );
        }else{
          return Container();
        }
      },
      listener: (context, state) {
        if (state is FailureLoadingUserProfileLikedTweetsTab) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
    );
  }
}
