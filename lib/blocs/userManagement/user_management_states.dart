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
  VerificationSuccessState();
  @override
  List<Object?> get props => [];
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

class UpdatePasswordSuccessState extends UserManagementStates {
  final String succesMessage;
  UpdatePasswordSuccessState({required this.succesMessage});
  @override
  List<Object?> get props => [succesMessage];
}

class UpdatePasswordFailureState extends UserManagementStates {
  final String failureMessage;
  UpdatePasswordFailureState({required this.failureMessage});
  @override
  List<Object?> get props => [failureMessage];
}

class EditProfileSuccessState extends UserManagementStates {
  final dynamic userdata;
  EditProfileSuccessState(this.userdata);
  @override
  List<Object?> get props => [userdata];
}

class EditProfileFailureState extends UserManagementStates {
  final String failureMessage;
  EditProfileFailureState({required this.failureMessage});
  @override
  List<Object?> get props => [failureMessage];
}

class LoadProfileSuccessState extends UserManagementStates {
  final dynamic userdata;
  LoadProfileSuccessState(this.userdata);
  @override
  List<Object?> get props => [userdata];
}

class LoadProfileFailureState extends UserManagementStates {
  final String errorMessage;
  LoadProfileFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class LogoutSuccessState extends UserManagementStates {
  LogoutSuccessState();
  @override
  List<Object?> get props => [];
}

class FollowSuccessState extends UserManagementStates {
  final dynamic userdata;
  FollowSuccessState(this.userdata);
  @override
  List<Object?> get props => [userdata];
}

class FollowFailureState extends UserManagementStates {
  final String errorMessage;
  FollowFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
