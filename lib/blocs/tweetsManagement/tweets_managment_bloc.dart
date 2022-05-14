import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_states.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';
import 'package:twitter_flutter/screens/profile/profile_page_tabs/tweets.dart';

class TweetsManagementBloc
    extends Bloc<TweetsManagementEvents, TweetsManagementStates> {
  late TweetsManagementRepository tweetsManagementRepository;
  late List<TweetModel> LoggedUserTweetsWithoutReplies = [];
  late List<ReplyTweetModel> LoggedUserLikedTweets = [];
  late List<ReplyTweetModel> homeTweets = [];
  late List<ReplyTweetModel> newTweets = [];
  TweetsManagementBloc({required this.tweetsManagementRepository})
      : super(TweetsIntialState()) {
    //on<UserProfileTweetsTabOpen>(_onUserProfileTweetsTabOpen);
    on<PostTweetButtonPressed>(_onPostTweetButtonPressed);
    on<IntialHomePage>(_onIntialTweetFetching);
    on<OnRefresh>(_onTweetFetching);
    on<LikeButtonPressed>(_onLikeButtonPressed);
    on<UserProfileLikedTweetsTabOpen>(_onUserProfileLikedTweetsTabOpen);
  }
  void _onIntialTweetFetching(
      IntialHomePage event, Emitter<TweetsManagementStates> emit) async {
    emit(TweetsLoadingState());

    try {
      var tweets = await tweetsManagementRepository.fetchTweets(
          access_token: event.access_token,
          count: event.count,
          page: event.page);
      newTweets = tweets;

      for (var tweet in tweets) {
        homeTweets.add(tweet);
      }

      emit(TweetsFetchingSuccess(tweets: tweets));
    } on Exception catch (e) {
      emit(TweetsFetchingFailed(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  void _onTweetFetching(
      OnRefresh event, Emitter<TweetsManagementStates> emit) async {
    try {
      var tweets = await tweetsManagementRepository.fetchTweets(
          access_token: event.access_token,
          count: event.count,
          page: event.page);
      newTweets = tweets;

      for (var tweet in tweets) {
        homeTweets.add(tweet);
      }

      emit(TweetsFetchingSuccess(tweets: tweets));
    } on Exception catch (e) {
      emit(TweetsFetchingFailed(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  // void _onUserProfileTweetsTabOpen(UserProfileTweetsTabOpen event,
  //     Emitter<TweetsManagementStates> emit) async {
  //   emit(TweetsLoadingState());
  //   try {
  //     var tweets = await tweetsManagementRepository.getLoggedUserTweets(
  //         access_token: event.access_token, username: event.username);
  //     LoggedUserTweetsWithoutReplies.clear();
  //     LoggedUserTweetsWithoutReplies = tweets;
  //     //print(tweets);
  //     emit(SuccessLoadingUserProfileTweetsTab());
  //   } on Exception catch (e) {
  //     if (e.toString().contains("Undefined")) {
  //       emit(SuccessLoadingUserProfileLikedTweetsTab());
  //       print("printing cached data on error response --t");
  //     } else {
  //       emit(FailureLoadingUserProfileTweetsTab(
  //           errorMessage: e.toString().replaceAll("Exception: ", "")));
  //     }
  //   }
  // }

  void _onUserProfileLikedTweetsTabOpen(UserProfileLikedTweetsTabOpen event,
      Emitter<TweetsManagementStates> emit) async {
    emit(TweetsLoadingState());
    try {
      var tweets = await tweetsManagementRepository.getLoggedUserLikedTweets(
          access_token: event.access_token,
          username: event.username,
          count: 10);
      LoggedUserLikedTweets.clear();
      LoggedUserLikedTweets = tweets;
      emit(SuccessLoadingUserProfileLikedTweetsTab());
    } on Exception catch (e) {
      if (e.toString().contains("Undefined")) {
        emit(SuccessLoadingUserProfileLikedTweetsTab());
        print("printing cached data on error response --lt");
      } else {
        emit(FailureLoadingUserProfileLikedTweetsTab(
            errorMessage: e.toString().replaceAll("Exception: ", "")));
      }
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

  void _onLikeButtonPressed(
      LikeButtonPressed event, Emitter<TweetsManagementStates> emit) async {
    try {
      //emit(ProcessingTweetLike());
      if (!event.isLiked) {
        var tweet = await tweetsManagementRepository.likeTweet(
            access_token: event.access_token, tweet_id: event.tweet_id);
        //emit(TweetLikeSuccess());
      } else {
        var tweet = await tweetsManagementRepository.unlikeTweet(
            access_token: event.access_token, tweet_id: event.tweet_id);
        //emit(TweetUnlikeSuccess());
      }
    } on Exception catch (e) {
      //emit(TweetLikeFailure());
    }
  }
}
