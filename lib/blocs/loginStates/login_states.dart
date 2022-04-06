
import 'package:equatable/equatable.dart';

abstract class LoginStates extends Equatable{}

class LoginInitState extends LoginStates{
  @override
  List<Object?> get props =>[];

}

class LoginLoadingState extends LoginStates{
  @override
  List<Object?> get props =>[];
}

class LoginSuccessState extends LoginStates{
  final dynamic userdata;
  LoginSuccessState(this.userdata);
  @override
  List<Object?> get props =>[userdata];
}

class LoginFailureState extends LoginStates{
  final String errorMessage;
  LoginFailureState({required this.errorMessage});
  @override
  List<Object?> get props =>[errorMessage];
}



