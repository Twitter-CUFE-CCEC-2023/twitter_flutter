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

  TweetsManagementBloc({required this.tweetsManagementRepository})
      : super(TweetsIntialState()) {
    on<PostTweetButtonPressed>(_onPostTweetButtonPressed);
    on<LikeButtonPressed>(_onLikeButtonPressed);
    on<DeleteTweetButtonPressed>(_onDeleteTweetButtonPressed);
    on<RetweetButtonPressed>(_onRetweetButtonPressed);
    on<PostReplayButtonPressed>(_onReplayTweetButtonPressed);
  }

  void _onPostTweetButtonPressed(PostTweetButtonPressed event,
      Emitter<TweetsManagementStates> emit) async {
    emit(TweetsLoadingState());
    try {
      var tweets = await tweetsManagementRepository.postTweet(
          access_token: event.access_token,
          content: event.tweet_content,
          media: event.media);

      emit(SuccessPostingTweet(
          message: "Tweet posted successfully", tweet: tweets));
    } on Exception catch (e) {
      emit(FailurePostingTweet(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  void _onReplayTweetButtonPressed(PostReplayButtonPressed event,
      Emitter<TweetsManagementStates> emit) async {
    emit(TweetsLoadingState());
    try {
      var tweets = await tweetsManagementRepository.postReplay(
          access_token: event.access_token,
          content: event.tweet_content,
          replay_id: event.Replay_id,
          media: event.media);

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

  void _onDeleteTweetButtonPressed(DeleteTweetButtonPressed event,
      Emitter<TweetsManagementStates> emit) async {
    try {
      emit(TweetDeleteLoading());
      var tweet = await tweetsManagementRepository.deleteTweet(
          access_token: event.access_token, tweet_id: event.tweet_id);
      emit(TweetDeleteSuccess(
        message: "Tweet deleted successfully",
      ));
    } on Exception catch (e) {
      emit(TweetDeleteFailure(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  void _onRetweetButtonPressed(
      RetweetButtonPressed event, Emitter<TweetsManagementStates> emit) async {
    emit(RetweetLoading());
    if (!event.is_retweeted) {
      try {
        await tweetsManagementRepository.RetweetATweet(
            access_token: event.access_token, tweetID: event.tweet_id);
        emit(RetweetSuccess());
      } on Exception catch (e) {
        emit(TweetDeleteFailure(
            errorMessage: e.toString().replaceAll("Exception: ", "")));
      }
    } else {
      try {
        await tweetsManagementRepository.UnRetweet(
            access_token: event.access_token, tweetID: event.tweet_id);
        emit(UnRetweetSuccess());
      } on Exception catch (e) {
        emit(TweetDeleteFailure(
            errorMessage: e.toString().replaceAll("Exception: ", "")));
      }
    }
  }
}
