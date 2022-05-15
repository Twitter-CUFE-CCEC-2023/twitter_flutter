import 'package:equatable/equatable.dart';

abstract class TweetsManagementEvents extends Equatable {}

class UserProfileTweetsTabOpen extends TweetsManagementEvents {
  String access_token;
  String username;
  UserProfileTweetsTabOpen(
      {required this.access_token, required this.username});
  List<Object?> get props => [access_token, username];
}

class UserProfileLikedTweetsTabOpen extends TweetsManagementEvents {
  String access_token;
  String username;
  UserProfileLikedTweetsTabOpen(
      {required this.access_token, required this.username});
  List<Object?> get props => [access_token, username];
}

class PostTweetButtonPressed extends TweetsManagementEvents {
  String access_token;
  String tweet_content;
  PostTweetButtonPressed(
      {required this.access_token, required this.tweet_content});
  @override
  List<Object?> get props => [access_token, tweet_content];
}

class IntialHomePage extends TweetsManagementEvents {
  String access_token;
  int count;
  int page;
  IntialHomePage(
      {required this.access_token, required this.count, required this.page});
  List<Object?> get props => [access_token, count];
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
      {required this.access_token,
      required this.tweet_id});
  List<Object?> get props => [access_token, tweet_id];
}