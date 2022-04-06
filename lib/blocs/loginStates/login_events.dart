
import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable{}

class StartEvent extends LoginEvents{
  @override
  List<Object?> get props =>[];
}

class LoginButtonPressed extends LoginEvents{
  final String username;
  final String password;
  static const bool rememberMe = true;
  LoginButtonPressed({required this.username,required this.password});
  @override
  List<Object?> get props =>[username,password];  
}