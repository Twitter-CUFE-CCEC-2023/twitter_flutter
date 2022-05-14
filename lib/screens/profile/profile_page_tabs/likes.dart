import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/blocs/profileTabs/liked_tweets_tab_cubit.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/widgets/tweet.dart';

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
    var likedTweetsTabCubit = context.watch<LikedTweetsTabCubit>();
    return RefreshIndicator(
      onRefresh: ()  async {
        var tempTweets = await likedTweetsTabCubit.Refresh(
            access_token: userbloc.access_token,
            username: userbloc.userdata.username);
        likedTweetsTabCubit.Tweets_List.clear();
        tweetsList.clear();
        likedTweetsTabCubit.Tweets_List = tempTweets;
        likedTweetsTabCubit.emit(TabLoadSuccessState());
        return Future.value(null);
      },
      child: BlocBuilder<LikedTweetsTabCubit, TabStates>(
        buildWhen: (previous, current) => current is! TabRefreshingState,
        builder: (context, state) {
          print(state);
          if (state is TabinitState) {
            var user = userbloc.userdata;
            likedTweetsTabCubit.onInit(
                access_token: userbloc.access_token, username: user.username);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TabLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TabLoadSuccessState || state is LocalUpadteState) {
            tweetsList.clear();
            for (ReplyTweetModel currentTweet in likedTweetsTabCubit.Tweets_List) {
              tweetsList.add(TweetWidget(
                tweetData: currentTweet,
              ));
            }
            return ListView(
              children: tweetsList,
            );
          } else if (state is TabLoadFailureState) {
            likedTweetsTabCubit.onInit(
                access_token: userbloc.access_token,
                username: userbloc.userdata.username);
            return Stack(
                children: [Center(
                  child: CircularProgressIndicator(),
                ),
                  Center(
                    child: Text('Failed to load tweets'),
                  ),
                ]
            );
          }
          return Container();
        },
      ),
    );
  }
}
