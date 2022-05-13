import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';
import 'package:twitter_flutter/utils/Web Services/tweets_management_requests.dart';

class TweetsTabCubit extends Cubit<TabStates> {

  final TweetsManagementRepository _repository = TweetsManagementRepository(tweetsManagementRequests: TweetsManagementRequests());
  List<TweetModel> Tweets_List = [];

  TweetsTabCubit() : super(TabinitState()){}

  void onInit({required access_token,required username}) async {
    try{
      Tweets_List = await _repository.getLoggedUserTweets(access_token: access_token, username: username);
      Success();
    } on Exception{
      Error();
    }
  }
  void Loading() => emit(TabLoadingState());
  void Success() => emit(TabLoadSuccessState());
  void Error() => emit(TabLoadFailureState());

  Future<List<TweetModel>> Refresh({required access_token, required username})  {
    emit(TabRefreshingState());
    try{
      return _repository.getLoggedUserTweets(access_token: access_token, username: username);
    } on Exception{
      Error();
    }
    return Future.value([]);
  }
}
