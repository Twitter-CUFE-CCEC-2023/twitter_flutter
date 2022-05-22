import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/forget_password/forget_password_states.dart';
import 'package:twitter_flutter/blocs/forget_password/forget_password_events.dart';
import 'package:twitter_flutter/repositories/user_management_repository.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvents, ForgetPasswordStates> {

  UserManagementRepository forgetPasswordRepository;
  ForgetPasswordBloc({required this.forgetPasswordRepository})
      : super(InitState()) {
    on<ForgetPasswordButtonPressed>(_onForgetPasswordButtonPressed);
    on<ForgetPasswordButtonEmailPressed>(_onForgetPasswordEmailButtonPressed);
  }

  void _onForgetPasswordButtonPressed(
      ForgetPasswordButtonPressed event, Emitter<ForgetPasswordStates> emit) async {
    emit(LoadingState());
    try {
      var data = await forgetPasswordRepository.forgetPassword(
          username: event.username, password: event.password,verificationcode: event.verificationCode);
      emit(ForgetPasswordSuccessState(successMessage: data));
    } on Exception catch (e) {
      emit(ForgetPasswordFailureState(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  void _onForgetPasswordEmailButtonPressed(
      ForgetPasswordButtonEmailPressed event, Emitter<ForgetPasswordStates> emit) async {
    emit(LoadingState());
    try {
      var data = await forgetPasswordRepository.forgetPasswordEmail(
          username: event.username);
      emit(ForgetPasswordEmailSuccessState(successMessage: data));
    } on Exception catch (e) {
      emit(ForgetPasswordEmailFailureState(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

}