import 'package:equatable/equatable.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

abstract class LoginEvents extends Equatable {}

class StartEvent extends LoginEvents {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvents {
  final String username;
  final String password;
  static const bool rememberMe = true;
  LoginButtonPressed({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}

class SignupButtonPressed extends LoginEvents {
  final String name, password, email, date, username, gender;
  SignupButtonPressed(
      {required this.name,
      required this.password,
      required this.email,
      required this.username,
      required this.gender,
      required this.date});
  @override
  List<Object?> get props => [name, password, email, date];
}
