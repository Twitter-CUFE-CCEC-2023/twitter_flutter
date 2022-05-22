import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/utils/Web%20Services/Follow_management_request.dart';

import '../../repositories/user_management_repository.dart';

part 'followmanagement_state.dart';

class FollowmanagementCubit extends Cubit<FollowmanagementState> {
  final UserFollowRepository repo =
      UserFollowRepository(userFollowRequest: UserFollowerRequests());
  FollowmanagementCubit() : super(FollowmanagementInitial());

  List<UserModel> followers = [];
  List<UserModel> following = [];

  Future<void> onInit(
      {required access_token,
      required username,
      required count,
      required page}) async {
    try {
      await getFollowers(
          access_token: access_token, username: username, count: count, page: page);
      await GetFollowing(
          access_token: access_token, username: username, count: count, page: page);
    } on Exception {
      Error();
    }
  }

  Future<void> getFollowers(
      {required access_token,
      required username,
      required count,
      required page}) async {
    try {
      var followers = await repo.getFollowers(
        access_token: access_token,
        username: username,
        count: count,
        page: page,
      );
      this.followers = followers;
      emit(GetFollowersSuccess());
    } on Exception catch (e) {
      emit(GetFollowersError(e.toString().replaceAll("Exception: ", "")));
    }
    return Future.value([]);
  }

  Future<void> GetFollowing(
      {required access_token,
      required username,
      required count,
      required page}) async {
    try {
      var following = await repo.getFollowing(
        access_token: access_token,
        username: username,
        count: count,
        page: page,
      );
      this.following = following;
      emit(GetFollowingSucess());
    } on Exception catch (e) {
      emit(GetFollowingError(e.toString().replaceAll("Exception: ", "")));
    }
    return Future.value([]);
  }
}
