import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/blocs/profileTabs/tweets_tab_cubit.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/widgets/tweet.dart';

class Tweets extends StatefulWidget {
  final UserModel userdata;
  const Tweets({Key? key, required this.userdata}) : super(key: key);

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
      onRefresh: () async {
        var tempTweets = await tweetTabCubit.Refresh(
            access_token: userbloc.access_token,
            username: widget.userdata.username);
        tweetTabCubit.Tweets_List.clear();
        tweetsList.clear();
        tweetTabCubit.Tweets_List = tempTweets;
        tweetTabCubit
            .emit(TabLoadSuccessState(username: widget.userdata.username));
        return Future.value(null);
      },
      child: BlocBuilder<TweetsTabCubit, TabStates>(
        buildWhen: (previous, current) => current is! TabRefreshingState,
        builder: (context, state) {
          if (state is TabinitState) {
            var user = widget.userdata;
            tweetTabCubit.onInit(
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
            if (tweetTabCubit.username != widget.userdata.username) {
              tweetTabCubit.onNewUser(
                  access_token: userbloc.access_token,
                  username: widget.userdata.username);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            tweetsList.clear();
            for (TweetModel currentTweet in tweetTabCubit.Tweets_List) {
              tweetsList.add(TweetWidget(
                tweetData: ReplyTweetModel.copy(currentTweet, widget.userdata),
              ));
            }
            return ListView(
              children: tweetsList,
            );
          } else if (state is TabLoadFailureState) {
            tweetTabCubit.onInit(
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
