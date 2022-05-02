import 'package:equatable/equatable.dart';

abstract class UserManagementStates extends Equatable {}

class InitState extends UserManagementStates {
  @override
  List<Object?> get props => [];
}

class LoadingState extends UserManagementStates {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends UserManagementStates {
  final dynamic userdata;
  LoginSuccessState(this.userdata);
  @override
  List<Object?> get props => [userdata];
}

class LoginFailureState extends UserManagementStates {
  final String errorMessage;
  LoginFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}


class VerificationSuccessState extends UserManagementStates {
  final dynamic userdata;
  VerificationSuccessState(this.userdata);
  @override
  List<Object?> get props => [userdata];
}

class VerificationFailureState extends UserManagementStates {
  final String errorMessage;
  VerificationFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class SignupSuccessState extends UserManagementStates {
  final dynamic userdata;
  SignupSuccessState({required this.userdata});
  @override
  List<Object?> get props => [userdata];
}

class SignupFailureState extends UserManagementStates {
  final String errorMessage;
  SignupFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class UpdatePasswordSuccessState extends UserManagementStates{
  final String succesMessage;
  UpdatePasswordSuccessState({required this.succesMessage});
  @override
  List<Object?> get props =>[succesMessage];
}

class UpdatePasswordFailureState extends UserManagementStates{
  final String failureMessage;
  UpdatePasswordFailureState({required this.failureMessage});
  @override
  List<Object?> get props =>[failureMessage];
}

class EditProfileSuccessState extends UserManagementStates {
  final dynamic userdata;
  EditProfileSuccessState(this.userdata);
  @override
  List<Object?> get props =>[userdata];
}


class EditProfileFailureState extends UserManagementStates {
  final String failureMessage;
  EditProfileFailureState({required this.failureMessage});
  @override
  List<Object?> get props => [failureMessage];
}