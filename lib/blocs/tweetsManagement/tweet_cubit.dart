import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';
import 'package:twitter_flutter/utils/Web%20Services/tweets_management_requests.dart';

class tweetCubit extends Cubit<TweetsManagementStates> {
  final TweetsManagementRepository _repository = TweetsManagementRepository(
    tweetsManagementRequests: TweetsManagementRequests(),
  );
  List<ReplyTweetModel> newTweet = [];
  List<ReplyTweetModel> homeList = [];
  int pageNumber = 1;
  tweetCubit() : super(TweetsIntialState());

  void onInit({required access_token, required count, required page}) async {
    Loading();
    try {
      var tweets = await _repository.fetchTweets(
        access_token: access_token,
        count: count,
        page: page,
      );
      newTweet = tweets;
      for (int i = 0; i < newTweet.length; i++) {
        homeList.add(newTweet[i]);
      }
      Success();
    } on Exception catch (e) {
      Error(
        e.toString().replaceAll("Exception: ", ""),
      );
    }
  }

  Future<void> Refresh(
      {required access_token, required count, required page}) async {
    tweetRefresh();
    try {
      var tweets = await _repository.fetchTweets(
        access_token: access_token,
        count: count,
        page: page,
      );

      newTweet = tweets;
      for (int i = 0; i < newTweet.length; i++) {
        homeList.add(newTweet[i]);
      }
      Success();
    } on Exception catch (e) {
      Error(
        e.toString().replaceAll("Exception: ", ""),
      );
    }
  }

  void Success() {
    emit(TweetsFetchingSuccess(tweets: newTweet));
  }

  void Error(message) {
    emit(TweetsFetchingFailed(errorMessage: message));
  }

  void Loading() {
    emit(TweetsLoadingState());
  }

  void tweetRefresh() {
    emit(TweetsRefreshLoadingState());
  }
}
