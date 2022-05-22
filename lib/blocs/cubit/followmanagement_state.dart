part of 'followmanagement_cubit.dart';

abstract class FollowmanagementState extends Equatable {
  const FollowmanagementState();

  @override
  List<Object> get props => [];
}

class FollowmanagementInitial extends FollowmanagementState {}

class GetFollowersSuccess extends FollowmanagementState {}

class GetFollowersError extends FollowmanagementState {
  final String message;

  const GetFollowersError(this.message);

  @override
  List<Object> get props => [message];
}

class GetFollowingSucess extends FollowmanagementState {}

class GetFollowingError extends FollowmanagementState {
  final String message;

  const GetFollowingError(this.message);

  @override
  List<Object> get props => [message];
}

class Loading extends FollowmanagementState {}
