import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/blocs/profileTabs/liked_tweets_tab_cubit.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/widgets/tweet.dart';

import 'package:twitter_flutter/models/objects/user.dart';

class Likes extends StatefulWidget {
  final UserModel userdata;
  const Likes({Key? key, required this.userdata}) : super(key: key);
  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  List<Widget> tweetsList = [];
  @override
  Widget build(BuildContext context) {
    var userbloc = context.read<UserManagementBloc>();
    var likedTweetTabCubit = context.watch<LikedTweetsTabCubit>();

    return RefreshIndicator(
      onRefresh: () async {
        var tempTweets = await likedTweetTabCubit.Refresh(
            access_token: userbloc.access_token,
            username: widget.userdata.username);
        likedTweetTabCubit.Tweets_List.clear();
        tweetsList.clear();
        likedTweetTabCubit.Tweets_List = tempTweets;
        likedTweetTabCubit
            .emit(TabLoadSuccessState(username: widget.userdata.username));
        return Future.value(null);
      },
      child: BlocBuilder<LikedTweetsTabCubit, TabStates>(
        buildWhen: (previous, current) => current is! TabRefreshingState,
        builder: (context, state) {
          if (state is TabinitState) {
            var user = widget.userdata;
            likedTweetTabCubit.onInit(
                access_token: userbloc.access_token, username: user.username);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TabLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          } else if (state is TabLoadSuccessState ||
              state is LocalUpadteState) {
            if (likedTweetTabCubit.username != widget.userdata.username) {
              likedTweetTabCubit.onNewUser(
                  access_token: userbloc.access_token,
                  username: widget.userdata.username);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            tweetsList.clear();
            for (ReplyTweetModel currentTweet in likedTweetTabCubit.Tweets_List) {
              tweetsList.add(TweetWidget(
                tweetData: currentTweet,
              ));
            }
            return ListView(
              children: tweetsList,
            );
          } else if (state is TabLoadFailureState) {
            likedTweetTabCubit.onInit(
                access_token: userbloc.access_token,
                username: widget.userdata.username);
            return Stack(children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              Center(
                child: Text('Failed to load tweets --Retrying'),
              ),
            ]);
          }
          return Container();
        },
      ),
    );
  }
}
