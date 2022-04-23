
import 'package:equatable/equatable.dart';

abstract class UpdatePasswordStates extends Equatable{}

class UpdatePasswordInitState extends UpdatePasswordStates{
  @override
  List<Object?> get props =>[];

}

class UpdatePasswordLoadingState extends UpdatePasswordStates{
  @override
  List<Object?> get props =>[];
}

class UpdatePasswordSuccessState extends UpdatePasswordStates{
  final String succesMessage;
  UpdatePasswordSuccessState({required this.succesMessage});
  @override
  List<Object?> get props =>[succesMessage];
}

class UpdatePasswordFailureState extends UpdatePasswordStates{
  final String failureMessage;
  UpdatePasswordFailureState({required this.failureMessage});
  @override
  List<Object?> get props =>[failureMessage];
}



