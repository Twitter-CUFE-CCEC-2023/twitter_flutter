import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/blocs/profileTabs/tweets_tab_cubit.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
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
    var tweetTabCubit = context.watch<TweetsTabCubit>();
    return RefreshIndicator(
      onRefresh: ()  async {
        print('refreshing');
        var tempTweets = await tweetTabCubit.Refresh(
            access_token: userbloc.access_token,
            username: userbloc.userdata.username);
        tweetTabCubit.Tweets_List.clear();
        tweetTabCubit.Tweets_List.addAll(tempTweets);
        tweetTabCubit.emit(TabLoadSuccessState());
        return Future.value(null);
      },
      child: BlocBuilder<TweetsTabCubit, TabStates>(
        buildWhen: (previous, current) => current is! TabRefreshingState,
        builder: (context, state) {
          if (state is TabinitState) {
            var user = userbloc.userdata;
            tweetTabCubit.onInit(
                access_token: userbloc.access_token, username: user.username);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TabLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TabLoadSuccessState) {
            for (TweetModel currentTweet in tweetTabCubit.Tweets_List) {
              tweetsList.clear();
              tweetsList.add(TweetWidget(
                tweetData:
                    ReplyTweetModel.copy(currentTweet, userbloc.userdata),
              ));
              return ListView(
                children: tweetsList,
              );
            }
          } else if (state is TabLoadFailureState) {
            tweetTabCubit.onInit(
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
