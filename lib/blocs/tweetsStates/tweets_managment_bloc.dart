import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/tweetsStates/tweets_management_events.dart';
import 'package:twitter_flutter/blocs/tweetsStates/tweets_managment_states.dart';
import 'package:twitter_flutter/blocs/tweetsStates/tweets_management_events.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';

class TweetsManagementBloc
    extends Bloc<TweetsManagementEvents, TweetsManagementStates> {
  late TweetsManagementRepository tweetsManagementRepository;
  late List<TweetModel> LoggedUserTweetsWithoutReplies;
  TweetsManagementBloc({required this.tweetsManagementRepository})
      : super(TweetsIntialState()) {
    on<UserProfileTweetsTabOpen>(_onUserProfileTweetsTabOpen);
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
}
