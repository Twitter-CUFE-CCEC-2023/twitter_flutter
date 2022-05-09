import 'package:equatable/equatable.dart';

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