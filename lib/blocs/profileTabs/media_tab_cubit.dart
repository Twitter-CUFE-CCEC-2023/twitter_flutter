import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/profileTabs/tab_states.dart';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';
import 'package:twitter_flutter/utils/Web Services/tweets_management_requests.dart';

class MediaTweetsTabCubit extends Cubit<TabStates> {

  final TweetsManagementRepository _repository = TweetsManagementRepository(tweetsManagementRequests: TweetsManagementRequests());
  List<ReplyTweetModel> Tweets_List = [];
  late String  username;
  int page = 1;

  MediaTweetsTabCubit() : super(TabinitState()){}

  void onInit({required access_token,required username}) async {
    try{
      Tweets_List = await _repository.getLoggedUserMediaTweets(access_token: access_token, username: username);
      this.username = username;
      Success(username);
    } on Exception{
      Error();
    }
  }

  void onNewUser({required access_token,required username}) async {
    emit(TabLoadingState());
    try{
      Tweets_List = await _repository.getLoggedUserMediaTweets(access_token: access_token, username: username);
      this.username = username;
      Success(username);
    } on Exception{
      Error();
    }
  }

  void Loading() => emit(TabLoadingState());
  void Success(String username) => emit(TabLoadSuccessState(username: username));
  void Error() => emit(TabLoadFailureState());

  Future<List<ReplyTweetModel>> Refresh({required access_token, required username})  {
    emit(TabRefreshingState());
    try{
      this.username = username;
      return _repository.getLoggedUserMediaTweets(access_token: access_token, username: username);
    } on Exception catch(e) {
      Error();
    }
    return Future.value([]);
  }

  void updateTweet({required tweet_id,required String Action,required String username }){
    switch(Action) {
      case "like":
        {
          if (Tweets_List.contains((element) => element.id == tweet_id)) {
            int index = Tweets_List.indexWhere((element) =>
            element.id == tweet_id);
            Tweets_List[index].is_liked = !Tweets_List[index].is_liked;
            Tweets_List[index].likes_count = Tweets_List[index].is_liked
                ? Tweets_List[index].likes_count + 1
                : Tweets_List[index].likes_count - 1;
          }
          emit(LocalUpadteState(username: username));
          break;
        }
      default:
        break;
    }
  }
}
