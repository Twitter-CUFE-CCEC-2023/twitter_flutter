import 'package:equatable/equatable.dart';

abstract class TweetsManagementEvents extends Equatable{}

class UserProfileTweetsTabOpen extends TweetsManagementEvents{
  String access_token;
  String username;
  UserProfileTweetsTabOpen({required this.access_token,required this.username});
  List<Object?> get props =>[access_token,username];
}

class PostTweetButtonPressed extends TweetsManagementEvents{
  String access_token;
  String tweet_content;
  PostTweetButtonPressed({required this.access_token,required this.tweet_content});
  @override
  List<Object?> get props => [access_token,tweet_content];


}
