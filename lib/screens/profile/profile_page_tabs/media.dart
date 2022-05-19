import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/profileTabs/media_tab_cubit.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/blocs/profileTabs/liked_tweets_tab_cubit.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/widgets/tweet.dart';

import 'package:twitter_flutter/models/objects/user.dart';

class Media extends StatefulWidget {
  final UserModel userdata;
  const Media({Key? key, required this.userdata}) : super(key: key);
  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  List<Widget> tweetsList = [];
  @override
  Widget build(BuildContext context) {
    var userbloc = context.read<UserManagementBloc>();
    var mediaTweetsTabCubit = context.watch<MediaTweetsTabCubit>();

    return RefreshIndicator(
      onRefresh: () async {
        var tempTweets = await mediaTweetsTabCubit.Refresh(
            access_token: userbloc.access_token,
            username: widget.userdata.username);
        mediaTweetsTabCubit.Tweets_List.clear();
        tweetsList.clear();
        mediaTweetsTabCubit.Tweets_List = tempTweets;
        mediaTweetsTabCubit
            .emit(TabLoadSuccessState(username: widget.userdata.username));
        return Future.value(null);
      },
      child: BlocBuilder<LikedTweetsTabCubit, TabStates>(
        buildWhen: (previous, current) => current is! TabRefreshingState || current is! TabLoadingState,
        builder: (context, state) {
          print(state);
          if (state is TabinitState) {
            var user = widget.userdata;
            mediaTweetsTabCubit.onInit(
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
            if (mediaTweetsTabCubit.username != widget.userdata.username) {
              print(mediaTweetsTabCubit.username);
              print(widget.userdata.username);
              mediaTweetsTabCubit.onNewUser(
                  access_token: userbloc.access_token,
                  username: widget.userdata.username);
              print("username should be equal here");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            tweetsList.clear();
            for (ReplyTweetModel currentTweet in mediaTweetsTabCubit.Tweets_List) {
              tweetsList.add(TweetWidget(
                tweetData: currentTweet,
              ));
            }
            return ListView(
              children: tweetsList,
            );
          } else if (state is TabLoadFailureState) {
            mediaTweetsTabCubit.onInit(
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
