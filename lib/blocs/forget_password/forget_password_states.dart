import 'package:equatable/equatable.dart';

abstract class ForgetPasswordStates extends Equatable {}

class InitState extends ForgetPasswordStates {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ForgetPasswordStates {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final String successMessage;
  ForgetPasswordSuccessState({required this.successMessage});
  @override
  List<Object?> get props => [successMessage];
}

class ForgetPasswordFailureState extends ForgetPasswordStates {
  final String errorMessage;
  ForgetPasswordFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class ForgetPasswordEmailSuccessState extends ForgetPasswordStates {
  final String successMessage;
  ForgetPasswordEmailSuccessState({required this.successMessage});
  @override
  List<Object?> get props => [successMessage];
}

class ForgetPasswordEmailFailureState extends ForgetPasswordStates {
  final String errorMessage;
  ForgetPasswordEmailFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}