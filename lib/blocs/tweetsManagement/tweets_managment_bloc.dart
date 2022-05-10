import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';

class TweetsManagementBloc
    extends Bloc<TweetsManagementEvents, TweetsManagementStates> {
  late TweetsManagementRepository tweetsManagementRepository;
  late List<TweetModel> LoggedUserTweetsWithoutReplies;
  TweetsManagementBloc({required this.tweetsManagementRepository})
      : super(TweetsIntialState()) {
    on<UserProfileTweetsTabOpen>(_onUserProfileTweetsTabOpen);
    on<PostTweetButtonPressed>(_onPostTweetButtonPressed);
  }

  void _onUserProfileTweetsTabOpen(UserProfileTweetsTabOpen event,
      Emitter<TweetsManagementStates> emit) async {
    emit(TweetsLoadingState());
    try {
      var tweets = await tweetsManagementRepository.getLoggedUserTweets(
          access_token: event.access_token, username: event.username);
      LoggedUserTweetsWithoutReplies = tweets;
      //print(tweets);
      emit(SuccessLoadingUserProfileTweetsTab());
    } on Exception catch (e) {
      emit(FailureLoadingUserProfileTweetsTab(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  void _onPostTweetButtonPressed(PostTweetButtonPressed event,
      Emitter<TweetsManagementStates> emit) async {
    emit(TweetsLoadingState());
    try {
      var tweets = await tweetsManagementRepository.postTweet(
          access_token: event.access_token, content: event.tweet_content);

      emit(SuccessPostingTweet(
          message: "Tweet posted successfully", tweet: tweets));
    } on Exception catch (e) {
      emit(FailurePostingTweet(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }
}
