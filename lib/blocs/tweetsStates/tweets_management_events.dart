import 'package:equatable/equatable.dart';

abstract class TweetsManagementEvents extends Equatable{}

class UserProfileTweetsTabOpen extends TweetsManagementEvents{
  String access_token;
  String username;

  UserProfileTweetsTabOpen({required this.access_token,required this.username});

  List<Object?> get props =>[];
}
