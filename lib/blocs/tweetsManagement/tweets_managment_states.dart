import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';

abstract class TweetsManagementStates extends Equatable {}

class TweetsIntialState extends TweetsManagementStates {
  @override
  List<Object?> get props => [];
}

class TweetsLoadingState extends TweetsManagementStates {
  List<Object?> get props => [];
}

class TweetsRefreshLoadingState extends TweetsManagementStates {
  List<Object?> get props => [];
}

class TweetsFetchingSuccess extends TweetsManagementStates {
  List<ReplyTweetModel> tweets;
  TweetsFetchingSuccess({required this.tweets});
  List<Object?> get props => [];
}

class TweetsFetchingFailed extends TweetsManagementStates {
  String errorMessage;
  TweetsFetchingFailed({required this.errorMessage});
  List<Object?> get props => [];
}

class SuccessLoadingUserProfileTweetsTab extends TweetsManagementStates {
  List<Object?> get props => [];
}

class FailureLoadingUserProfileTweetsTab extends TweetsManagementStates {
  String errorMessage;
  FailureLoadingUserProfileTweetsTab({required this.errorMessage});
  List<Object?> get props => [];
}

class SuccessLoadingUserProfileLikedTweetsTab extends TweetsManagementStates {
  List<Object?> get props => [];
}

class FailureLoadingUserProfileLikedTweetsTab extends TweetsManagementStates {
  String errorMessage;
  FailureLoadingUserProfileLikedTweetsTab({required this.errorMessage});
  List<Object?> get props => [];
}

class SuccessPostingTweet extends TweetsManagementStates {
  TweetModel tweet;
  String message;
  SuccessPostingTweet({required this.tweet, required this.message});
  List<Object?> get props => [];
}

class FailurePostingTweet extends TweetsManagementStates {
  String errorMessage;
  FailurePostingTweet({required this.errorMessage});
  List<Object?> get props => [];
}

class ProcessingTweetLike extends TweetsManagementStates {
  @override
  List<Object?> get props => [];
}

class TweetLikeSuccess extends TweetsManagementStates {
  @override
  List<Object?> get props => [];
}

class TweetLikeFailure extends TweetsManagementStates {
  @override
  List<Object?> get props => [];
}

class TweetUnlikeSuccess extends TweetsManagementStates {
  @override
  List<Object?> get props => [];
}

class TweetDeleteSuccess extends TweetsManagementStates {
  String message;
  TweetDeleteSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class TweetDeleteFailure extends TweetsManagementStates {
  String errorMessage;
   TweetDeleteFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
