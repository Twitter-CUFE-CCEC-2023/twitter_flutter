import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';

abstract class TweetsManagementStates extends Equatable{}

class TweetsIntialState extends TweetsManagementStates {
  @override
  List<Object?> get props => [];

}

class TweetsLoadingState extends TweetsManagementStates{
  List<Object?> get props => [];
}


class SuccessLoadingUserProfileTweetsTab extends TweetsManagementStates{
  List<Object?> get props => [];
}

class FailureLoadingUserProfileTweetsTab extends TweetsManagementStates{
  String errorMessage;
  FailureLoadingUserProfileTweetsTab({required this.errorMessage});
  List<Object?> get props => [];
}

class SuccessPostingTweet extends TweetsManagementStates{
  TweetModel tweet;
  String message;
  SuccessPostingTweet({required this.tweet, required this.message});
  List<Object?> get props => [];
}

class FailurePostingTweet extends TweetsManagementStates{
  String errorMessage;
  FailurePostingTweet({required this.errorMessage});
  List<Object?> get props => [];
}