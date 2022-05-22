import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvents extends Equatable {}

class StartEvent extends ForgetPasswordEvents {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordButtonPressed extends ForgetPasswordEvents {
  final int verificationCode;
  final String username;
  final String password;
  ForgetPasswordButtonPressed(
      {required this.username, required this.password,required this.verificationCode});
  @override
  List<Object?> get props => [username, password,verificationCode];
}

class ForgetPasswordButtonEmailPressed extends ForgetPasswordEvents {
  final String username;
  ForgetPasswordButtonEmailPressed(
      {required this.username});
  @override
  List<Object?> get props => [username];
}


