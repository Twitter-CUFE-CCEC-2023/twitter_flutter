import 'package:equatable/equatable.dart';

abstract class EditProfileStates extends Equatable {}

class EditProfileInitState extends EditProfileStates {
  @override
  List<Object?> get props => [];
}

class EditProfileLoadingState extends EditProfileStates {
  @override
  List<Object?> get props => [];
}

class EditProfileSuccessState extends EditProfileStates {
  final dynamic userdata;
  EditProfileSuccessState(this.userdata);
  @override
  List<Object?> get props =>[userdata];
}


class EditProfileFailureState extends EditProfileStates {
  final String failureMessage;
  EditProfileFailureState({required this.failureMessage});
  @override
  List<Object?> get props => [failureMessage];
}
