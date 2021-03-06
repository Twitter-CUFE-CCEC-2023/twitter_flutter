import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class TweetsManagementEvents extends Equatable {}

class PostTweetButtonPressed extends TweetsManagementEvents {
  String access_token;
  String tweet_content;
  List<File> media;
  PostTweetButtonPressed(
      {required this.access_token,
      required this.tweet_content,
      required this.media});
  @override
  List<Object?> get props => [access_token, tweet_content];
}

class PostReplayButtonPressed extends TweetsManagementEvents {
  String access_token;
  String tweet_content;
  List<File> media;
  String Replay_id;
  PostReplayButtonPressed(
      {required this.access_token,
      required this.tweet_content,
      required this.media,
      required this.Replay_id});
  @override
  List<Object?> get props => [access_token, tweet_content];
}

class IntialHomePage extends TweetsManagementEvents {
  String access_token;
  int count;
  int page;
  IntialHomePage(
      {required this.access_token, required this.count, required this.page});
  List<Object?> get props => [access_token, count, page];
}

class OnRefresh extends TweetsManagementEvents {
  String access_token;
  int count;
  int page;
  OnRefresh(
      {required this.access_token, required this.count, required this.page});
  List<Object?> get props => [access_token, count];
}

class LikeButtonPressed extends TweetsManagementEvents {
  String access_token;
  String tweet_id;
  bool isLiked;
  LikeButtonPressed(
      {required this.access_token,
      required this.tweet_id,
      required this.isLiked});
  List<Object?> get props => [access_token, tweet_id, isLiked];
}

class DeleteTweetButtonPressed extends TweetsManagementEvents {
  String access_token;
  String tweet_id;
  DeleteTweetButtonPressed(
      {required this.access_token, required this.tweet_id});
  List<Object?> get props => [access_token, tweet_id];
}

class RetweetButtonPressed extends TweetsManagementEvents {
  String access_token;
  String tweet_id;
  bool is_retweeted;
  RetweetButtonPressed(
      {required this.access_token,
      required this.tweet_id,
      required this.is_retweeted});
  List<Object?> get props => [access_token, tweet_id];
}
